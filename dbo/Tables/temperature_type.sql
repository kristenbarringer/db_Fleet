CREATE TABLE [dbo].[temperature_type] (
    [temperature_type_rid] INT           NOT NULL,
    [description]          NVARCHAR (50) NOT NULL
);
GO

ALTER TABLE [dbo].[temperature_type]
    ADD CONSTRAINT [idx_temperature_typePK] PRIMARY KEY CLUSTERED ([temperature_type_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

