CREATE TABLE [dbo].[apu_tracking_fuel_data] (
    [apu_tracking_fuel_data_rid] BIGINT          IDENTITY (1, 1) NOT NULL,
    [tenant_id]                  NVARCHAR (100)  NULL,
    [asset_rid]                  INT             NULL,
    [country_id]                 INT             NULL,
    [state_id]                   INT             NULL,
    [position]                   NVARCHAR (1000) NULL,
    [latitude]                   DECIMAL (10, 6) NULL,
    [longitude]                  DECIMAL (10, 6) NULL,
    [start_engine_hours]         DECIMAL (12, 2) NULL,
    [end_engine_hours]           DECIMAL (12, 2) NULL,
    [total_engine_hours]         DECIMAL (12, 2) NULL,
    [total_fuel_savings]         DECIMAL (12, 2) NULL,
    [total_fuel_consumed]        DECIMAL (10, 2) NULL,
    [created]                    DATETIME        DEFAULT (getdate()) NOT NULL,
    [device_serial_number]       NVARCHAR (100)  NOT NULL,
    [equipment_serial_number]    NVARCHAR (100)  NOT NULL,
    [start_fuel_savings]         DECIMAL (12, 2) NULL,
    [end_fuel_savings]           DECIMAL (12, 2) NULL,
    [start_fuel_consumption]     DECIMAL (12, 2) NULL,
    [end_fuel_consumption]       DECIMAL (12, 2) NULL,
    [start_trip_date]            DATETIME        NULL,
    [end_trip_date]              DATETIME        NULL,
    FOREIGN KEY ([asset_rid]) REFERENCES [dbo].[asset] ([asset_rid]),
    FOREIGN KEY ([asset_rid]) REFERENCES [dbo].[asset] ([asset_rid])
);
GO

ALTER TABLE [dbo].[apu_tracking_fuel_data]
    ADD CONSTRAINT [idx_apu_tracking_fuel_dataPK] PRIMARY KEY CLUSTERED ([apu_tracking_fuel_data_rid] ASC);
GO

