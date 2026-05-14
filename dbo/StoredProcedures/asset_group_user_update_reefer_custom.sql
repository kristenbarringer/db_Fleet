CREATE  procedure [dbo].[asset_group_user_update_reefer_custom]
@pipeline_run_id nvarchar(100)
AS

BEGIN
    SET NOCOUNT ON;

    ------------------------------------------------------------
    -- 1. Capture current max asset_group_rid
    ------------------------------------------------------------
    DECLARE @maxassetgrouprid INT;

    SELECT @maxassetgrouprid = MAX(asset_group_rid)
    FROM asset_group;


    ------------------------------------------------------------
    -- 2. Insert new asset groups (skip duplicates)
    ------------------------------------------------------------
    INSERT INTO asset_group (asset_group_name, tenant_id, v1_vehicle_group_rid)
    SELECT vehicle_group, customer_rid, v1_vehicle_group_rid
    FROM v1_asset_group_reefer src
    WHERE src.pipeline_id = @pipeline_run_id
      AND NOT EXISTS (
        SELECT 1
        FROM asset_group tgt
        WHERE tgt.v1_vehicle_group_rid = src.v1_vehicle_group_rid
    );


    ------------------------------------------------------------
    -- 3. Update tenant_id for newly inserted asset groups
    ------------------------------------------------------------
    UPDATE ag
    SET ag.tenant_id = t.tenant_id
    FROM asset_group ag
    JOIN tenantinfo t ON ag.tenant_id = t.customer_rid
    WHERE ag.asset_group_rid > @maxassetgrouprid;


    ------------------------------------------------------------
    -- 4. Disable FK for asset_group_mapping
    ------------------------------------------------------------
    ALTER TABLE asset_group_mapping NOCHECK CONSTRAINT FK_asset_group_mapping_asset_group;


    ------------------------------------------------------------
    -- 5. Insert into asset_group_mapping (duplicate‑safe)
    ------------------------------------------------------------
    DECLARE @maxassetgroupmappingrid INT;

    SELECT @maxassetgroupmappingrid = MAX(mapping_rid)
    FROM asset_group_mapping;

    INSERT INTO asset_group_mapping (asset_rid, asset_group_rid)
    SELECT b.asset_rid, a.v1_vehicle_group_rid
    FROM v1_asset_group_mapping_reefer a
    JOIN asset_info_reefer b ON a.v1_vehicle_rid = b.v1_vehicle_rid
    WHERE a.pipeline_id = @pipeline_run_id
      AND NOT EXISTS (
        SELECT 1
        FROM asset_group_mapping m
        WHERE m.asset_rid = b.asset_rid
          AND m.asset_group_rid = a.v1_vehicle_group_rid
    );


    ------------------------------------------------------------
    -- 6. Update asset_group_mapping to new asset_group_rid
    ------------------------------------------------------------
    UPDATE m
    SET m.asset_group_rid = ag.asset_group_rid
    FROM asset_group_mapping m
    JOIN asset_group ag ON m.asset_group_rid = ag.v1_vehicle_group_rid
    WHERE m.mapping_rid > @maxassetgroupmappingrid;


    ------------------------------------------------------------
    -- 7. Re-enable FK
    ------------------------------------------------------------
    ALTER TABLE asset_group_mapping CHECK CONSTRAINT FK_asset_group_mapping_asset_group;


    ------------------------------------------------------------
    -- 8. Insert into user_asset_group_mapping (duplicate‑safe)
    ------------------------------------------------------------
    DECLARE @user_asset_group_mapping_created DATETIME = GETDATE();

    ALTER TABLE user_asset_group_mapping NOCHECK CONSTRAINT ALL;

    INSERT INTO user_asset_group_mapping (user_rid, asset_group_rid, created)
    SELECT v1_user_rid, v1_vehicle_group_rid, GETDATE()
    FROM v1_user_asset_group_mapping_reefer src
    WHERE src.pipeline_id = @pipeline_run_id
      AND NOT EXISTS (
        SELECT 1
        FROM user_asset_group_mapping tgt
        WHERE tgt.user_rid = src.v1_user_rid
          AND tgt.asset_group_rid = src.v1_vehicle_group_rid
    );


    ------------------------------------------------------------
    -- 9. Update asset_group_rid to new values
    ------------------------------------------------------------
    UPDATE u
    SET u.asset_group_rid = ag.asset_group_rid
    FROM user_asset_group_mapping u
    JOIN asset_group ag ON u.asset_group_rid = ag.v1_vehicle_group_rid
    WHERE u.created > @user_asset_group_mapping_created;


    ------------------------------------------------------------
    -- 10. Update user_rid to v2_user_rid
    ------------------------------------------------------------
    UPDATE u
    SET u.user_rid = t.v2_user_rid
    FROM user_asset_group_mapping u
    JOIN tenantinfo t ON u.user_rid = t.user_rid
    WHERE u.created > @user_asset_group_mapping_created;


    ------------------------------------------------------------
    -- 11. Re-enable constraints
    ------------------------------------------------------------
    ALTER TABLE user_asset_group_mapping CHECK CONSTRAINT ALL;

END;
GO

