CREATE TABLE [dbo].[asset_fuel_savings] (
    [asset_fuel_savings_rid] INT             IDENTITY (1, 1) NOT NULL,
    [asset_rid]              INT             NULL,
    [tenant_id]              NVARCHAR (100)  NULL,
    [fuel_savings]           DECIMAL (12, 2) NULL,
    [thirty_days]            DECIMAL (12, 2) NOT NULL,
    [twelve_months]          DECIMAL (12, 2) NOT NULL,
    [created]                DATETIME        DEFAULT (getdate()) NOT NULL,
    FOREIGN KEY ([asset_rid]) REFERENCES [dbo].[asset] ([asset_rid]),
    FOREIGN KEY ([asset_rid]) REFERENCES [dbo].[asset] ([asset_rid])
);
GO

ALTER TABLE [dbo].[asset_fuel_savings]
    ADD CONSTRAINT [idx_asset_fuel_savingsPK] PRIMARY KEY CLUSTERED ([asset_fuel_savings_rid] ASC);
GO

