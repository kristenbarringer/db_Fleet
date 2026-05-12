CREATE procedure [dbo].[asset_tenant_info_reefer_custom]
  @pipeline_run_id nvarchar(100)
  as 
  BEGIN	
	
	DROP TABLE IF EXISTS asset_tenant_info_table_reefer
	DROP TABLE IF EXISTS #asset_tenant_info_table_reefer

	CREATE TABLE #asset_tenant_info_table_reefer (
		vehicle_rid INT,
        customer_rid INT,
        vehicle_group_rid INT,
		v1_vehicle_rid INT,
        asset_rid INT,
        equipment_rid INT,
		controller_rid INT,
		device_rid INT,
		tenant_id nvarchar(100),
        pipeline_id nvarchar(100)
    );



INSERT INTO #asset_tenant_info_table_reefer(vehicle_rid,customer_rid,vehicle_group_rid,v1_vehicle_rid,asset_rid,equipment_rid,controller_rid,device_rid,tenant_id, pipeline_id)
SELECT a.vehicle_rid,a.customer_rid,a.vehicle_group_rid,a.v1_vehicle_rid,a.asset_rid,a.equipment_rid,a.controller_rid,a.device_rid,a.customer_rid, a.pipeline_id
FROM asset_info_reefer a
WHERE pipeline_id = @pipeline_run_id;

UPDATE #asset_tenant_info_table_reefer
SET #asset_tenant_info_table_reefer.tenant_id = tenantinfo.tenant_id
FROM 
tenantinfo INNER JOIN #asset_tenant_info_table_reefer ON #asset_tenant_info_table_reefer.customer_rid = tenantinfo.customer_rid

UPDATE #asset_tenant_info_table_reefer
SET #asset_tenant_info_table_reefer.tenant_id = 0 WHERE tenant_id IS NULL;

SELECT * INTO asset_tenant_info_table_reefer FROM #asset_tenant_info_table_reefer;
--select a.vehicle_rid,a.customer_rid,a.vehicle_group_rid,a.v1_vehicle_rid,a.asset_rid,a.equipment_rid,a.controller_rid,a.device_rid,b.tenant_id from asset_info_reefer a left join tenantinfo b ON a.customer_rid = b.customer_rid
end
GO

