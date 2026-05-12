CREATE TABLE [dbo].[asset_group_mapping] (
    [mapping_rid]     INT      IDENTITY (1, 1) NOT NULL,
    [asset_rid]       INT      NOT NULL,
    [asset_group_rid] INT      NOT NULL,
    [created]         DATETIME NOT NULL
);
GO

ALTER TABLE [dbo].[asset_group_mapping]
    ADD CONSTRAINT [FK_asset_group_mapping_asset] FOREIGN KEY ([asset_rid]) REFERENCES [dbo].[asset] ([asset_rid]);
GO

ALTER TABLE [dbo].[asset_group_mapping]
    ADD CONSTRAINT [FK_asset_group_mapping_asset_group] FOREIGN KEY ([asset_group_rid]) REFERENCES [dbo].[asset_group] ([asset_group_rid]);
GO

ALTER TABLE [dbo].[asset_group_mapping]
    ADD CONSTRAINT [DF_asset_group_mapping_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[asset_group_mapping]
    ADD CONSTRAINT [idx_asset_group_mappingPK] PRIMARY KEY CLUSTERED ([asset_rid] ASC, [asset_group_rid] ASC);
GO

