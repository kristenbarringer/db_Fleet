CREATE  procedure [dbo].[control_table_reefer_rollback]
    AS
        BEGIN
            DECLARE @deletedevicerid INT;
            SELECT @deletedevicerid = minrid
            FROM control_table_reefer where  destinationTable = 'device';

            DELETE FROM device WHERE device_rid > @deletedevicerid;

            DECLARE @deleteequipmentrid INT;
            SELECT @deleteequipmentrid = minrid
            FROM control_table_reefer where  destinationTable = 'equipment';

            DELETE FROM equipment WHERE equipment_rid > @deleteequipmentrid;


            DECLARE @deletecontrollerrid INT;
            SELECT @deletecontrollerrid = minrid
            FROM control_table_reefer where  destinationTable = 'controller';

            DELETE FROM controller WHERE controller_rid > @deletecontrollerrid;

            DECLARE @deleteassetrid INT;
            SELECT @deleteassetrid = minrid
            FROM control_table_reefer where  destinationTable = 'asset';

            DELETE FROM asset WHERE asset_rid > @deleteassetrid;

            TRUNCATE TABLE asset_info_reefer;
            --TRUNCATE TABLE tenantinfo;
            TRUNCATE TABLE v1_asset_group_reefer;
            TRUNCATE TABLE v1_asset_group_mapping_reefer;
            TRUNCATE TABLE v1_user_asset_group_mapping_reefer;
        END
GO

