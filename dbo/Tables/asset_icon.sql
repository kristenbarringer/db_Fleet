CREATE TABLE [dbo].[asset_icon] (
    [asset_icon_rid] INT           NOT NULL,
    [name]           NVARCHAR (50) NOT NULL,
    [image]          NVARCHAR (50) NOT NULL
);
GO

ALTER TABLE [dbo].[asset_icon]
    ADD CONSTRAINT [idx_asset_iconPK] PRIMARY KEY CLUSTERED ([asset_icon_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

