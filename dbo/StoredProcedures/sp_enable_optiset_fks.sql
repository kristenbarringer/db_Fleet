
CREATE   PROCEDURE sp_enable_optiset_fks
AS
BEGIN
    ALTER TABLE dbo.optiset_file 
        WITH CHECK CHECK CONSTRAINT ALL;

    ALTER TABLE dbo.optiset_temperature_profile 
        WITH CHECK CHECK CONSTRAINT ALL;

    ALTER TABLE dbo.optiset_temperature_profile_localisation 
        WITH CHECK CHECK CONSTRAINT ALL;
END
GO

