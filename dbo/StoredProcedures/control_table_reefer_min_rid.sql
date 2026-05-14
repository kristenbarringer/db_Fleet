CREATE procedure [dbo].[control_table_reefer_min_rid]
  AS
    BEGIN
        DECLARE @minassetrid INT;
        SELECT @minassetrid = MAX(asset_rid)
        FROM asset;
        UPDATE control_table_reefer SET minrid=@minassetrid WHERE destinationTable = 'asset';

        DECLARE @minequipmentrid INT;
        SELECT @minequipmentrid = MAX(equipment_rid)
        FROM equipment;
        UPDATE control_table_reefer SET minrid=@minequipmentrid WHERE destinationTable = 'equipment';

        DECLARE @mincontrollerrid INT;
        SELECT @mincontrollerrid = MAX(controller_rid)
        FROM controller;
        UPDATE control_table_reefer SET minrid=@mincontrollerrid WHERE destinationTable = 'controller';

        DECLARE @mindevicerid INT;
        SELECT @mindevicerid = MAX(device_rid)
        FROM device;
        UPDATE control_table_reefer SET minrid=@mindevicerid WHERE destinationTable = 'device';

    END
GO

