CREATE TABLE [dbo].[power_status] (
    [power_status_rid] INT           IDENTITY (1, 1) NOT NULL,
    [power_status]     NVARCHAR (50) NOT NULL,
    [created]          DATETIME      NOT NULL
);
GO

ALTER TABLE [dbo].[power_status]
    ADD CONSTRAINT [idx_filter_power_statusPK] PRIMARY KEY CLUSTERED ([power_status_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[power_status]
    ADD CONSTRAINT [DF_power_status_created] DEFAULT (getdate()) FOR [created];
GO

