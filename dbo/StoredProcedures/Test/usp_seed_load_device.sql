-- =============================================================================
-- Stored Procedure: usp_seed_load_device
-- Purpose:  Load test data into dbo.device from dbo.zzz_seed_test_data_vehicle.
-- Scope:    Dev environments ONLY. Refuses to run on non-Dev servers.
-- Behavior: Flush-fill. Deletes all rows in dbo.device, then re-inserts.
--           Source rows are deduplicated by (tk_mu_data_rid, vehicle_rid).
--           Each device links to its asset via asset.vin = seed.truck_VIN.
--           Must run AFTER usp_seed_load_asset.
-- =============================================================================
CREATE PROCEDURE dbo.usp_seed_load_device
AS
BEGIN
    SET NOCOUNT ON;

    -- Guard: only allow on Dev servers
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_load_device may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
        RETURN;
    END;

    -- Flush-fill: clear existing data first
    DELETE FROM dbo.device;

    INSERT INTO dbo.device
    (
        -- device_uuid uses table default (NEWID())
        -- device_rid is IDENTITY
        device_name,
        device_type_code,
        created,
        tenant_id,
        asset_rid,
        asset_uuid,
        device_serial_number,
        device_software_version,
        logging_interval_rid_on_code,
        logging_interval_rid_off_code,
        deactivated_date,
        telematics_mode_type_code,
        activated_by_user_rid,
        deactivated_by_user_rid,
        updated_by_user_rid,
        updated,
        service_level_code,
        notes,
        auto_update_sent
    )
    SELECT
        CONCAT('Device for ', ISNULL(NULLIF(v.vehicle_name, 'NULL'), 'Unknown')) AS device_name,
        'DTP_BLUEBOX'                              AS device_type_code,            -- table default
        GETDATE()                                  AS created,
        -- tenant_id is currently NVARCHAR(50); cast UUID to string.
        CAST(xref.tenant_uuid AS NVARCHAR(50))     AS tenant_id,
        a.asset_rid                                AS asset_rid,
        a.asset_uuid                               AS asset_uuid,
        NULLIF(v.thermoking_serial_number, 'NULL') AS device_serial_number,
        NULL                                       AS device_software_version,
        NULL                                       AS logging_interval_rid_on_code,
        NULL                                       AS logging_interval_rid_off_code,
        NULL                                       AS deactivated_date,
        'TMT_TRACKING_MODE'                        AS telematics_mode_type_code,
        NULL                                       AS activated_by_user_rid,
        NULL                                       AS deactivated_by_user_rid,
        NULL                                       AS updated_by_user_rid,
        NULL                                       AS updated,
        NULL                                       AS service_level_code,
        NULL                                       AS notes,
        NULL                                       AS auto_update_sent
    FROM
    (
        -- Deduplicate source by (tk_mu_data_rid, vehicle_rid).
        SELECT
            tk_mu_data_rid,
            vehicle_rid,
            MAX(vehicle_name)             AS vehicle_name,
            MAX(truck_VIN)                AS truck_VIN,
            MAX(thermoking_serial_number) AS thermoking_serial_number,
            MAX(external_customer_id)     AS external_customer_id
        FROM dbo.zzz_seed_test_data_vehicle
        GROUP BY tk_mu_data_rid, vehicle_rid
    ) v
    INNER JOIN dbo.asset a
        ON a.vin = NULLIF(v.truck_VIN, 'NULL')   -- requires asset already loaded
    LEFT JOIN dbo.zzz_seed_test_data_tenant_xref xref
        ON xref.external_customer_id = NULLIF(v.external_customer_id, 'NULL')
    WHERE xref.tenant_uuid IS NOT NULL;          -- skip rows we can't map to a tenant

    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_device: inserted ', @rows, ' row(s) into dbo.device.');
END;
GO
