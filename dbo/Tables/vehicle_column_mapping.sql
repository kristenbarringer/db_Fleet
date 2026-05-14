CREATE TABLE [dbo].[vehicle_column_mapping] (
    [vehicle_column] [sysname] NOT NULL,
    [target_table]   [sysname] NOT NULL,
    [target_column]  [sysname] NOT NULL,
    PRIMARY KEY CLUSTERED ([vehicle_column] ASC, [target_table] ASC)
);
GO

