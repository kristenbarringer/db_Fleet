MERGE INTO dbo.lookup_code AS target
USING (VALUES
    ('test_type', 'TEST01a', 'Sedan', 'PassengerKLB_20260514_1759', '', ''),
    ('test_type', 'TEST01b', 'Truck', 'CommercialKLB_20260514_1759', '', ''),
    ('test_type', 'TEST01c', 'Van', 'CommercialKLB_20260514_1759', '', ''),
    ('test_type', 'TEST01d', 'Motorcycle', 'PassengerKLB_20260514_1759', '', '')
) AS source ([lookup_type],[code],[short_desc],[long_desc],[notes],[custom_col1] )
ON target.lookup_type = source.lookup_type
and target.code = source.code

WHEN MATCHED AND (
        target.short_desc <> source.short_desc
     OR target.long_desc <> source.long_desc
     OR target.notes <> source.notes
     OR target.custom_col1 <> source.custom_col1
    ) THEN
    UPDATE SET
        target.short_desc = source.short_desc,
        target.long_desc = source.long_desc,
        target.notes = source.notes,
        target.custom_col1 = source.custom_col1

WHEN NOT MATCHED BY TARGET THEN
    INSERT ([lookup_type],[code],[short_desc],[long_desc],[notes],[custom_col1] )
    VALUES (source.lookup_type, source.code, source.short_desc, source.long_desc, source.notes, source.custom_col1)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE
;
