-- =============================================================================
-- Stored Procedure: usp_seed_load_asset
-- Purpose:  Load test data into dbo.asset from dbo.zzz_seed_test_data_vehicle.
-- Scope:    Dev environments ONLY. Refuses to run on non-Dev servers.
-- Behavior: Flush-fill. Deletes all rows in dbo.asset, then re-inserts.
--           Source rows are deduplicated by (tk_mu_data_rid, vehicle_rid).
--           Tenant is resolved via dbo.zzz_seed_test_data_tenant_xref using
--           customer_rid as the join key.
-- =============================================================================
CREATE PROCEDURE dbo.usp_seed_load_asset
AS
BEGIN
    SET NOCOUNT ON;

    -- Guard: only allow on Dev servers
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_load_asset may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
        RETURN;
    END;

    -- Flush-fill: clear existing data first
    DELETE FROM dbo.asset;

    INSERT INTO dbo.asset
    (
        -- asset_uuid uses table default (NEWID())
        -- asset_rid is IDENTITY
        tenant_id,
        asset_name,
        description,
        make,
        model,
        year,
        vin,
        fuel_tank_size,
        asset_type_code,
        power_source_code,
        asset_icon_code,
        asset_usage_code,
        activation_status_code,
        billing_service_level_code,
        active,
        door_sensor_1,
        door_sensor_2,
        door_sensor_3,
        cargowatch_download,
        servicewatch_download,
        [lock],
        created,
        updated,
        activated,
        replacement_date,
        user_activation,
        created_by_user_rid,
        notes,
        additional_notes,
        account_additional_notes
    )
    SELECT
        -- tenant_id is currently NVARCHAR(50); cast UUID to string.
        -- When tenant_id is migrated to UNIQUEIDENTIFIER, remove the CAST.
        CAST(xref.tenant_uuid AS NVARCHAR(50))      AS tenant_id,
        NULLIF(v.vehicle_name, 'NULL')              AS asset_name,
        'TrackingV1Asset'                           AS description,                -- table default
        NULL                                        AS make,
        NULL                                        AS model,
        NULL                                        AS year,
        NULLIF(v.truck_VIN, 'NULL')                 AS vin,
        TRY_CAST(NULLIF(v.fuel_tank_size, 'NULL') AS FLOAT) AS fuel_tank_size,
        'AST_TRUCK'                                 AS asset_type_code,            -- TODO: derive from seed later
        lc_power.code                               AS power_source_code,
        NULL                                        AS asset_icon_code,
        NULL                                        AS asset_usage_code,
        'AAS_ACTIVATED'                             AS activation_status_code,     -- table default
        NULL                                        AS billing_service_level_code,
        1                                           AS active,
        NULL                                        AS door_sensor_1,
        NULL                                        AS door_sensor_2,
        NULL                                        AS door_sensor_3,
        NULL                                        AS cargowatch_download,
        NULL                                        AS servicewatch_download,
        NULL                                        AS [lock],
        GETDATE()                                   AS created,
        NULL                                        AS updated,
        NULL                                        AS activated,
        NULL                                        AS replacement_date,
        NULL                                        AS user_activation,
        1                                           AS created_by_user_rid,        -- table default
        NULL                                        AS notes,
        NULL                                        AS additional_notes,
        NULL                                        AS account_additional_notes
    FROM
    (
        -- Deduplicate source by (tk_mu_data_rid, vehicle_rid).
        SELECT
            tk_mu_data_rid,
            vehicle_rid,
            MAX(vehicle_name)   AS vehicle_name,
            MAX(truck_VIN)      AS truck_VIN,
            MAX(fuel_tank_size) AS fuel_tank_size,
            MAX(power_source)   AS power_source,
            MAX(customer_rid)   AS customer_rid
        FROM dbo.zzz_seed_test_data_vehicle
        GROUP BY tk_mu_data_rid, vehicle_rid
    ) v
    LEFT JOIN dbo.lookup_code lc_power
        ON  lc_power.lookup_list_code             = 'power_source'
        AND lc_power.code_without_prefix_all_caps = NULLIF(v.power_source, 'NULL')
    LEFT JOIN dbo.zzz_seed_test_data_tenant_xref xref
        ON xref.customer_rid = v.customer_rid
    WHERE xref.tenant_uuid IS NOT NULL;  -- skip seed rows we can't map to a tenant

    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_asset: inserted ', @rows, ' row(s) into dbo.asset.');
END;
GO
