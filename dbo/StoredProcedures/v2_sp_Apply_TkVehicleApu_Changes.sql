
CREATE     PROCEDURE [dbo].[v2_sp_Apply_TkVehicleApu_Changes]
AS

BEGIN
   SET NOCOUNT ON;
   SET XACT_ABORT ON;   

   BEGIN TRAN;

       CREATE TABLE #AssetMap (Vehicle_rid INT PRIMARY KEY, Asset_rid INT);
       CREATE TABLE #EquipmentMap (Vehicle_rid INT PRIMARY KEY, Equipment_rid INT);
       CREATE TABLE #ControllerMap (Vehicle_rid INT PRIMARY KEY, Controller_rid INT);
       CREATE TABLE #DeviceMap (Vehicle_rid INT PRIMARY KEY, Device_rid INT);
       CREATE TABLE #UnallocatedGroup( Asset_Group_rid INT,tenant_rid nvarchar(255));

       INSERT INTO [dbo].[asset] (
           asset_name,
           active,
           created,
           tenant_id,
           asset_type_rid,
           created_by_user_rid,
           vin,
           activation_status_rid
       )
       SELECT
           JSON_VALUE(v.NewData,'$.vehicle_name'),
           JSON_VALUE(v.NewData,'$.active'),
           SYSDATETIME(),
           JSON_VALUE(v.NewData,'$.customer_rid'),
           1,
           JSON_VALUE(v.NewData,'$.last_modified_by_user_rid'),
           JSON_VALUE(v.NewData,'$.truck_vin'),
           1
       FROM dbo.Vehicle_ChangeLog v
       WHERE v.ChangeType = 'INSERT'
         AND v.Processed = 0
         AND NOT EXISTS (
             SELECT 1
             FROM dbo.asset_info m
             WHERE m.vehicle_rid = v.Vehicle_rid
         );

        INSERT INTO #AssetMap
        SELECT
            v.Vehicle_rid,
            a.asset_rid
        FROM dbo.Vehicle_ChangeLog v
        JOIN dbo.asset a
            ON a.asset_name = JSON_VALUE(v.NewData,'$.vehicle_name')
        WHERE v.ChangeType = 'INSERT'
            AND v.Processed = 0;

        /* Inserting the asset_group_mapping data - Need to handle for unallocated */
        --INSERT INTO #UnallocatedGroup
        --SELECT am.asset_rid, ag.asset_group_rid, vcl.Vehicle_rid
        --FROM asset_group_mapping AS agm
        --JOIN #AssetMap AS am ON agm.asset_rid = am.asset_rid
        --JOIN Vehicle_ChangeLog AS vcl ON vcl.Vehicle_rid = am.Vehicle_rid
        --JOIN tenantinfo AS tenant ON tenant.customer_rid = CAST(JSON_VALUE(vcl.NewData,'$.customer_rid') AS NVARCHAR(255)) 
        --JOIN asset_group AS ag ON ag.tenant_id = tenant.tenant_id WHERE ag.asset_group_name ='unallocated';
       
        INSERT INTO #UnallocatedGroup
        SELECT ag.asset_group_rid, tenant.tenant_id FROM asset_group AS ag JOIN
        tenantinfo as tenant ON ag.tenant_id = tenant.tenant_id JOIN
        Vehicle_ChangeLog AS vcl ON CAST(JSON_VALUE(vcl.NewData,'$.customer_rid') AS NVARCHAR(255)) = tenant.customer_rid
        WHERE ag.asset_group_name ='unallocated' GROUP BY ag.asset_group_rid,tenant.tenant_id;


        -- inserting assert group id (unallocated) when vehicle_group_rid is null in V1
        INSERT INTO asset_group_mapping(asset_rid, asset_group_rid, created)
        SELECT assetmap.Asset_rid, uag.Asset_Group_rid ,SYSDATETIME() 
        FROM dbo.asset_group AS ag 
        LEFT JOIN dbo.Vehicle_ChangeLog vcl ON ag.v1_vehicle_group_rid = JSON_VALUE(vcl.NewData,'$.vehicle_group_rid')
        INNER JOIN #AssetMap AS assetmap ON assetmap.Vehicle_rid=vcl.Vehicle_rid 
        INNER JOIN dbo.asset_info as ai ON assetmap.asset_rid = ai.asset_rid AND vcl.Vehicle_rid =ai.v1_vehicle_rid
        INNER JOIN #UnallocatedGroup AS uag ON ag.tenant_id = uag.tenant_rid  
        WHERE ag.asset_group_rid IS NULL AND vcl.ChangeType = 'INSERT' AND vcl.Processed = 0;
        
        ---- updating the unallocated group id for the customer
        --UPDATE agm
        --SET agm.asset_group_rid = ag.asset_group_rid
        --FROM asset_group_mapping AS agm
        --JOIN #AssetMap AS am ON agm.asset_rid = am.asset_rid
        --JOIN Vehicle_ChangeLog AS vcl ON vcl.Vehicle_rid = am.Vehicle_rid
        --JOIN tenantinfo AS tenant ON tenant.customer_rid = CAST(JSON_VALUE(vcl.NewData,'$.customer_rid') AS NVARCHAR(255)) 
        --JOIN asset_group AS ag ON ag.tenant_id = tenant.tenant_id WHERE ag.asset_group_name ='unallocated';
                
        -- inserting asset group mapping data when asset group is available
        INSERT INTO asset_group_mapping(asset_rid, asset_group_rid, created)
        SELECT assetmap.Asset_rid, ag.asset_group_rid,SYSDATETIME() 
        FROM dbo.asset_group AS ag 
        INNER JOIN dbo.Vehicle_ChangeLog vcl ON ag.v1_vehicle_group_rid= JSON_VALUE(vcl.NewData,'$.vehicle_group_rid')
        INNER JOIN #AssetMap AS assetmap ON assetmap.Vehicle_rid=vcl.Vehicle_rid
        INNER JOIN dbo.asset_info as ai ON assetmap.asset_rid = ai.asset_rid AND vcl.Vehicle_rid =ai.v1_vehicle_rid
        WHERE vcl.ChangeType = 'INSERT' AND vcl.Processed = 0;



       INSERT INTO dbo.equipment (
           equipment_name,
           equipment_type_rid,
           created,
           tenant_id,
           asset_rid,
           warranty_start_date,
           warranty_end_date,
           is_reported,
           visibility
       )
       SELECT
           JSON_VALUE(v.NewData,'$.vehicle_name'),
           1,
           SYSDATETIME(),
           JSON_VALUE(v.NewData,'$.customer_rid'),
           a.Asset_rid,
           JSON_VALUE(v.NewData,'$.warranty_start_date'),
           JSON_VALUE(v.NewData,'$.warranty_end_date'),
           1,
           1
       FROM dbo.Vehicle_ChangeLog v
       JOIN #AssetMap a ON a.Vehicle_rid = v.Vehicle_rid;

       INSERT INTO #EquipmentMap
       SELECT
           v.Vehicle_rid,
           e.equipment_rid
       FROM dbo.Vehicle_ChangeLog v
       JOIN dbo.equipment e
           ON e.asset_rid = (SELECT Asset_rid FROM #AssetMap WHERE Vehicle_rid = v.Vehicle_rid)
       WHERE v.ChangeType = 'INSERT'
         AND v.Processed = 0;

       INSERT INTO dbo.controller (
           controller_name,
           controller_type_rid,
           created,
           tenant_id,
           equipment_rid,
           controller_serial_number,
           controller_software_version
       )
       SELECT
           JSON_VALUE(v.NewData,'$.vehicle_name'),
           1,
           SYSDATETIME(),
           JSON_VALUE(v.NewData,'$.customer_rid'),
           e.Equipment_rid,
           JSON_VALUE(v.NewData,'$.controller_serial_number'),
           JSON_VALUE(v.NewData,'$.controller_serial_version')
       FROM dbo.Vehicle_ChangeLog v
       JOIN #EquipmentMap e ON e.Vehicle_rid = v.Vehicle_rid;

       INSERT INTO #ControllerMap
       SELECT
           v.Vehicle_rid,
           c.controller_rid
       FROM dbo.Vehicle_ChangeLog v
       JOIN dbo.controller c
           ON c.equipment_rid = (SELECT Equipment_rid FROM #EquipmentMap WHERE Vehicle_rid = v.Vehicle_rid)
       WHERE v.ChangeType = 'INSERT'
         AND v.Processed = 0;

       INSERT INTO dbo.device (
           device_name,
           device_type_rid,
           created,
           tenant_id,
           device_serial_number,
           device_software_version,
           sim_number,
           logging_interval_rid_on,
           logging_interval_rid_off,
           telematics_mode_type_rid,
           gsm_provider_type_rid
       )
       SELECT
           JSON_VALUE(v.NewData,'$.vehicle_name'),
           1,
           SYSDATETIME(),
           JSON_VALUE(v.NewData,'$.customer_rid'),
           JSON_VALUE(v.NewData,'$.telematics_serial_number'),
           JSON_VALUE(v.NewData,'$.telematics_serial_version'),
           JSON_VALUE(v.NewData,'$.sim_number'),
           JSON_VALUE(v.NewData,'$.logging_interval_rid_on'),
           JSON_VALUE(v.NewData,'$.logging_interval_rid_off'),
           JSON_VALUE(v.NewData,'$.telematics_mode_type_rid'),
           1
       FROM dbo.Vehicle_ChangeLog v
       WHERE v.ChangeType = 'INSERT'
         AND v.Processed = 0;

       INSERT INTO #DeviceMap
       SELECT
           v.Vehicle_rid,
           d.device_rid
       FROM dbo.Vehicle_ChangeLog v
       JOIN dbo.device d
           ON d.device_serial_number = JSON_VALUE(v.NewData,'$.telematics_serial_number')
       WHERE v.ChangeType = 'INSERT'
         AND v.Processed = 0;

       INSERT INTO dbo.equipment_device_mapping (equipment_rid, device_rid, created)
       SELECT
           e.Equipment_rid,
           d.Device_rid,
           SYSDATETIME()
       FROM #EquipmentMap e
       JOIN #DeviceMap d ON d.Vehicle_rid = e.Vehicle_rid;

       INSERT INTO dbo.asset_info (
           vehicle_rid,
           asset_rid,
           equipment_rid,
           controller_rid,
           device_rid
       )
       SELECT
           a.Vehicle_rid,
           a.Asset_rid,
           e.Equipment_rid,
           c.Controller_rid,
           d.Device_rid
       FROM #AssetMap a
       JOIN #EquipmentMap e ON e.Vehicle_rid = a.Vehicle_rid
       JOIN #ControllerMap c ON c.Vehicle_rid = a.Vehicle_rid
       JOIN #DeviceMap d ON d.Vehicle_rid = a.Vehicle_rid;


       DECLARE
           @Vehicle_rid INT,           
           @NewData NVARCHAR(MAX),
           @OldData NVARCHAR(MAX),
           @SetClause NVARCHAR(MAX),
           @Sql NVARCHAR(MAX);
       DECLARE cur CURSOR LOCAL FOR
           SELECT 
           Vehicle_rid, 
           NewData,
           OldData
           FROM dbo.Vehicle_ChangeLog
           WHERE ChangeType = 'UPDATE'
             AND Processed = 0;
       OPEN cur;
       FETCH NEXT FROM cur INTO @Vehicle_rid, @NewData, @OldData;
       WHILE @@FETCH_STATUS = 0
       BEGIN
           SELECT @SetClause = STRING_AGG(
               QUOTENAME(target_column) + ' = JSON_VALUE(@NewData, ''$.' + vehicle_column + ''')',
               ', '
           )
           FROM dbo.vehicle_column_mapping
           WHERE target_table = 'asset';
           IF @SetClause IS NOT NULL
           BEGIN
               SET @Sql = N'
                   UPDATE a SET ' + @SetClause + '
                   FROM dbo.asset a
                   JOIN dbo.asset_info m ON m.asset_rid = a.asset_rid
                   WHERE m.vehicle_rid = @Vehicle_rid';
               EXEC sp_executesql @Sql,
                   N'@Vehicle_rid INT, @NewData NVARCHAR(MAX)',
                   @Vehicle_rid, @NewData;
           END

            DECLARE @old_asset_grp_id int;            
            SELECT @old_asset_grp_id = asset_group_rid FROM dbo.asset_group WHERE v1_vehicle_group_rid =JSON_VALUE(@OldData,'$.vehicle_group_rid');
            
            /* deleting the existing mapping when group moved to another */
            IF (JSON_VALUE(@NewData,'$.vehicle_group_rid') <> JSON_VALUE(@OldData,'$.vehicle_group_rid'))
                DELETE agm FROM dbo.asset_group_mapping AS agm 
                JOIN dbo.asset_info AS ai ON agm.asset_rid=ai.asset_rid WHERE agm.asset_group_rid = @old_asset_grp_id AND ai.v1_vehicle_rid = @Vehicle_rid;

            DECLARE @asset_grp_id int;
           
            SELECT @asset_grp_id = asset_group_rid FROM dbo.asset_group WHERE v1_vehicle_group_rid =JSON_VALUE(@NewData,'$.vehicle_group_rid');

            IF (@asset_grp_id IS NOT NULL)
                IF NOT EXISTS(
                       SELECT 1 FROM dbo.asset_group_mapping AS agm INNER JOIN       
                                     dbo.asset_info AS ai ON agm.asset_rid = ai.asset_rid 
                       WHERE ai.vehicle_rid = @Vehicle_rid AND agm.asset_group_rid = @asset_grp_id)

                    BEGIN
                        
                        INSERT INTO asset_group_mapping(asset_rid, asset_group_rid, created)
                                    SELECT assetmap.asset_rid,  @asset_grp_id ,SYSDATETIME() 
                                    FROM dbo.asset_info AS assetmap WHERE assetmap.Vehicle_rid=@Vehicle_rid;
                        
                    END

            IF (@asset_grp_id IS NULL)
                BEGIN
                    INSERT INTO asset_group_mapping(asset_rid, asset_group_rid, created)
                                    SELECT ast.asset_rid, uag.Asset_Group_rid,SYSDATETIME() 
                                    FROM dbo.asset AS ast
                                    JOIN #UnallocatedGroup AS uag ON ast.tenant_id =uag.tenant_rid
                                    JOIN dbo.asset_info as ai ON  ai.asset_rid = ast.asset_rid AND ai.v1_vehicle_rid=@Vehicle_rid;                                  
                                    

                END

           SELECT @SetClause = STRING_AGG(
               QUOTENAME(target_column) + ' = JSON_VALUE(@NewData, ''$.' + vehicle_column + ''')',
               ', '
           )
           FROM dbo.vehicle_column_mapping
           WHERE target_table = 'equipment';
           IF @SetClause IS NOT NULL
           BEGIN
               SET @Sql = N'
                   UPDATE e SET ' + @SetClause + '
                   FROM dbo.equipment e
                   JOIN dbo.asset_info m ON m.equipment_rid = e.equipment_rid
                   WHERE m.vehicle_rid = @Vehicle_rid';
               EXEC sp_executesql @Sql,
                   N'@Vehicle_rid INT, @NewData NVARCHAR(MAX)',
                   @Vehicle_rid, @NewData;
           END
           SELECT @SetClause = STRING_AGG(
               QUOTENAME(target_column) + ' = JSON_VALUE(@NewData, ''$.' + vehicle_column + ''')',
               ', '
           )
           FROM dbo.vehicle_column_mapping
           WHERE target_table = 'controller';
           IF @SetClause IS NOT NULL
           BEGIN
               SET @Sql = N'
                   UPDATE c SET ' + @SetClause + '
                   FROM dbo.controller c
                   JOIN dbo.asset_info m ON m.controller_rid = c.controller_rid
                   WHERE m.vehicle_rid = @Vehicle_rid';
               EXEC sp_executesql @Sql,
                   N'@Vehicle_rid INT, @NewData NVARCHAR(MAX)',
                   @Vehicle_rid, @NewData;
           END
           SELECT @SetClause = STRING_AGG(
               QUOTENAME(target_column) + ' = JSON_VALUE(@NewData, ''$.' + vehicle_column + ''')',
               ', '
           )
           FROM dbo.vehicle_column_mapping
           WHERE target_table = 'device';
           IF @SetClause IS NOT NULL
           BEGIN
               SET @Sql = N'
                   UPDATE d SET ' + @SetClause + '
                   FROM dbo.device d
                   JOIN dbo.asset_info m ON m.device_rid = d.device_rid
                   WHERE m.vehicle_rid = @Vehicle_rid';
               EXEC sp_executesql @Sql,
                   N'@Vehicle_rid INT, @NewData NVARCHAR(MAX)',
                   @Vehicle_rid, @NewData;
           END
           UPDATE dbo.Vehicle_ChangeLog
           SET Processed = 1,
               ProcessedAt = SYSDATETIME()
           WHERE Vehicle_rid = @Vehicle_rid
             AND ChangeType = 'UPDATE';
           FETCH NEXT FROM cur INTO @Vehicle_rid, @NewData, @OldData;
       END
       CLOSE cur;
       DEALLOCATE cur;

       /* Updating the tenant id based on customer id */
        UPDATE asset SET asset.tenant_id=tenant.tenant_id FROM dbo.asset AS asset INNER JOIN
        [dbo].[tenantinfo] as tenant ON asset.tenant_id = CAST(tenant.customer_rid AS NVARCHAR(255));

        UPDATE equip SET equip.tenant_id=tenant.tenant_id FROM dbo.equipment AS equip INNER JOIN
        [dbo].[tenantinfo] as tenant ON equip.tenant_id =  CAST(tenant.customer_rid AS NVARCHAR(255));

        UPDATE device SET device.tenant_id=tenant.tenant_id FROM dbo.device AS device INNER JOIN 
        [dbo].[tenantinfo] as tenant ON device.tenant_id =  CAST(tenant.customer_rid AS NVARCHAR(255));

        UPDATE contrl SET contrl.tenant_id=tenant.tenant_id FROM dbo.controller AS contrl INNER JOIN 
        [dbo].[tenantinfo] as tenant ON contrl.tenant_id =  CAST(tenant.customer_rid AS NVARCHAR(255));

       DELETE edm
       FROM dbo.Vehicle_ChangeLog v
       JOIN dbo.asset_info m ON m.vehicle_rid = v.Vehicle_rid
       JOIN dbo.equipment_device_mapping edm ON edm.equipment_rid = m.equipment_rid
       WHERE v.ChangeType = 'DELETE'
         AND v.Processed = 0;

       DELETE c
       FROM dbo.Vehicle_ChangeLog v
       JOIN dbo.asset_info m ON m.vehicle_rid = v.Vehicle_rid
       JOIN dbo.controller c ON c.controller_rid = m.controller_rid
       WHERE v.ChangeType = 'DELETE'
         AND v.Processed = 0;

       DELETE d
       FROM dbo.Vehicle_ChangeLog v
       JOIN dbo.asset_info m ON m.vehicle_rid = v.Vehicle_rid
       JOIN dbo.device d ON d.device_rid = m.device_rid
       WHERE v.ChangeType = 'DELETE'
         AND v.Processed = 0;

       DELETE e
       FROM dbo.Vehicle_ChangeLog v
       JOIN dbo.asset_info m ON m.vehicle_rid = v.Vehicle_rid
       JOIN dbo.equipment e ON e.equipment_rid = m.equipment_rid
       WHERE v.ChangeType = 'DELETE'
         AND v.Processed = 0;

       DELETE a
       FROM dbo.Vehicle_ChangeLog v
       JOIN dbo.asset_info m ON m.vehicle_rid = v.Vehicle_rid
       JOIN dbo.asset a ON a.asset_rid = m.asset_rid
       WHERE v.ChangeType = 'DELETE'
         AND v.Processed = 0;

       DELETE m
       FROM dbo.asset_info m
       JOIN dbo.Vehicle_ChangeLog v ON v.Vehicle_rid = m.vehicle_rid
       WHERE v.ChangeType = 'DELETE'
         AND v.Processed = 0;

       UPDATE dbo.Vehicle_ChangeLog
       SET Processed = 1,
           ProcessedAt = SYSDATETIME()
       WHERE Processed = 0;

       COMMIT TRAN;

    /* Delete the processed or synched records alone */
    --DELETE FROM dbo.Vehicle_ChangeLog WHERE Processed=1;
END;
GO

