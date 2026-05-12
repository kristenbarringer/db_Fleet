CREATE TABLE [dbo].[user_tracked_asset] (
    [track_rid] INT           IDENTITY (1, 1) NOT NULL,
    [user_rid]  INT           NOT NULL,
    [asset_rid] INT           NOT NULL,
    [created]   DATETIME      NOT NULL,
    [updated]   DATETIME      NULL,
    [tenant_id] NVARCHAR (50) NULL
);
GO

ALTER TABLE [dbo].[user_tracked_asset]
    ADD CONSTRAINT [idx_user_tracked_assetPK] PRIMARY KEY CLUSTERED ([track_rid] ASC);
GO

ALTER TABLE [dbo].[user_tracked_asset]
    ADD CONSTRAINT [DF_user_tracked_asset_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[user_tracked_asset]
    ADD CONSTRAINT [DF_user_tracked_asset_updated] DEFAULT (getdate()) FOR [updated];
GO

ALTER TABLE [dbo].[user_tracked_asset]
    ADD CONSTRAINT [FK_user_tracked_asset_asset] FOREIGN KEY ([asset_rid]) REFERENCES [dbo].[asset] ([asset_rid]);
GO

