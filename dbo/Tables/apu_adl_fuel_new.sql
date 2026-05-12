CREATE TABLE [dbo].[apu_adl_fuel_new] (
    [customer_rid]             INT            NULL,
    [vehicle_rid]              INT            NULL,
    [tenant_id]                NVARCHAR (100) NULL,
    [asset_uuid]               NVARCHAR (100) NULL,
    [telematics_serial_number] VARCHAR (30)   NULL,
    [unitinfo_serial_number]   VARCHAR (20)   NULL,
    [month_year]               INT            NULL,
    [state_name]               VARCHAR (5)    NULL,
    [total_fuel_consumed]      FLOAT (53)     NULL,
    [locked]                   NVARCHAR (10)  NULL,
    [country_id]               NVARCHAR (10)  NULL,
    [source]                   VARCHAR (50)   NULL
);
GO

