CREATE TABLE [dbo].[optiset_language_type] (
    [optiset_language_type_rid] INT           IDENTITY (1, 1) NOT NULL,
    [description]               NVARCHAR (50) NOT NULL,
    [language_rid]              INT           NOT NULL
);
GO

ALTER TABLE [dbo].[optiset_language_type]
    ADD CONSTRAINT [FK_optiset_language_type_language_rid] FOREIGN KEY ([language_rid]) REFERENCES [dbo].[language] ([language_rid]);
GO

ALTER TABLE [dbo].[optiset_language_type]
    ADD CONSTRAINT [idx_tk_optiset_language_typePK] PRIMARY KEY CLUSTERED ([optiset_language_type_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

