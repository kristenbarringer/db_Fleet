CREATE TABLE [dbo].[device] (
    [device_rid]               INT             IDENTITY (1, 1) NOT NULL,
    [device_name]              NVARCHAR (50)   NOT NULL,
    [device_type_rid]          INT             NOT NULL,
    [created]                  DATETIME        NOT NULL,
    [tenant_id]                NVARCHAR (50)   NOT NULL,
    [device_serial_number]     NVARCHAR (50)   NULL,
    [device_software_version]  NVARCHAR (50)   NULL,
    [sim_number]               NVARCHAR (50)   NULL,
    [logging_interval_rid_on]  INT             NULL,
    [logging_interval_rid_off] INT             NULL,
    [deactivated_date]         DATETIME        NULL,
    [telematics_mode_type_rid] TINYINT         NOT NULL,
    [activated_by_user_rid]    INT             NULL,
    [deactivated_by_user_rid]  INT             NULL,
    [gsm_provider_type_rid]    INT             NOT NULL,
    [updated_by_user_rid]      INT             NULL,
    [updated]                  DATETIME        NULL,
    [service_level_rid]        INT             NULL,
    [notes]                    NVARCHAR (1000) NULL,
    [auto_update_sent]         BIT             NULL,
    [device_uuid]              NVARCHAR (50)   NULL
);
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [FK_device_logging_interval_on] FOREIGN KEY ([logging_interval_rid_on]) REFERENCES [dbo].[logging_interval] ([logging_interval_rid]);
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [FK_device_device_type] FOREIGN KEY ([device_type_rid]) REFERENCES [dbo].[device_type] ([device_type_rid]);
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [FK_device_telematics_mode_type] FOREIGN KEY ([telematics_mode_type_rid]) REFERENCES [dbo].[telematics_mode_type] ([rid]);
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [FK_device_type] FOREIGN KEY ([device_type_rid]) REFERENCES [dbo].[device_type] ([device_type_rid]);
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [FK_device_gsm_provider_type] FOREIGN KEY ([gsm_provider_type_rid]) REFERENCES [dbo].[gsm_provider_type] ([rid]);
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [FK_device_logging_interval_off] FOREIGN KEY ([logging_interval_rid_off]) REFERENCES [dbo].[logging_interval] ([logging_interval_rid]);
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [DF_gsm_provider_type_v1migration] DEFAULT ((1)) FOR [gsm_provider_type_rid];
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [DF_device_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [DF_device_type_v1migration] DEFAULT ((1)) FOR [device_type_rid];
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [idx_devicePK] PRIMARY KEY CLUSTERED ([device_rid] ASC) WITH (FILLFACTOR = 100);
GO

