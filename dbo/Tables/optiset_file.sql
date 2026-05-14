CREATE TABLE [dbo].[optiset_file] (
    [optiset_file_rid] INT           IDENTITY (1, 1) NOT NULL,
    [asset_rid]        INT           NOT NULL,
    [unique_file_id]   BIGINT        NOT NULL,
    [file_name]        VARCHAR (100) NULL,
    [created]          DATETIME      NOT NULL
);
GO

ALTER TABLE [dbo].[optiset_file]
    ADD CONSTRAINT [idx_tk_optiset_filePK] PRIMARY KEY CLUSTERED ([optiset_file_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[optiset_file]
    ADD CONSTRAINT [DF_optiset_file_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[optiset_file]
    ADD CONSTRAINT [FK_optiset_file_asset_rid] FOREIGN KEY ([asset_rid]) REFERENCES [dbo].[asset] ([asset_rid]);
GO

