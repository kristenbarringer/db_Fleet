CREATE  procedure [dbo].[control_table_apu_max_rid]
AS

BEGIN

DECLARE @maxassetrid INT;
SELECT @maxassetrid = MAX(asset_rid)
FROM asset;
update control_table_apu set maxrid=@maxassetrid where  destinationTable = 'asset'

DECLARE @maxequipmentrid INT;
SELECT @maxequipmentrid = MAX(equipment_rid)
FROM equipment;
update control_table_apu set maxrid=@maxequipmentrid  where  destinationTable = 'equipment'

DECLARE @maxcontrollerrid INT;
SELECT @maxcontrollerrid = MAX(controller_rid)
FROM controller;
update control_table_apu set maxrid=@maxcontrollerrid where  destinationTable = 'controller'

DECLARE @maxdevicerid INT;
SELECT @maxdevicerid = MAX(device_rid)
FROM device;
update control_table_apu set maxrid=@maxdevicerid where  destinationTable = 'device'

/*Truncate the Table After migration is done - not required now*/
--TRUNCATE TABLE v1_asset_group;
--TRUNCATE TABLE v1_asset_group_mapping;
--TRUNCATE TABLE v1_user_asset_group_mapping;

END
GO

