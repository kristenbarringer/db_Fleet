CREATE TABLE [dbo].[asset_type] (
    [asset_type_rid]  INT            IDENTITY (1, 1) NOT NULL,
    [asset_type_name] NVARCHAR (50)  NOT NULL,
    [description]     NVARCHAR (50)  NOT NULL,
    [created]         DATETIME       DEFAULT (getdate()) NULL,
    [asset_icon]      NVARCHAR (100) NULL
);
GO

ALTER TABLE [dbo].[asset_type]
    ADD CONSTRAINT [idx_asset_type_new_PK] PRIMARY KEY CLUSTERED ([asset_type_rid] ASC);
GO

