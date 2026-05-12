CREATE TABLE [dbo].[asset_retry] (
    [rid]                  INT            IDENTITY (1, 1) NOT NULL,
    [asset_id]             INT            NOT NULL,
    [device_serial_number] NVARCHAR (100) NOT NULL,
    [retry_count]          INT            NOT NULL,
    [equipment_type]       NVARCHAR (50)  NOT NULL,
    [scheduled_time]       NVARCHAR (50)  NOT NULL,
    [created]              DATETIME       NOT NULL,
    [updated]              DATETIME       NULL,
    [asset_status]         NVARCHAR (50)  NULL,
    [retry_complete]       BIT            NULL,
    PRIMARY KEY CLUSTERED ([rid] ASC)
);
GO

