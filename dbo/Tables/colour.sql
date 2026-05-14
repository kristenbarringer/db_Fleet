CREATE TABLE [dbo].[colour] (
    [colour_rid]  INT           IDENTITY (1, 1) NOT NULL,
    [description] NVARCHAR (50) NULL,
    [rgbvalue]    NVARCHAR (50) NULL
);
GO

ALTER TABLE [dbo].[colour]
    ADD CONSTRAINT [idx_colourPK] PRIMARY KEY CLUSTERED ([colour_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

