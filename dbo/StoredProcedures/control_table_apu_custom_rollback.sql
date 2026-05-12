CREATE procedure [dbo].[control_table_apu_custom_rollback]
@pipeline_id nvarchar(100)
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
FROM control_table_apu where destinationTable = 'controller';
delete from controller where controller_rid > @deletecontrollerrid

DECLARE @deleteassetrid INT;
SELECT @deleteassetrid = minrid
FROM control_table_apu where  destinationTable = 'asset';
delete from asset where asset_rid > @deleteassetrid

DELETE FROM asset_info WHERE pipeline_id = @pipeline_id;

--truncate table tenantinfo
DELETE FROM  v1_asset_group WHERE pipeline_id = @pipeline_id;
DELETE FROM  v1_asset_group_mapping WHERE pipeline_id = @pipeline_id;
DELETE FROM  v1_user_asset_group_mapping WHERE pipeline_id = @pipeline_id;

END
GO

