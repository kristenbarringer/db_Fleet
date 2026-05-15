CREATE PROCEDURE dbo.GetAssetsByIds
    @AssetIds dbo.AssetIdList READONLY,
    @tenantId VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        a.asset_rid   AS assetId,
        a.asset_name  AS assetName,
        a.asset_uuid  AS assetUuid
    FROM asset a
    INNER JOIN @AssetIds ids ON a.asset_rid = ids.id
    WHERE a.tenant_id = @tenantId
      AND a.active = 1
    OPTION (RECOMPILE);
END;
GO

