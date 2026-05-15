MERGE INTO dbo.test_referring_tbl AS target
USING (VALUES
    ('1', 'ATC_RAIL_CAR', 'AUS_FOOD_SHIPMENTS', 'COL_ORANGE', ''),
    ('2', 'CTP_E_200', 'CTP_HMI_35', 'CTP_SR4_ST_TRUCK', ''),
    ('3', 'CTP_UPIV_TIP', 'LIN_5', 'OLT_CZECH', ''),
    ('4', 'OLT_NORWEGIAN', 'TMT_IBOX_MODE', 'TMT_TRACKING_IBOX', '')
) AS source (ID, test_type1_code, test_type2_code, test_type3_code, notes )
ON target.ID = source.ID

WHEN MATCHED AND (
        target.test_type1_code <> source.test_type1_code
     OR target.test_type2_code <> source.test_type2_code
     OR target.test_type3_code <> source.test_type3_code
     OR target.notes <> source.notes
    ) THEN
    UPDATE SET
        target.test_type1_code = source.test_type1_code,
        target.test_type2_code = source.test_type2_code,
        target.test_type3_code = source.test_type3_code,
        target.notes = source.notes

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ID, test_type1_code, test_type2_code, test_type3_code, notes)
    VALUES (source.ID, source.test_type1_code, source.test_type2_code, source.test_type3_code, source.notes)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE
;
