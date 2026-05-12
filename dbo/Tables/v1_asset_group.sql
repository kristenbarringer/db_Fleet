CREATE TABLE [dbo].[v1_asset_group] (
    [v1_vehicle_group_rid] INT            NULL,
    [vehicle_group]        NVARCHAR (50)  NULL,
    [customer_rid]         INT            NULL,
    [pipeline_id]          NVARCHAR (100) DEFAULT (NULL) NULL
);
GO

