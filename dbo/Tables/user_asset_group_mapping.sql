CREATE TABLE [dbo].[user_asset_group_mapping] (
    [user_rid]        INT      NOT NULL,
    [asset_group_rid] INT      NOT NULL,
    [created]         DATETIME NULL
);
GO

ALTER TABLE [dbo].[user_asset_group_mapping]
    ADD CONSTRAINT [DF_user_asset_group_mapping_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[user_asset_group_mapping]
    ADD CONSTRAINT [FK_user_asset_group_mapping_asset_group] FOREIGN KEY ([asset_group_rid]) REFERENCES [dbo].[asset_group] ([asset_group_rid]);
GO

ALTER TABLE [dbo].[user_asset_group_mapping]
    ADD CONSTRAINT [idx_user_asset_group_mappingPK] PRIMARY KEY CLUSTERED ([user_rid] ASC, [asset_group_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

