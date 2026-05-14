CREATE TABLE [dbo].[billing_logging_interval] (
    [billing_logging_interval_rid]    SMALLINT      IDENTITY (1, 1) NOT NULL,
    [logging_interval_description]    VARCHAR (100) NOT NULL,
    [logging_interval_minutes_on]     SMALLINT      NOT NULL,
    [logging_interval_minutes_off]    SMALLINT      NOT NULL,
    [device_logging_interval_rid_on]  INT           NOT NULL,
    [device_logging_interval_rid_off] INT           NOT NULL,
    [active]                          BIT           NOT NULL,
    [created]                         DATETIME      NOT NULL
);
GO

ALTER TABLE [dbo].[billing_logging_interval]
    ADD CONSTRAINT [idx_billing_logging_intervalPK] PRIMARY KEY NONCLUSTERED ([billing_logging_interval_rid] ASC) WITH (FILLFACTOR = 100);
GO

ALTER TABLE [dbo].[billing_logging_interval]
    ADD CONSTRAINT [FK_billing_logging_interval_on_logging_interval] FOREIGN KEY ([device_logging_interval_rid_on]) REFERENCES [dbo].[logging_interval] ([logging_interval_rid]);
GO

ALTER TABLE [dbo].[billing_logging_interval]
    ADD CONSTRAINT [FK_billing_logging_interval_off_logging_interval] FOREIGN KEY ([device_logging_interval_rid_off]) REFERENCES [dbo].[logging_interval] ([logging_interval_rid]);
GO

ALTER TABLE [dbo].[billing_logging_interval]
    ADD CONSTRAINT [DF_billing_logging_interval_created] DEFAULT (getdate()) FOR [created];
GO

