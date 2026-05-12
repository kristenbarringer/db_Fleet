CREATE TABLE [dbo].[power_source] (
    [power_source_rid] INT           IDENTITY (1, 1) NOT NULL,
    [power_source]     NVARCHAR (50) NOT NULL,
    [created]          DATETIME      NULL
);
GO

ALTER TABLE [dbo].[power_source]
    ADD CONSTRAINT [DF_power_source_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[power_source]
    ADD CONSTRAINT [idx_filter_power_sourcePK] PRIMARY KEY CLUSTERED ([power_source_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

