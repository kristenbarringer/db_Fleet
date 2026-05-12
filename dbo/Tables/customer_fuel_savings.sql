CREATE TABLE [dbo].[customer_fuel_savings] (
    [customer_fuel_savings_rid] INT             IDENTITY (1, 1) NOT NULL,
    [tenant_id]                 NVARCHAR (100)  NULL,
    [fuel_savings]              DECIMAL (12, 2) NULL,
    [thirty_days]               DECIMAL (12, 2) NOT NULL,
    [twelve_months]             DECIMAL (12, 2) NOT NULL,
    [created]                   DATETIME        DEFAULT (getdate()) NOT NULL
);
GO

ALTER TABLE [dbo].[customer_fuel_savings]
    ADD CONSTRAINT [idx_customer_fuel_savingsPK] PRIMARY KEY CLUSTERED ([customer_fuel_savings_rid] ASC);
GO

