CREATE TABLE [dbo].[trailer_type] (
    [trailer_type_rid] INT           IDENTITY (1, 1) NOT NULL,
    [trailer_type]     NVARCHAR (50) NOT NULL,
    [created]          DATETIME      NOT NULL
);
GO

ALTER TABLE [dbo].[trailer_type]
    ADD CONSTRAINT [idx_filter_trailer_typePK] PRIMARY KEY CLUSTERED ([trailer_type_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[trailer_type]
    ADD CONSTRAINT [DF_trailer_type_created] DEFAULT (getdate()) FOR [created];
GO

