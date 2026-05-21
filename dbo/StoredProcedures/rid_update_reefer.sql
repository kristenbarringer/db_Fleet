CREATE procedure [dbo].[rid_update_reefer]
as
BEGIN
  print 'TODO FIX THIS'
/* TODO FIX THIS
  insert into equipment_device_mapping (equipment_rid,device_rid)
	select equipment_rid,device_rid from asset_info_reefer;



update controller
set
controller.equipment_rid = asset_info_reefer.equipment_rid
from
asset_info_reefer inner join controller ON controller.controller_rid = asset_info_reefer.controller_rid

update equipment
set
equipment.asset_rid = asset_info_reefer.asset_rid
from
asset_info_reefer inner join equipment ON equipment.equipment_rid = asset_info_reefer.equipment_rid;

EXEC asset_tenant_info_reefer;


update controller
set
controller.tenant_id = asset_tenant_info_table_reefer.tenant_id
from
asset_tenant_info_table_reefer inner join controller ON controller.controller_rid = asset_tenant_info_table_reefer.controller_rid






update equipment
set
equipment.tenant_id = asset_tenant_info_table_reefer.tenant_id
from
asset_tenant_info_table_reefer  inner join equipment ON equipment.equipment_rid = asset_tenant_info_table_reefer.equipment_rid


update device
set
device.tenant_id = asset_tenant_info_table_reefer.tenant_id
from
asset_tenant_info_table_reefer  inner join device ON device.device_rid = asset_tenant_info_table_reefer.device_rid

update asset
set
asset.tenant_id = asset_tenant_info_table_reefer.tenant_id
from
asset_tenant_info_table_reefer  inner join asset ON asset.asset_rid = asset_tenant_info_table_reefer.asset_rid 
*/
end
GO

