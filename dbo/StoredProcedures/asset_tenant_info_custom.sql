CREATE procedure [dbo].[asset_tenant_info_custom]
  --@pipeline_id nvarchar(100)
  as 
  BEGIN	
	
	DROP TABLE IF EXISTS asset_tenant_info_table
	CREATE TABLE asset_tenant_info_table (
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



insert into asset_tenant_info_table(vehicle_rid,customer_rid,vehicle_group_rid,v1_vehicle_rid,asset_rid,equipment_rid,controller_rid,device_rid,tenant_id, pipeline_id)
select a.vehicle_rid,a.customer_rid,a.vehicle_group_rid,a.v1_vehicle_rid,a.asset_rid,a.equipment_rid,a.controller_rid,a.device_rid,b.tenant_id,a.pipeline_id from asset_info a 
left join tenantinfo b ON a.customer_rid = b.customer_rid AND b.Pipeline_Id ='bee9902b-d23a-4e5d-bc8a-abc527fadaa2';
end
GO

