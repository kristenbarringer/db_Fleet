CREATE TABLE [dbo].[v1_user_asset_group_mapping_reefer] (
    [v1_user_rid]          INT            NULL,
    [v1_vehicle_group_rid] INT            NULL,
    [vehicle_group_name]   NVARCHAR (50)  NULL,
    [v1_customer_rid]      INT            NULL,
    [username]             NVARCHAR (50)  NULL,
    [pipeline_id]          NVARCHAR (100) DEFAULT ((100)) NULL
);
GO

