CREATE TABLE [dbo].[equipment] (
    [equipment_rid]            INT             IDENTITY (1, 1) NOT NULL,
    [equipment_name]           NVARCHAR (50)   NOT NULL,
    [equipment_type_rid]       INT             NOT NULL,
    [created]                  DATETIME        NOT NULL,
    [tenant_id]                NVARCHAR (50)   NOT NULL,
    [asset_rid]                INT             NULL,
    [equipment_serial_number]  NVARCHAR (50)   NULL,
    [equipment_serial_version] NVARCHAR (50)   NULL,
    [updated]                  DATETIME        NULL,
    [is_reported]              BIT             DEFAULT ((1)) NOT NULL,
    [notes]                    NVARCHAR (1000) NULL,
    [id]                       VARCHAR (36)    NULL,
    [warranty_start_date]      DATETIME        NULL,
    [warranty_end_date]        DATETIME        NULL,
    [visibility]               BIT             DEFAULT ((0)) NOT NULL
);
GO

ALTER TABLE [dbo].[equipment]
    ADD CONSTRAINT [DF_equipment_type_v1migration] DEFAULT ((1)) FOR [equipment_type_rid];
GO

ALTER TABLE [dbo].[equipment]
    ADD CONSTRAINT [DF_asset_v1migration] DEFAULT ((1)) FOR [asset_rid];
GO

ALTER TABLE [dbo].[equipment]
    ADD CONSTRAINT [DF_equipment_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[equipment]
    ADD CONSTRAINT [FK_equipment_equipment_type] FOREIGN KEY ([equipment_type_rid]) REFERENCES [dbo].[equipment_type] ([equipment_type_rid]);
GO

ALTER TABLE [dbo].[equipment]
    ADD CONSTRAINT [FK_equipment_asset] FOREIGN KEY ([asset_rid]) REFERENCES [dbo].[asset] ([asset_rid]);
GO

ALTER TABLE [dbo].[equipment]
    ADD CONSTRAINT [idx_equipmentPK] PRIMARY KEY CLUSTERED ([equipment_rid] ASC) WITH (FILLFACTOR = 100);
GO

