CREATE   procedure [dbo].[rid_update]
  as 
  BEGIN
  insert into equipment_device_mapping (equipment_rid,device_rid)
	select equipment_rid,device_rid from asset_info;



update controller
set
controller.equipment_rid = asset_info.equipment_rid
from
asset_info inner join controller ON controller.controller_rid = asset_info.controller_rid

update equipment
set
equipment.asset_rid = asset_info.asset_rid
from
asset_info inner join equipment ON equipment.equipment_rid = asset_info.equipment_rid;

EXEC asset_tenant_info;

update controller
set
controller.tenant_id = asset_tenant_info_table.tenant_id
from
asset_tenant_info_table inner join controller ON controller.controller_rid = asset_tenant_info_table.controller_rid

update equipment
set
equipment.tenant_id = asset_tenant_info_table.tenant_id
from
asset_tenant_info_table  inner join equipment ON equipment.equipment_rid = asset_tenant_info_table.equipment_rid

select * from asset where asset_rid >646
select * from asset_tenant_info_table where asset_rid in (select asset_rid from asset)
update device
set
device.tenant_id = asset_tenant_info_table.tenant_id
from
asset_tenant_info_table  inner join device ON device.device_rid = asset_tenant_info_table.device_rid

update asset
set
asset.tenant_id = asset_tenant_info_table.tenant_id
from
asset_tenant_info_table  inner join asset ON asset.asset_rid = asset_tenant_info_table.asset_rid 

end
GO

