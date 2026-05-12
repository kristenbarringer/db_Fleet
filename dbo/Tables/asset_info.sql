CREATE TABLE [dbo].[asset_info] (
    [vehicle_rid]        INT            NULL,
    [customer_rid]       INT            NULL,
    [vehicle_group_rid]  INT            NULL,
    [v1_vehicle_rid]     INT            NULL,
    [asset_rid]          INT            NULL,
    [equipment_rid]      INT            NULL,
    [controller_rid]     INT            NULL,
    [device_rid]         INT            NULL,
    [last_modified_date] DATETIME       NULL,
    [pipeline_id]        NVARCHAR (100) DEFAULT (NULL) NULL
);
GO

