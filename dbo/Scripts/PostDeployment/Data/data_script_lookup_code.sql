MERGE INTO dbo.lookup_code AS target
USING (VALUES
    ('test_type', 'TEST01a', 'Sedan', 'PassengerKLB_20260514_1759', '', '', 'former_code'),
    ('test_type', 'TEST01b', 'Truck', 'CommercialKLB_20260514_1759', '', '', 'former_code'),
    ('test_type', 'TEST01c', 'Van', 'CommercialKLB_20260514_1759', '', '', 'former_code'),
    ('test_type', 'TEST01d', 'Motorcycle', 'PassengerKLB_20260514_1759', '', '', 'former_code'),
    ('test_type2', 'TEST02a', 'Van', 'CommercialKLB_20260514_1759', '', '', 'former_code'),
    ('test_type2', 'TEST02b', 'Van', 'CommercialKLB_20260514_1759', '', '', 'former_code'),
    ('test_type2', 'TEST02c', 'Van', 'CommercialKLB_20260514_1759', '', '', 'former_code'),
    ('test_type2', 'TEST02d', 'Van', 'CommercialKLB_20260514_1759', '', '', 'former_code'),
    ('test_type3', 'TEST03a', 'Van', 'CommercialKLB_20260514_1759', '', '', 'former_code'),
    ('test_type3', 'TEST03b', 'Van', 'CommercialKLB_20260514_1759', '', '', 'former_code'),
    ('test_type3', 'TEST03c', 'Van', 'CommercialKLB_20260514_1759', '', '', 'former_code'),
    ('test_type3', 'TEST03d', 'Van', 'CommercialKLB_20260514_1759', '', '', 'former_code')

    -- controller_model_type
    ,('controller_model_type', 'CMT_TRIPAC2', 'TriPac 3', 'TriPac 3', '', '', '1258')
    ,('controller_model_type', 'CMT_SRXS', 'SRx Series', 'SRx Series', '', '', '1259')
    ,('controller_model_type', 'CMT_S750I', 'S-750i', 'S-750i', '', '', '1260')
    ,('controller_model_type', 'CMT_E1000M', 'e1000 / e1000M', 'e1000 / e1000M', '', '', '1261')
    ,('controller_model_type', 'CMT_ADVSDRC', 'Advancer S-DRC', 'Advancer S-DRC', '', '', '1262')

) AS source ([lookup_type],[code],[short_desc],[long_desc],[notes],[custom_col1] , former_code)
ON target.code = source.code

WHEN MATCHED AND (
        target.lookup_type <> source.lookup_type
     OR target.short_desc <> source.short_desc
     OR target.long_desc <> source.long_desc
     OR target.notes <> source.notes
     OR target.custom_col1 <> source.custom_col1
     OR target.former_code <> source.former_code
    ) THEN
    UPDATE SET
        target.lookup_type = source.lookup_type,
        target.short_desc = source.short_desc,
        target.long_desc = source.long_desc,
        target.notes = source.notes,
        target.custom_col1 = source.custom_col1,
        target.former_code = source.former_code

WHEN NOT MATCHED BY TARGET THEN
    INSERT ([lookup_type],[code],[short_desc],[long_desc],[notes],[custom_col1] , former_code)
    VALUES (source.lookup_type, source.code, source.short_desc, source.long_desc, source.notes, source.custom_col1, source.former_code)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE
;
