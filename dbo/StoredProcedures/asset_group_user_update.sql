create  procedure [dbo].[asset_group_user_update]
  AS
  BEGIN

alter table asset_group
add v1_vehicle_group_rid int null

DECLARE @maxassetgrouprid INT;

SELECT @maxassetgrouprid = MAX(asset_group_rid)
FROM asset_group;

insert into asset_group(asset_group_name,tenant_id,v1_vehicle_group_rid) select vehicle_group,customer_rid,v1_vehicle_group_rid from v1_asset_group_reefer



 
update asset_group
set
asset_group.tenant_id = tenantinfo.tenant_id
from
tenantinfo inner join asset_group ON asset_group.tenant_id = tenantinfo.customer_rid and asset_group_rid>@maxassetgrouprid
  
alter table asset_group_mapping  nocheck constraint FK_asset_group_mapping_asset_group

DECLARE @maxassetgroupmappingrid INT;

SELECT @maxassetgroupmappingrid = MAX(mapping_rid)
FROM asset_group_mapping;
insert into asset_group_mapping(asset_rid,asset_group_rid)
select b.asset_rid,v1_vehicle_group_rid from v1_asset_group_mapping_reefer a, asset_info_reefer b where a.v1_vehicle_rid = b.v1_vehicle_rid -- where asset_rid>


update asset_group_mapping
set
asset_group_mapping.asset_group_rid = asset_group.asset_group_rid
from
asset_group inner join asset_group_mapping ON asset_group_mapping.asset_group_rid = asset_group.v1_vehicle_group_rid and mapping_rid>@maxassetgroupmappingrid

alter table asset_group_mapping  check constraint FK_asset_group_mapping_asset_group
--completed

DECLARE @user_asset_group_mapping_created datetime;

SET @user_asset_group_mapping_created =   getdate()
 --select * from user_asset_group_mapping where created>'2025-03-20 17:45:30.247'
alter table user_asset_group_mapping nocheck constraint all
insert into user_asset_group_mapping (user_rid,asset_group_rid,created) 
select v1_user_rid,v1_vehicle_group_rid,getdate() from v1_user_asset_group_mapping_reefer

update user_asset_group_mapping
set
user_asset_group_mapping.asset_group_rid = asset_group.asset_group_rid
from
asset_group inner join user_asset_group_mapping ON user_asset_group_mapping.asset_group_rid = asset_group.v1_vehicle_group_rid and user_asset_group_mapping.created>@user_asset_group_mapping_created

update user_asset_group_mapping
set
user_asset_group_mapping.user_rid= tenantinfo.v2_user_rid
from
tenantinfo inner join user_asset_group_mapping ON user_asset_group_mapping.user_rid = tenantinfo.user_rid and user_asset_group_mapping.created>@user_asset_group_mapping_created

alter table user_asset_group_mapping check constraint all

end
GO

