MERGE INTO dbo.lookup_code_list AS target
USING (VALUES
    ('test_type', 'designation_type', 'Designation Type', 'testdb','testsch','testtbl'),
    ('test_type2', 'agent_type', 'Agent Type', 'testdb','testsch','testtbl'),
    ('test_type3', 'sales_type', 'Sales Type', 'testdb','testsch','testtbl')

    -- controller_model_type
    ,('controller_model_type', 'controller_model_type', 'Controller Model Type', 'tk2_Assets','dbo','controller_model_type')

    
) AS source (lookup_type_code, short_desc, long_desc, former_table_db, former_table_schema, former_table_name)
ON target.lookup_type_code = source.lookup_type_code

WHEN MATCHED AND (
        target.short_desc <> source.short_desc
     OR target.long_desc <> source.long_desc
     OR target.former_table_db <> source.former_table_db
     OR target.former_table_schema <> source.former_table_schema
     OR target.former_table_name <> source.former_table_name 
    ) THEN
    UPDATE SET
        target.short_desc = source.short_desc,
        target.long_desc = source.long_desc,
        target.former_table_db = source.former_table_db,
        target.former_table_schema = source.former_table_schema,
        target.former_table_name = source.former_table_name

WHEN NOT MATCHED BY TARGET THEN
    INSERT (lookup_type_code, short_desc, long_desc, former_table_db, former_table_schema, former_table_name)
    VALUES (source.lookup_type_code, source.short_desc, source.long_desc, source.former_table_db, source.former_table_schema, source.former_table_name)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE
;
