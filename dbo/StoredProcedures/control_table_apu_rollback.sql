CREATE    procedure [dbo].[control_table_apu_rollback]
  AS
  BEGIN

 DECLARE @deletedevicerid INT;

SELECT @deletedevicerid = minrid
FROM control_table_apu where  destinationTable = 'device';

delete from device where device_rid > @deletedevicerid

 DECLARE @deleteequipmentrid INT;

SELECT @deleteequipmentrid = minrid
FROM control_table_apu where  destinationTable = 'equipment';

delete from equipment where equipment_rid > @deleteequipmentrid




 DECLARE @deletecontrollerrid INT;

SELECT @deletecontrollerrid = minrid
FROM control_table_apu where  destinationTable = 'controller';

delete from controller where controller_rid > @deletecontrollerrid

 DECLARE @deleteassetrid INT;

SELECT @deleteassetrid = minrid
FROM control_table_apu where  destinationTable = 'asset';

delete from asset where asset_rid > @deleteassetrid

  truncate table  asset_info

  --truncate table  tenantinfo
  truncate table v1_asset_group
  truncate table v1_asset_group_mapping
  truncate table v1_user_asset_group_mapping
end
GO

