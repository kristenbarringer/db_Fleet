CREATE TABLE [dbo].[asset_tenant_info_table] (
    [vehicle_rid]       INT            NULL,
    [customer_rid]      INT            NULL,
    [vehicle_group_rid] INT            NULL,
    [v1_vehicle_rid]    INT            NULL,
    [asset_rid]         INT            NULL,
    [equipment_rid]     INT            NULL,
    [controller_rid]    INT            NULL,
    [device_rid]        INT            NULL,
    [tenant_id]         NVARCHAR (100) NULL,
    [pipeline_id]       NVARCHAR (100) NULL
);
GO

