print 'is this on';
/*
-- post-deploy data load 
MERGE INTO dbo.zzz_test_pipeline_20260514_1707 AS target
USING (VALUES
    (1, 'Sedan', 'Passenger'),
    (2, 'Truck', 'Commercial'),
    (3, 'Van', 'Commercial'),
    (4, 'Motorcycle', 'Passenger')
) AS source (ID, desc1, desc2)
ON target.ID = source.ID

WHEN MATCHED AND (
        target.desc1 <> source.desc1
     OR target.desc2 <> source.desc2
    ) THEN
    UPDATE SET
        target.desc1 = source.desc1,
        target.desc2 = source.desc2

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ID, desc1, desc2)
    VALUES (source.ID, source.desc1, source.desc2)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE

; -- the trailing semicolon is REQUIRED on MERGE
*/