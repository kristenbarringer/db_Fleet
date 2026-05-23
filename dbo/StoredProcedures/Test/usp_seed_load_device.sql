-- =============================================================================
-- Stored Procedure: usp_seed_load_device
-- Purpose:  Generate fake test device data, one device per asset.
-- Scope:    Dev environments ONLY.
-- Behavior: Flush-fill. Deletes all rows in dbo.device, then re-inserts.
--           Reads from dbo.asset (which must be loaded first via
--           usp_seed_load_asset) and generates one device per asset.
--           Device fields are realistic-looking fake data:
--             - device_name like 'T-9876543'
--             - device_serial_number like 11-digit number string
--             - tenant_id and asset linkage copied from the parent asset
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
        -- Fake device_name: 'T-' + 7-digit number derived from asset_rid
        --   e.g. asset_rid=12 -> 'T-0000012'
        CONCAT('T-', RIGHT('0000000' + CAST(a.asset_rid AS NVARCHAR(10)), 7)) AS device_name,
        'DTP_BLUEBOX'                                                          AS device_type_code,
        GETDATE()                                                              AS created,
        a.tenant_id                                                            AS tenant_id,        -- copy from parent asset
        a.asset_rid                                                            AS asset_rid,
        a.asset_uuid                                                           AS asset_uuid,
        -- Fake serial number: 11-digit number derived from asset_rid
        --   e.g. asset_rid=12 -> '20260000012'
        CONCAT('2026', RIGHT('0000000' + CAST(a.asset_rid AS NVARCHAR(10)), 7)) AS device_serial_number,
        '2025.6.26.2'                                                          AS device_software_version,  -- typical version string
        NULL                                                                   AS logging_interval_rid_on_code,
        NULL                                                                   AS logging_interval_rid_off_code,
        NULL                                                                   AS deactivated_date,
        'TMT_TRACKING_MODE'                                                    AS telematics_mode_type_code,
        NULL                                                                   AS activated_by_user_rid,
        NULL                                                                   AS deactivated_by_user_rid,
        NULL                                                                   AS updated_by_user_rid,
        NULL                                                                   AS updated,
        NULL                                                                   AS service_level_code,
        NULL                                                                   AS notes,
        NULL                                                                   AS auto_update_sent
    FROM dbo.asset a;

    DECLARE @rows INT = @@ROWCOUNT;
    PRINT CONCAT('usp_seed_load_device: inserted ', @rows, ' row(s) into dbo.device.');
END;
GO
