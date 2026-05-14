CREATE TABLE [dbo].[apu_device_fuel_data] (
    [apu_device_fuel_data_rid] BIGINT          IDENTITY (1, 1) NOT NULL,
    [tenant_id]                NVARCHAR (100)  NULL,
    [start_fuel_savings]       DECIMAL (12, 2) NULL,
    [end_fuel_savings]         DECIMAL (12, 2) NULL,
    [total_fuel_saved]         DECIMAL (12, 2) NULL,
    [created_on]               DATETIME        NOT NULL,
    [start_engine_hours]       DECIMAL (12, 2) NULL,
    [end_engine_hours]         DECIMAL (12, 2) NULL,
    [total_engine_hours]       DECIMAL (12, 2) NULL,
    [completed_on]             DATETIME        NULL,
    [start_fuel_consumption]   DECIMAL (5, 2)  NULL,
    [end_fuel_consumption]     DECIMAL (5, 2)  NULL,
    [total_fuel_consumed]      DECIMAL (5, 2)  NULL,
    [latitude]                 DECIMAL (10, 6) NULL,
    [longitude]                DECIMAL (10, 6) NULL,
    [running_status]           BIT             DEFAULT ((0)) NOT NULL,
    [device_serial_number]     NVARCHAR (100)  NOT NULL,
    [equipment_serial_number]  NVARCHAR (100)  NOT NULL
);
GO

ALTER TABLE [dbo].[apu_device_fuel_data]
    ADD CONSTRAINT [idx_apu_device_fuel_dataPK] PRIMARY KEY CLUSTERED ([apu_device_fuel_data_rid] ASC);
GO

