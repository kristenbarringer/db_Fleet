CREATE TABLE [dbo].[billing_service_level] (
    [billing_service_level_rid] INT           IDENTITY (1, 1) NOT NULL,
    [service_level_description] VARCHAR (100) NOT NULL,
    [created]                   DATETIME      NOT NULL
);
GO

ALTER TABLE [dbo].[billing_service_level]
    ADD CONSTRAINT [idx_billing_service_levelPK] PRIMARY KEY NONCLUSTERED ([billing_service_level_rid] ASC) WITH (FILLFACTOR = 100);
GO

ALTER TABLE [dbo].[billing_service_level]
    ADD CONSTRAINT [DF_billing_service_level_created] DEFAULT (getdate()) FOR [created];
GO

