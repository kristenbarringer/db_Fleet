CREATE TABLE [dbo].[device]
(
    [device_rid] INT IDENTITY (1, 1) NOT NULL,
    [device_name] NVARCHAR (50) NOT NULL,
    [device_type_code] VARCHAR(30) NOT NULL,
    [created] DATETIME NOT NULL,
    [tenant_id] NVARCHAR (50) NOT NULL,
    [device_serial_number] NVARCHAR (50) NULL,
    [device_software_version] NVARCHAR (50) NULL,
    [sim_number] NVARCHAR (50) NULL,
    [logging_interval_rid_on_code] VARCHAR(30) NULL,
    [logging_interval_rid_off_code] VARCHAR(30) NULL,
    [deactivated_date] DATETIME NULL,
    [telematics_mode_type_code] VARCHAR(30) NOT NULL,
    [activated_by_user_rid] INT NULL,
    [deactivated_by_user_rid] INT NULL,
    [gsm_provider_type_code] VARCHAR(30) NOT NULL,
    [updated_by_user_rid] INT NULL,
    [updated] DATETIME NULL,
    [service_level_code] VARCHAR(30) NULL,
    [notes] NVARCHAR (1000) NULL,
    [auto_update_sent] BIT NULL,
    [device_uuid] NVARCHAR (50) NULL
);
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [FK_device_logging_interval_rid_on_code] FOREIGN KEY ([logging_interval_rid_on_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [FK_device_device_type] FOREIGN KEY ([device_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [FK_device_telematics_mode_type] FOREIGN KEY ([telematics_mode_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [FK_device_type] FOREIGN KEY ([device_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [FK_device_gsm_provider_type] FOREIGN KEY ([gsm_provider_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [FK_device_logging_interval_rid_off_code] FOREIGN KEY ([logging_interval_rid_off_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [DF_gsm_provider_type_v1migration] DEFAULT (('GSM_O2_IRL')) FOR [gsm_provider_type_code];
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [DF_device_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [DF_device_type_v1migration] DEFAULT (('DTP_BLUEBOX')) FOR [device_type_code];
GO

ALTER TABLE [dbo].[device]
    ADD CONSTRAINT [idx_devicePK] PRIMARY KEY CLUSTERED ([device_rid] ASC) WITH (FILLFACTOR = 100);
GO

