CREATE   procedure [dbo].[rid_update_custom]
@pipeline_run_id nvarchar(100)
AS 
BEGIN
insert into equipment_device_mapping (equipment_rid,device_rid)
select equipment_rid,device_rid from asset_info WHERE pipeline_id = @pipeline_run_id;


update controller
set
controller.equipment_rid = asset_info.equipment_rid
from
asset_info inner join controller ON controller.controller_rid = asset_info.controller_rid
WHERE asset_info.pipeline_id = @pipeline_run_id;

update equipment
set
equipment.asset_rid = asset_info.asset_rid
from
asset_info inner join equipment ON equipment.equipment_rid = asset_info.equipment_rid
WHERE asset_info.pipeline_id = @pipeline_run_id;

EXEC [dbo].[asset_tenant_info_custom] --@pipeline_id = @pipeline_run_id;

update controller
set
controller.tenant_id = asset_tenant_info_table.tenant_id
from
asset_tenant_info_table inner join controller ON controller.controller_rid = asset_tenant_info_table.controller_rid
WHERE asset_tenant_info_table.pipeline_id = @pipeline_run_id;

update equipment
set
equipment.tenant_id = asset_tenant_info_table.tenant_id
from
asset_tenant_info_table  inner join equipment ON equipment.equipment_rid = asset_tenant_info_table.equipment_rid
WHERE asset_tenant_info_table.pipeline_id = @pipeline_run_id;
--select * from asset where asset_rid >646
--select * from asset_tenant_info_table where asset_rid in (select asset_rid from asset)

update device
set
device.tenant_id = asset_tenant_info_table.tenant_id
from
asset_tenant_info_table  inner join device ON device.device_rid = asset_tenant_info_table.device_rid
WHERE asset_tenant_info_table.pipeline_id = @pipeline_run_id;

update asset
set
asset.tenant_id = asset_tenant_info_table.tenant_id
from
asset_tenant_info_table  inner join asset ON asset.asset_rid = asset_tenant_info_table.asset_rid 
WHERE asset_tenant_info_table.pipeline_id = @pipeline_run_id;

end
GO

