CREATE TABLE [dbo].[asset]
(
	[asset_uuid] UNIQUEIDENTIFIER CONSTRAINT [df_asset_id] DEFAULT (NEWID()) NOT NULL,
    -- todo rename asset_uuid to id?
    [asset_rid] INT IDENTITY (1, 1) NOT NULL,
    -- TODO asset_rid MIGHT BE DEPRECATED or renamed to legacy_asset_rid?
    [tenant_id] NVARCHAR (50) CONSTRAINT [df_asset_tenant_id] DEFAULT (1) NOT NULL,
    [asset_name] VARCHAR    (255) NULL,
    -- TODO rename asset_name to name but caused error in sys.sp_refreshsqlmodule_internal
    [description] NVARCHAR    (300) CONSTRAINT [df_asset_description] DEFAULT    ('TrackingV1Asset') NULL,
    [make] VARCHAR    (255) NULL,
    [model] VARCHAR    (255) NULL,
    [year] INT NULL,
    [vin] VARCHAR    (255) NULL,
    [fuel_tank_size] FLOAT    (53) NULL,

    -- foreign keys:
    [asset_type_code] VARCHAR (30) CONSTRAINT [df_asset_asset_type_code] DEFAULT ('AST_TRUCK') NOT NULL,
    [power_source_code] VARCHAR (30) NULL,
    [asset_icon_code] VARCHAR (30) NULL,
    [asset_usage_code] VARCHAR (30) NULL,
    [activation_status_code] VARCHAR (30) CONSTRAINT df_asset_activation_status_code DEFAULT 'AAS_ACTIVATED' NOT NULL,
    [billing_service_level_code] VARCHAR (30) NULL,

    -- flags

    [active] BIT NOT NULL,
    -- TODO rename active to is_active but caused an error in sp_refreshsqlmodule_internal

    [door_sensor_1] BIT NULL,
    [door_sensor_2] BIT NULL,
    [door_sensor_3] BIT NULL,
    [cargowatch_download] BIT NULL,
    [servicewatch_download] BIT NULL,
    [lock] BIT NULL,

    -- dates
    [created] DATETIME CONSTRAINT [df_asset_created] DEFAULT (getdate()) NOT NULL,
    [updated] DATETIME NULL,
    [activated] DATETIME NULL,
    [replacement_date] DATETIME NULL,
    [user_activation] DATETIME2 (6) NULL,

    -- who 
    [created_by_user_rid] INT CONSTRAINT [df_asset_created_by_user_rid] DEFAULT (1) NOT NULL,

    -- notes
    [notes] VARCHAR (255) NULL,
    [additional_notes] VARCHAR (255) NULL,
    [account_additional_notes] VARCHAR (255) NULL
);
GO



ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [fk_asset_activation_status] FOREIGN KEY ([activation_status_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

CREATE NONCLUSTERED INDEX [ix_asset_activation_status_code]
    ON [dbo].[asset]([activation_status_code] ASC);
GO

ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [fk_asset_asset_type] FOREIGN KEY ([asset_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

CREATE NONCLUSTERED INDEX [ix_asset_asset_type_code]
    ON [dbo].[asset]([asset_type_code] ASC);
GO

ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [fk_asset_asset_usage_rid] FOREIGN KEY ([asset_usage_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

CREATE NONCLUSTERED INDEX [ix_asset_asset_usage_code]
    ON [dbo].[asset]([asset_usage_code] ASC);
GO

ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [cix_asset_asset_rid] PRIMARY KEY CLUSTERED ([asset_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[asset]
    ADD CONSTRAINT [fk_asset_asset_type_code] FOREIGN KEY ([asset_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO
 