-- =============================================================================
-- Stored Procedure: usp_seed_reset_all
-- Purpose:  Wipe all seed test data from Fleet tables, in reverse dependency
--           order (children first, parents last).
-- Scope:    Dev environments ONLY.
-- Notes:    Each individual loader already does its own DELETE, so this proc
--           is for "wipe without re-load" scenarios.
-- =============================================================================
CREATE PROCEDURE dbo.usp_seed_reset_all
AS
BEGIN
    SET NOCOUNT ON;

    -- Guard: only allow on Dev servers
    IF @@SERVERNAME NOT LIKE '%dev%'
    BEGIN
        RAISERROR('usp_seed_reset_all may only run on Dev servers. Current server: %s', 16, 1, @@SERVERNAME);
        RETURN;
    END;

    PRINT '=== Starting seed data reset ===';

    -- Reverse FK order: children first, then parents
    DELETE FROM dbo.device;
    PRINT CONCAT('  Cleared dbo.device (', @@ROWCOUNT, ' row(s)).');

    DELETE FROM dbo.asset;
    PRINT CONCAT('  Cleared dbo.asset (', @@ROWCOUNT, ' row(s)).');

    PRINT '=== Seed data reset complete ===';
END;
GO
