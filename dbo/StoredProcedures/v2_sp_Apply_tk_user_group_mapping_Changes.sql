

CREATE PROCEDURE [dbo].[v2_sp_Apply_tk_user_group_mapping_Changes]
AS

BEGIN
   SET NOCOUNT ON;
   SET XACT_ABORT ON;
   BEGIN TRAN;
        DECLARE
            @change_type nvarchar(20),
            @user_rid int,
            @user_name nvarchar(100),
            @vehicle_group_rid INT,
            @vehicle_group_name NVARCHAR(100),
            @Customer_rid int,
            @created datetime;

        DECLARE cur CURSOR LOCAL FOR
            SELECT
                change_type,
                user_rid,
                user_name, 
                vehicle_group_rid,
                vehicle_group_name,
                Customer_rid, 
                created
            FROM dbo.User_group_mapping_changeLog
            WHERE Processed = 0 ORDER BY ChangeLogId ASC;

        OPEN cur;
        FETCH NEXT FROM cur INTO @change_type, @user_rid, @user_name, @vehicle_group_rid, @vehicle_group_name, @Customer_rid, @created;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                DECLARE @v2user_rid int;
                DECLARE @tenant_id nvarchar(255);
                DECLARE @asset_group_id int;

                SELECT @asset_group_id=asset_group_rid FROM asset_group WHERE v1_vehicle_group_rid = @vehicle_group_rid;
              
                SELECT @v2user_rid= user_rid, @tenant_id=tenant_id FROM [dbo].[tenantinfo] (nolock) WHERE user_name = @user_name;
		        SELECT @v2user_rid, @user_name;
                IF (@change_type = 'Inserted')
                    IF (@asset_group_id IS NULL) 
                        SELECT 'INserted', @asset_group_id;
                        INSERT INTO [dbo].[asset_group] (asset_group_name, tenant_id,created, updated, v1_vehicle_group_rid) VALUES(
                        @vehicle_group_name,@tenant_id, @created, SYSDATETIME(),@vehicle_group_rid)
                        SET @asset_group_id = SCOPE_IDENTITY();
               
                    IF (@asset_group_id IS NOT NULL)
                        INSERT INTO [dbo].[user_asset_group_mapping](user_rid, asset_group_rid, created) VALUES(@v2user_rid,@asset_group_id, SYSDATETIME());
               
		        ELSE IF (@change_type = 'Deleted')
                    DELETE FROM [dbo].[user_asset_group_mapping] WHERE user_rid = @v2user_rid AND asset_group_rid = @asset_group_id;
       
                UPDATE dbo.User_group_mapping_changeLog
                SET Processed = 1,
                    ProcessedAt = SYSDATETIME()
                WHERE Processed = 0;

                FETCH NEXT FROM cur INTO @change_type, @user_rid, @user_name, @vehicle_group_rid, @vehicle_group_name, @Customer_rid, @created;
            END
        CLOSE cur;
        DEALLOCATE cur;

   COMMIT TRAN;

   DELETE dbo.User_group_mapping_changeLog WHERE Processed = 1;
END;
GO

