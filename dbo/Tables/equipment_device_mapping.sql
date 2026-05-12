CREATE TABLE [dbo].[equipment_device_mapping] (
    [equipment_rid] INT      NOT NULL,
    [device_rid]    INT      NOT NULL,
    [created]       DATETIME NULL
);
GO

ALTER TABLE [dbo].[equipment_device_mapping]
    ADD CONSTRAINT [FK_equipment_device_mapping_equipment] FOREIGN KEY ([equipment_rid]) REFERENCES [dbo].[equipment] ([equipment_rid]);
GO

ALTER TABLE [dbo].[equipment_device_mapping]
    ADD CONSTRAINT [FK_equipment_device_mapping_device] FOREIGN KEY ([device_rid]) REFERENCES [dbo].[device] ([device_rid]);
GO

ALTER TABLE [dbo].[equipment_device_mapping]
    ADD CONSTRAINT [DF_equipment_device_mapping_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[equipment_device_mapping]
    ADD CONSTRAINT [idx_equipment_device_mappingPK] PRIMARY KEY CLUSTERED ([equipment_rid] ASC, [device_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

