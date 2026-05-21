CREATE TABLE [dbo].[optiset_temperature_profile_localisation]
(
    [optiset_temperature_profile_rid] INT NOT NULL,
    [optiset_language_type_code] VARCHAR(30) NOT NULL,
    [profile_description] NVARCHAR (100) NOT NULL,
    [created] DATETIME NOT NULL
);
GO

ALTER TABLE [dbo].[optiset_temperature_profile_localisation]
    ADD CONSTRAINT [idx_optiset_temperature_profile_localisationPK] PRIMARY KEY CLUSTERED ([optiset_temperature_profile_rid] ASC, [optiset_language_type_code] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[optiset_temperature_profile_localisation]
    ADD CONSTRAINT [DF_optiset_temperature_profile_localisation_optiset_language_type_code] DEFAULT (('OLT_ENGLISH')) FOR [optiset_language_type_code];
GO

ALTER TABLE [dbo].[optiset_temperature_profile_localisation]
    ADD CONSTRAINT [DF_optiset_temperature_profile_localisation_created] DEFAULT (getdate()) FOR [created];
GO

--ALTER TABLE [dbo].[optiset_temperature_profile_localisation]
--ADD CONSTRAINT [FK_optiset_temperature_profile_localisation_optiset_temperature_profile] FOREIGN KEY ([optiset_temperature_profile_rid]) REFERENCES [dbo].[lookup_code] ([code]);
--GO -- TODO FIX THIS - what was this referencing?  

ALTER TABLE [dbo].[optiset_temperature_profile_localisation]
    ADD CONSTRAINT [FK_optiset_temperature_profile_localisation_optiset_language_type] FOREIGN KEY ([optiset_language_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

