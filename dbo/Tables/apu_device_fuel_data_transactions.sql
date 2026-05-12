CREATE TABLE [dbo].[apu_device_fuel_data_transactions] (
    [apu_device_fuel_data_transactions_rid] BIGINT          IDENTITY (1, 1) NOT NULL,
    [fuel_data_rid]                         BIGINT          NULL,
    [tenant_id]                             NVARCHAR (100)  NULL,
    [engine_hours]                          DECIMAL (12, 2) NULL,
    [fuel_savings]                          DECIMAL (12, 2) NULL,
    [fuel_consumption]                      DECIMAL (12, 2) NULL,
    [engine_state]                          VARCHAR (255)   NULL,
    [latitude]                              DECIMAL (10, 6) NULL,
    [longitude]                             DECIMAL (10, 6) NULL,
    [created]                               DATETIME        DEFAULT (getdate()) NOT NULL,
    [device_serial_number]                  NVARCHAR (100)  NOT NULL,
    [equipment_serial_number]               NVARCHAR (100)  NOT NULL,
    [controller_status]                     BIT             NULL,
    [asset_rid]                             INT             NULL
);
GO

ALTER TABLE [dbo].[apu_device_fuel_data_transactions]
    ADD CONSTRAINT [idx_apu_device_fuel_data_transactionsPK] PRIMARY KEY CLUSTERED ([apu_device_fuel_data_transactions_rid] ASC);
GO

