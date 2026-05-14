CREATE TABLE [dbo].[apu_fuel_event_transactions] (
    [transaction_rid]         BIGINT          IDENTITY (1, 1) NOT NULL,
    [asset_uuid]              NVARCHAR (100)  NULL,
    [tenant_id]               NVARCHAR (100)  NULL,
    [device_serial_number]    NVARCHAR (100)  NOT NULL,
    [equipment_serial_number] NVARCHAR (100)  NOT NULL,
    [engine_hours]            DECIMAL (12, 2) NULL,
    [fuel_savings]            DECIMAL (12, 2) NULL,
    [fuel_consumption]        DECIMAL (12, 2) NULL,
    [engine_state]            VARCHAR (255)   NULL,
    [controller_status]       BIT             NULL,
    [latitude]                DECIMAL (10, 6) NULL,
    [longitude]               DECIMAL (10, 6) NULL,
    [created]                 DATETIME        DEFAULT (getdate()) NOT NULL,
    [device_timestamp]        DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([transaction_rid] ASC)
);
GO

