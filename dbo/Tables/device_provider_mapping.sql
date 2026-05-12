CREATE TABLE [dbo].[device_provider_mapping] (
    [device_serial_number] NVARCHAR (100) NOT NULL,
    [tenant_id]            NVARCHAR (100) NULL,
    [device_provider]      NVARCHAR (100) NOT NULL,
    [device_provider_rid]  INT            IDENTITY (1, 1) NOT NULL,
    [created]              DATETIME       DEFAULT (getdate()) NULL
);
GO

