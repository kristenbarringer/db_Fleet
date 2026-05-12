CREATE TABLE [dbo].[tenant_device_mapping] (
    [device_uuid]     NVARCHAR (100)   NULL,
    [tenant_id]       NVARCHAR (100)   NULL,
    [subscription_id] VARCHAR (100)    NULL,
    [status]          NVARCHAR (50)    NULL,
    [created_date]    DATETIME         NULL,
    [updated_date]    DATETIME         NULL,
    [device_rid]      INT              NULL,
    [correlation_id]  UNIQUEIDENTIFIER NULL
);
GO

ALTER TABLE [dbo].[tenant_device_mapping]
    ADD CONSTRAINT [DF_tenant_device_mapping_created_date] DEFAULT (getdate()) FOR [created_date];
GO

