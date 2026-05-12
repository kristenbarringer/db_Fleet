CREATE   PROCEDURE sp_disable_optiset_fks
AS
BEGIN
    ALTER TABLE dbo.optiset_file 
        NOCHECK CONSTRAINT ALL;

    ALTER TABLE dbo.optiset_temperature_profile 
        NOCHECK CONSTRAINT ALL;

    ALTER TABLE dbo.optiset_temperature_profile_localisation 
        NOCHECK CONSTRAINT ALL;
END
GO

