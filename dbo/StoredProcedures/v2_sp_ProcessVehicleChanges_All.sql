CREATE   PROCEDURE [dbo].[v2_sp_ProcessVehicleChanges_All]
AS
BEGIN
   SET NOCOUNT ON;
   SET XACT_ABORT ON;
   DECLARE
       @Vehicle_rid INT,
       @NewData NVARCHAR(MAX),
       @SetClause NVARCHAR(MAX),
       @Sql NVARCHAR(MAX);
   DECLARE cur CURSOR LOCAL FAST_FORWARD FOR
       SELECT Vehicle_rid, NewData
       FROM dbo.Vehicle_ChangeLog
       WHERE ChangeType = 'UPDATE'
         AND Processed = 0;
   OPEN cur;
   FETCH NEXT FROM cur INTO @Vehicle_rid, @NewData;
   WHILE @@FETCH_STATUS = 0
   BEGIN
       SELECT
           @SetClause = STRING_AGG(
               QUOTENAME(m.target_column) +
               ' = JSON_VALUE(@NewData, ''$.' + m.vehicle_column + ''')',
               ', '
           )
       FROM dbo.vehicle_column_mapping m
       WHERE m.target_table = 'asset';
       IF @SetClause IS NOT NULL
       BEGIN
           SET @Sql = N'
               UPDATE a
               SET ' + @SetClause + ',
                   a.updated = SYSDATETIME()
               FROM dbo.asset a
               JOIN dbo.asset_info map
                   ON map.asset_rid = a.asset_rid
               WHERE map.vehicle_rid = @Vehicle_rid;
           ';
           EXEC sp_executesql
               @Sql,
               N'@Vehicle_rid INT, @NewData NVARCHAR(MAX)',
               @Vehicle_rid, @NewData;
       END
       SELECT
           @SetClause = STRING_AGG(
               QUOTENAME(m.target_column) +
               ' = JSON_VALUE(@NewData, ''$.' + m.vehicle_column + ''')',
               ', '
           )
       FROM dbo.vehicle_column_mapping m
       WHERE m.target_table = 'equipment';
       IF @SetClause IS NOT NULL
       BEGIN
           SET @Sql = N'
               UPDATE e
               SET ' + @SetClause + ',
                   e.updated = SYSDATETIME()
               FROM dbo.equipment e
               JOIN dbo.asset_info map
                   ON map.equipment_rid = e.equipment_rid
               WHERE map.vehicle_rid = @Vehicle_rid;
           ';
           EXEC sp_executesql
               @Sql,
               N'@Vehicle_rid INT, @NewData NVARCHAR(MAX)',
               @Vehicle_rid, @NewData;
       END
       SELECT
           @SetClause = STRING_AGG(
               QUOTENAME(m.target_column) +
               ' = JSON_VALUE(@NewData, ''$.' + m.vehicle_column + ''')',
               ', '
           )
       FROM dbo.vehicle_column_mapping m
       WHERE m.target_table = 'controller';
       IF @SetClause IS NOT NULL
       BEGIN
           SET @Sql = N'
               UPDATE c
               SET ' + @SetClause + ',
                   c.updated = SYSDATETIME()
               FROM dbo.controller c
               JOIN dbo.asset_info map
                   ON map.controller_rid = c.controller_rid
               WHERE map.vehicle_rid = @Vehicle_rid;
           ';
           EXEC sp_executesql
               @Sql,
               N'@Vehicle_rid INT, @NewData NVARCHAR(MAX)',
               @Vehicle_rid, @NewData;
       END
       SELECT
           @SetClause = STRING_AGG(
               QUOTENAME(m.target_column) +
               ' = JSON_VALUE(@NewData, ''$.' + m.vehicle_column + ''')',
               ', '
           )
       FROM dbo.vehicle_column_mapping m
       WHERE m.target_table = 'device';
       IF @SetClause IS NOT NULL
       BEGIN
           SET @Sql = N'
               UPDATE d
               SET ' + @SetClause + ',
                   d.updated = SYSDATETIME()
               FROM dbo.device d
               JOIN dbo.asset_info map
                   ON map.device_rid = d.device_rid
               WHERE map.vehicle_rid = @Vehicle_rid;
           ';
           EXEC sp_executesql
               @Sql,
               N'@Vehicle_rid INT, @NewData NVARCHAR(MAX)',
               @Vehicle_rid, @NewData;
       END
       UPDATE dbo.Vehicle_ChangeLog
       SET Processed = 1,
           ProcessedAt = SYSDATETIME()
       WHERE Vehicle_rid = @Vehicle_rid
         AND ChangeType = 'UPDATE';
       FETCH NEXT FROM cur INTO @Vehicle_rid, @NewData;
   END
   CLOSE cur;
   DEALLOCATE cur;
END;
GO

