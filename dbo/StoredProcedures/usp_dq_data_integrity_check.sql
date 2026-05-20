CREATE PROCEDURE [dbo].[usp_dq_data_integrity_check]
AS
BEGIN
    SET NOCOUNT ON;

    -- Clear previous unresolved issues from this check run
   DELETE FROM dbo.dq_data_integrity_check WHERE ResolvedDate IS NULL;

    INSERT INTO dbo.dq_data_integrity_check
        (CheckName, TableName, ColumnName, OffendingValue, RowKey, ExpectedCategory, Notes)
   SELECT
        'WrongLookupList',
        'dbo.asset',
        'asset_type_code',
        e.asset_type_code, 
        CAST(e.asset_rid AS NVARCHAR(50)),
        'asset_type_code',
        'Code does not belong to expected lookup list'
        -- select *
    FROM [dbo].[asset]  e
    LEFT JOIN dbo.lookup_code lc
        ON lc.code = e.asset_type_code
       AND lc.lookup_list_code = 'asset_type'
    WHERE e.asset_type_code 
    IS NOT NULL
      AND lc.code IS NULL;


    -- Repeat the INSERT block for each FK column that should match a specific category
    -- e.g., Employee.StatusCode → StatusCode, Vehicle.RegionCode → Region, etc.

END
