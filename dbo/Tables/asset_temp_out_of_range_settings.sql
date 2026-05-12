CREATE TABLE [dbo].[asset_temp_out_of_range_settings] (
    [rid]                          INT           IDENTITY (1, 1) NOT NULL,
    [asset_rid]                    INT           NOT NULL,
    [high_temperature_zone_1]      INT           NULL,
    [low_temperature_zone_1]       INT           NULL,
    [out_of_range_time_zone_1]     INT           NULL,
    [high_temperature_zone_2]      INT           NULL,
    [low_temperature_zone_2]       INT           NULL,
    [out_of_range_time_zone_2]     INT           NULL,
    [high_temperature_zone_3]      INT           NULL,
    [low_temperature_zone_3]       INT           NULL,
    [out_of_range_time_zone_3]     INT           NULL,
    [status]                       BIT           NULL,
    [out_of_range_relative_zone_1] INT           NULL,
    [out_of_range_relative_zone_2] INT           NULL,
    [out_of_range_relative_zone_3] INT           NULL,
    [created]                      DATETIME      NULL,
    [last_modified_date]           DATETIME      NULL,
    [tenant_id]                    NVARCHAR (50) NULL
)
WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[asset_temp_out_of_range_settings]
    ADD CONSTRAINT [DF_asset_temp_out_of_range_settings_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[asset_temp_out_of_range_settings]
    ADD CONSTRAINT [FK_asset_temp_out_of_range_settings_asset] FOREIGN KEY ([asset_rid]) REFERENCES [dbo].[asset] ([asset_rid]);
GO

ALTER TABLE [dbo].[asset_temp_out_of_range_settings]
    ADD CONSTRAINT [idx_asset_temp_out_of_range_settingsPK] PRIMARY KEY NONCLUSTERED ([rid] ASC) WITH (FILLFACTOR = 95, DATA_COMPRESSION = PAGE);
GO

