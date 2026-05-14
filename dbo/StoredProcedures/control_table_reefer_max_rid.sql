CREATE procedure [dbo].[control_table_reefer_max_rid]
    AS
    BEGIN
        DECLARE @maxassetrid INT;
        SELECT @maxassetrid = MAX(asset_rid)
        FROM asset;
        UPDATE control_table_reefer SET maxrid=@maxassetrid WHERE destinationTable = 'asset';

        DECLARE @maxequipmentrid INT;
        SELECT @maxequipmentrid = MAX(equipment_rid)
        FROM equipment;
        UPDATE control_table_reefer SET maxrid=@maxequipmentrid WHERE destinationTable = 'equipment';

        DECLARE @maxcontrollerrid INT;
        SELECT @maxcontrollerrid = MAX(controller_rid)
        FROM controller;
        UPDATE control_table_reefer SET maxrid=@maxcontrollerrid WHERE destinationTable = 'controller';

        DECLARE @maxdevicerid INT;
        SELECT @maxdevicerid = MAX(device_rid)
        FROM device;
        UPDATE control_table_reefer SET maxrid=@maxdevicerid WHERE destinationTable = 'device'
    END
GO

