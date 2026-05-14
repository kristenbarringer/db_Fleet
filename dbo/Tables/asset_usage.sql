CREATE TABLE [dbo].[asset_usage] (
    [asset_usage_rid] INT           IDENTITY (1, 1) NOT NULL,
    [description]     NVARCHAR (50) NOT NULL
);
GO

ALTER TABLE [dbo].[asset_usage]
    ADD CONSTRAINT [idx_asset_usagePK] PRIMARY KEY CLUSTERED ([asset_usage_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

