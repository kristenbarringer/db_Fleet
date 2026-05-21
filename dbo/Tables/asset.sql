CREATE TABLE [dbo].[asset]
(
    [asset_rid] INT IDENTITY (1, 1) NOT NULL,
    [asset_name] VARCHAR (255) NULL,
    [description] NVARCHAR (300) NULL,
    [created] DATETIME NOT NULL,
    [tenant_id] NVARCHAR (50) NOT NULL,
    [active] BIT NOT NULL,
    -- TODO rename to is_active but caused an error in sp_refreshsqlmodule_internal
    [make] VARCHAR (255) NULL,
    [model] VARCHAR (255) NULL,
    [year] INT NULL,
    [asset_type_code] VARCHAR (30) NOT NULL,
    [created_by_user_rid] INT NOT NULL,
    [vin] VARCHAR (255) NULL,
    [updated] DATETIME NULL,
    [power_source_code] VARCHAR (30) NULL,
    [asset_uuid] NVARCHAR (50) DEFAULT ('3924d614-c329-43f4-8166-a6f1a9831c91') NOT NULL,
    [asset_icon_code] VARCHAR (30) NULL,
    [asset_usage_code] VARCHAR (30) NULL,
    [activation_status_code] VARCHAR (30) DEFAULT (('AAS_ACTIVATED')) NOT NULL,
    [billing_service_level_code] VARCHAR (30) NULL,
    [activated] DATETIME NULL,
    [user_activation] DATETIME2 (6) NULL,
    [door_sensor_1] BIT NULL,
    [door_sensor_2] BIT NULL,
    [lock] BIT NULL,
    [cargowatch_download] BIT NULL,
    [servicewatch_download] BIT NULL,
    [fuel_tank_size] FLOAT (53) NULL,
    [notes] VARCHAR (255) NULL,
    [additional_notes] VARCHAR (255) NULL,
    [door_sensor_3] BIT NULL,
    [replacement_date] DATETIME NULL,
    [account_additional_notes] VARCHAR (255) NULL
);
GO

ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [DF_asset_description_v1migration] DEFAULT ('TrackingV1Asset') FOR [description];
GO

ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [DF_tenant_id_v1migration] DEFAULT ((1)) FOR [tenant_id];
GO

ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [df_asset_asset_type_code] DEFAULT (('AST_TRUCK')) FOR [asset_type_code];
GO

ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [DF_created_by_user_rid_v1migration] DEFAULT ((1)) FOR [created_by_user_rid];
GO

ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [DF_asset_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [FK_asset_activation_status] FOREIGN KEY ([activation_status_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [FK_asset_asset_type] FOREIGN KEY ([asset_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [FK_asset_asset_usage_rid] FOREIGN KEY ([asset_usage_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [idx_assetPK] PRIMARY KEY CLUSTERED ([asset_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [FK_asset_asset_type_code] FOREIGN KEY ([asset_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO
