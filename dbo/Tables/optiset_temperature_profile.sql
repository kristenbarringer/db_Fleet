CREATE TABLE [dbo].[optiset_temperature_profile] (
    [optiset_temperature_profile_rid] INT            IDENTITY (1, 1) NOT NULL,
    [optiset_file_rid]                INT            NOT NULL,
    [profile_id]                      BIGINT         NOT NULL,
    [profile_description]             NVARCHAR (100) NULL,
    [default_setpoint_value]          DECIMAL (6, 2) NULL,
    [minimum_setpoint_value]          DECIMAL (6, 2) NULL,
    [maximum_setpoint_value]          DECIMAL (6, 2) NULL,
    [created]                         DATETIME       NOT NULL,
    [profile_id_hex_value]            VARCHAR (20)   DEFAULT ((0)) NOT NULL
)
WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[optiset_temperature_profile]
    ADD CONSTRAINT [FK_optiset_temperature_profile_tk_optiset_file] FOREIGN KEY ([optiset_file_rid]) REFERENCES [dbo].[optiset_file] ([optiset_file_rid]);
GO

ALTER TABLE [dbo].[optiset_temperature_profile]
    ADD CONSTRAINT [idx_tk_optiset_temperature_profilePK] PRIMARY KEY NONCLUSTERED ([optiset_temperature_profile_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[optiset_temperature_profile]
    ADD CONSTRAINT [DF_optiset_temperature_profile_created] DEFAULT (getdate()) FOR [created];
GO

