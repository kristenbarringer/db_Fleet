CREATE TABLE [dbo].[service_level] (
    [service_level_rid] INT           IDENTITY (1, 1) NOT NULL,
    [description]       NVARCHAR (50) NOT NULL
);
GO

ALTER TABLE [dbo].[service_level]
    ADD CONSTRAINT [idx_service_levelPK] PRIMARY KEY CLUSTERED ([service_level_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

