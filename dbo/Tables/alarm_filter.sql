CREATE TABLE [dbo].[alarm_filter] (
    [alarm_filter_rid] INT           IDENTITY (1, 1) NOT NULL,
    [alarm_filter]     NVARCHAR (50) NOT NULL,
    [created]          DATETIME      NOT NULL
);
GO

ALTER TABLE [dbo].[alarm_filter]
    ADD CONSTRAINT [idx_filter_alarm_filterPK] PRIMARY KEY CLUSTERED ([alarm_filter_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[alarm_filter]
    ADD CONSTRAINT [DF_alarm_filter_created] DEFAULT (getdate()) FOR [created];
GO

