CREATE TABLE [dbo].[asset_in_geo_fence] (
    [asset_rid]     INT      NOT NULL,
    [geo_fence_rid] INT      NOT NULL,
    [created]       DATETIME NULL
);
GO

ALTER TABLE [dbo].[asset_in_geo_fence]
    ADD CONSTRAINT [DF_asset_in_geo_fence_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[asset_in_geo_fence]
    ADD CONSTRAINT [FK_asset_in_geo_fence_geo_fence] FOREIGN KEY ([geo_fence_rid]) REFERENCES [dbo].[geo_fence] ([geo_fence_rid]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
ALTER TABLE [dbo].[asset_in_geo_fence] NOCHECK CONSTRAINT [FK_asset_in_geo_fence_geo_fence];
GO

ALTER TABLE [dbo].[asset_in_geo_fence]
    ADD CONSTRAINT [FK_asset_in_geo_fence_asset] FOREIGN KEY ([asset_rid]) REFERENCES [dbo].[asset] ([asset_rid]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
ALTER TABLE [dbo].[asset_in_geo_fence] NOCHECK CONSTRAINT [FK_asset_in_geo_fence_asset];
GO

ALTER TABLE [dbo].[asset_in_geo_fence]
    ADD CONSTRAINT [idx_asset_in_geo_fencePK] PRIMARY KEY CLUSTERED ([asset_rid] ASC, [geo_fence_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

