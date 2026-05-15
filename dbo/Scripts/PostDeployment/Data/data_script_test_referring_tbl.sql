MERGE INTO dbo.test_referring_tbl AS target
USING (VALUES
    ('1', 'TEST01a', 'TEST02a', 'TEST03a', ''),
    ('2', 'TEST01b', 'TEST02b', 'TEST03b', ''),
    ('3', 'TEST01c', 'TEST02c', 'TEST03c', ''),
    ('4', 'TEST01d', 'TEST02d', 'TEST03d', '')
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
