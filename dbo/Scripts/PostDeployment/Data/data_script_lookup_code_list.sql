MERGE INTO dbo.lookup_code_list AS target
USING (VALUES
-- tk2_Assets
 ('apu_country','Apu Country','Apu Country','CTR','tk2_Assets','dbo','apu_country')
,('asset_activation_status','Asset Activation Status','Asset Activation Status','AAS','tk2_Assets','dbo','asset_activation_status')
,('asset_type','Asset Type','Asset Type','ATC','tk2_Assets','dbo','asset_type')
,('asset_usage','Asset Usage','Asset Usage','AUS','tk2_Assets','dbo','asset_usage')
,('billing_service_level','Billing Service Level','Billing Service Level','BSL','tk2_Assets','dbo','billing_service_level')
,('colour','Colour','Colour','COL','tk2_Assets','dbo','colour')
,('controller_model_type','Controller Model Type','Controller Model Type','CMT','tk2_Assets','dbo','controller_model_type')
,('controller_type','Controller Type','Controller Type','CTP','tk2_Assets','dbo','controller_type')
,('device_sim_type','Device Sim Type','Device Sim Type','DST','tk2_Assets','dbo','device_sim_type')
,('device_type','Device Type','Device Type','DVT','tk2_Assets','dbo','device_type')
,('equipment_type','Equipment Type','Equipment Type','EQT','tk2_Assets','dbo','equipment_type')
,('gsm_provider_type','Gsm Provider Type','Gsm Provider Type','GSM','tk2_Assets','dbo','gsm_provider_type')
,('language_assets','Language','Language','LNG','tk2_Assets','dbo','language')
,('language_accounts','Language','Language','LNGAC','tk2_Accounts','dbo','language')
,('logging_interval','Logging Interval','Logging Interval','LIN','tk2_Assets','dbo','logging_interval')
,('optiset_language_type','Optiset Language Type','Optiset Language Type','OLT','tk2_Assets','dbo','optiset_language_type')
,('power_source','Power Source','Power Source','PWS','tk2_Assets','dbo','power_source')
,('telematics_mode_type','Telematics Mode Type','Telematics Mode Type','TMT','tk2_Assets','dbo','telematics_mode_type')

-- tk2_Accounts
,('billing_option_type','Billing Option Type','Billing Option Type','BOT','tk2_Accounts','dbo','billing_option_type')
,('fuel_type','Fuel Type','Fuel Type','FLT','tk2_Accounts','dbo','fuel_type')

) AS source (lookup_list_code,lookup_list_short_desc,lookup_list_long_desc,lookup_list_abbrev,former_table_db,former_table_schema,former_table_name)
ON target.lookup_list_code = source.lookup_list_code

WHEN MATCHED AND (
        target.lookup_list_short_desc <> source.lookup_list_short_desc
     OR target.lookup_list_long_desc <> source.lookup_list_long_desc
     OR target.lookup_list_abbrev <> source.lookup_list_abbrev
     OR target.former_table_db <> source.former_table_db
     OR target.former_table_schema <> source.former_table_schema
     OR target.former_table_name <> source.former_table_name 
    ) THEN
    UPDATE SET
        target.lookup_list_short_desc = source.lookup_list_short_desc,
        target.lookup_list_long_desc = source.lookup_list_long_desc,
        target.lookup_list_abbrev = source.lookup_list_abbrev,
        target.former_table_db = source.former_table_db,
        target.former_table_schema = source.former_table_schema,
        target.former_table_name = source.former_table_name

WHEN NOT MATCHED BY TARGET THEN
    INSERT (lookup_list_code,lookup_list_short_desc,lookup_list_long_desc,lookup_list_abbrev,former_table_db,former_table_schema,former_table_name)
    VALUES (source.lookup_list_code,source.lookup_list_short_desc,source.lookup_list_long_desc,source.lookup_list_abbrev,source.former_table_db,source.former_table_schema,source.former_table_name)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE
;
