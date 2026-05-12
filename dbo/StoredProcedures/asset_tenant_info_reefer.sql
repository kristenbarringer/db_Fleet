CREATE procedure [dbo].[asset_tenant_info_reefer]
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
		tenant_id nvarchar(100)
    );



insert into #asset_tenant_info_table_reefer(vehicle_rid,customer_rid,vehicle_group_rid,v1_vehicle_rid,asset_rid,equipment_rid,controller_rid,device_rid,tenant_id)
select a.vehicle_rid,a.customer_rid,a.vehicle_group_rid,a.v1_vehicle_rid,a.asset_rid,a.equipment_rid,a.controller_rid,a.device_rid,a.customer_rid from asset_info_reefer a

update #asset_tenant_info_table_reefer
set #asset_tenant_info_table_reefer.tenant_id = tenantinfo.tenant_id
from 
tenantinfo inner join #asset_tenant_info_table_reefer ON #asset_tenant_info_table_reefer.customer_rid = tenantinfo.customer_rid

update #asset_tenant_info_table_reefer
set #asset_tenant_info_table_reefer.tenant_id = 0 where tenant_id is null

select * into asset_tenant_info_table_reefer from #asset_tenant_info_table_reefer
--select a.vehicle_rid,a.customer_rid,a.vehicle_group_rid,a.v1_vehicle_rid,a.asset_rid,a.equipment_rid,a.controller_rid,a.device_rid,b.tenant_id from asset_info_reefer a left join tenantinfo b ON a.customer_rid = b.customer_rid
end
GO

