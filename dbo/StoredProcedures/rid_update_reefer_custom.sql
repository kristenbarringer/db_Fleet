CREATE procedure [dbo].[rid_update_reefer_custom]
  @pipeline_run_id nvarchar(100)
as
BEGIN
  print 'TODO FIX THIS'
/* TODO FIX THIS
    INSERT INTO equipment_device_mapping (equipment_rid,device_rid)
	SELECT equipment_rid,device_rid from asset_info_reefer;


    UPDATE controller
    SET
    controller.equipment_rid = asset_info_reefer.equipment_rid
    FROM
    asset_info_reefer INNER JOIN controller ON controller.controller_rid = asset_info_reefer.controller_rid 
    WHERE asset_info_reefer.pipeline_id = @pipeline_run_id;

    UPDATE equipment
    SET
    equipment.asset_rid = asset_info_reefer.asset_rid
    FROM
    asset_info_reefer INNER JOIN equipment ON equipment.equipment_rid = asset_info_reefer.equipment_rid
    WHERE asset_info_reefer.pipeline_id = @pipeline_run_id;

    EXEC asset_tenant_info_reefer_custom @pipeline_id = @pipeline_run_id;

    UPDATE controller
    SET
    controller.tenant_id = asset_tenant_info_table_reefer.tenant_id
    FROM
    asset_tenant_info_table_reefer INNER JOIN controller ON controller.controller_rid = asset_tenant_info_table_reefer.controller_rid
    WHERE asset_tenant_info_table_reefer.pipeline_id = @pipeline_run_id;

    UPDATE equipment
    SET
    equipment.tenant_id = asset_tenant_info_table_reefer.tenant_id
    FROM
    asset_tenant_info_table_reefer INNER JOIN equipment ON equipment.equipment_rid = asset_tenant_info_table_reefer.equipment_rid
    WHERE asset_tenant_info_table_reefer.pipeline_id = @pipeline_run_id;

    UPDATE device
    SET
    device.tenant_id = asset_tenant_info_table_reefer.tenant_id
    FROM
    asset_tenant_info_table_reefer INNER JOIN device ON device.device_rid = asset_tenant_info_table_reefer.device_rid
    WHERE asset_tenant_info_table_reefer.pipeline_id = @pipeline_run_id;

    UPDATE asset
    SET
    asset.tenant_id = asset_tenant_info_table_reefer.tenant_id
    FROM
    asset_tenant_info_table_reefer INNER JOIN asset ON asset.asset_rid = asset_tenant_info_table_reefer.asset_rid
    WHERE asset_tenant_info_table_reefer.pipeline_id = @pipeline_run_id;
*/
END
GO

