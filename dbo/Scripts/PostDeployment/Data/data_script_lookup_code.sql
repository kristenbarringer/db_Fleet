MERGE INTO dbo.lookup_code AS target
USING (VALUES
-- tk2_Assets
 ('asset_activation_status','ACTIVATED','activated','AAS_ACTIVATED','Activated','Activated','','','','','','2','1')
,('asset_activation_status','DEACTIVATED','deactivated','AAS_DEACTIVATED','Deactivated','Deactivated','','','','','','3','1')
,('asset_activation_status','FAILED','failed','AAS_FAILED','Failed','Failed','','','','','','4','1')
,('asset_activation_status','PENDING_ACTIVATION','pendingActivation','AAS_PENDING_ACTIVATION','Pending activation','Pending activation','','','','','','1','1')
,('asset_type','BUS','bus','ATC_BUS','Bus','Bus','','asset_icon','bus.jpg','','','1','1')
,('asset_type','CONTAINER','container','ATC_CONTAINER','Container','Container','','asset_icon','container.jpg','','','2','1')
,('asset_type','RAIL_CAR','railCar','ATC_RAIL_CAR','Rail Car','Rail Car','','asset_icon','railCar.jpg','','','4','1')
,('asset_type','TRACTOR','tractor','ATC_TRACTOR','Tractor','Tractor','','asset_icon','tractor.jpg','','','5','1')
,('asset_type','TRAILER','trailer','ATC_TRAILER','Trailer','Trailer','','asset_icon','trailer.jpg','','','6','1')
,('asset_type','TRUCK','truck','ATC_TRUCK','Truck','Truck','','asset_icon','truck.jpg','','','3','1')
,('asset_type','VAN','van','ATC_VAN','Van','Van','','asset_icon','van.jpg','','','7','1')
,('asset_usage','DAIRY_PRODUCTS','dairyProducts','AUS_DAIRY_PRODUCTS','Dairy Products','Dairy Products','','','','','','3','1')
,('asset_usage','FOOD_SHIPMENTS','foodShipments','AUS_FOOD_SHIPMENTS','Food shipments','Food shipments','','','','','','1','1')
,('asset_usage','FRESH_FRUITS_AND_VEGETABLES','freshFruitsAndVegetables','AUS_FRESH_FRUITS_AND_VEGETABLES','Fresh fruits and vegetables','Fresh fruits and vegetables','','','','','','2','1')
,('asset_usage','HEALTHCARE_SUPPLIES','healthcareSupplies','AUS_HEALTHCARE_SUPPLIES','Healthcare supplies','Healthcare supplies','','','','','','5','1')
,('asset_usage','MEAT_AND_SEAFOOD','meatAndSeafood','AUS_MEAT_AND_SEAFOOD','Meat and Seafood','Meat and Seafood','','','','','','4','1')
,('asset_usage','OTHER','other','AUS_OTHER','Other','Other','','','','','','7','1')
,('asset_usage','VACCINES_AND_MEDICATIONS','vaccinesAndMedications','AUS_VACCINES_AND_MEDICATIONS','Vaccines and medications','Vaccines and medications','','','','','','6','1')
,('controller_model_type','ADVANCER_S_DRC','advancerSDrc','CMT_ADVANCER_S_DRC','Advancer S-DRC','Advancer S-DRC','','','','','','1262','1')
,('controller_model_type','E1000_E1000M','e1000E1000m','CMT_E1000_E1000M','e1000 / e1000M','e1000 / e1000M','','','','','','1261','1')
,('controller_model_type','S_750I','s750i','CMT_S_750I','S-750i','S-750i','','','','','','1260','1')
,('controller_model_type','SRX_SERIES','srxSeries','CMT_SRX_SERIES','SRx Series','SRx Series','','','','','','1259','1')
,('controller_model_type','TRIPAC_3','tripac3','CMT_TRIPAC_3','TriPac 3','TriPac 3','','','','','','1258','1')
,('colour','BLUE','blue','COL_BLUE','Blue','Blue','','rgbvalue','#0000FF','','','1','1')
,('colour','GREEN','green','COL_GREEN','Green','Green','','rgbvalue','#00FF00','','','3','1')
,('colour','ORANGE','orange','COL_ORANGE','Orange','Orange','','rgbvalue','#FF6600','','','6','1')
,('colour','PURPLE','purple','COL_PURPLE','Purple','Purple','','rgbvalue','#800080','','','7','1')
,('colour','RED','red','COL_RED','Red','Red','','rgbvalue','#FF0000','','','2','1')
,('colour','WHITE','white','COL_WHITE','White','White','','rgbvalue','#FFFFFF','','','5','1')
,('colour','YELLOW','yellow','COL_YELLOW','Yellow','Yellow','','rgbvalue','#FFFF00','','','4','1')
,('controller_type','A_SERIES','aSeries','CTP_A_SERIES','A Series','A Series','','is_multi_temp','','','','80','1')
,('controller_type','ADVANCER_S_DRC','advancerSDrc','CTP_ADVANCER_S_DRC','ADVANCER S-DRC','Railblazer','','is_multi_temp','','','','176','1')
,('controller_type','AI','ai','CTP_AI','AI','AI','','is_multi_temp','','','','21','1')
,('controller_type','CARRIER','carrier','CTP_CARRIER','Carrier','Carrier','','is_multi_temp','','','','190','1')
,('controller_type','CRYO_TECH_TRAILER','cryoTechTrailer','CTP_CRYO_TECH_TRAILER','CRYO_TECH_TRAILER','CRYO_TECH_TRAILER','','is_multi_temp','','','','61','1')
,('controller_type','CRYO_TECH_TRUCK','cryoTechTruck','CTP_CRYO_TECH_TRUCK','CRYO_TECH_TRUCK','CRYO_TECH_TRUCK','','is_multi_temp','','','','62','1')
,('controller_type','DAS','das','CTP_DAS','DAS','DAS','','is_multi_temp','','','','18','1')
,('controller_type','DAS_IV','dasIv','CTP_DAS_IV','DAS IV','DAS IV','','is_multi_temp','','','','44','1')
,('controller_type','DMS','dms','CTP_DMS','DMS','DMS','','is_multi_temp','','','','2','1')
,('controller_type','E_200','e200','CTP_E_200','E-200','E-200','','is_multi_temp','','','','69','1')
,('controller_type','E1000','e1000','CTP_E1000','e1000','Nebula','','is_multi_temp','','','','128','1')
,('controller_type','E1000M','e1000m','CTP_E1000M','e1000M','e1000M','','is_multi_temp','1','','','129','1')
,('controller_type','HMI_1','hmi1','CTP_HMI_1','HMI-1','HMI-1','','is_multi_temp','','','','27','1')
,('controller_type','HMI_33','hmi33','CTP_HMI_33','HMI','HMI','','is_multi_temp','','','','33','1')
,('controller_type','HMI_34','hmi34','CTP_HMI_34','HMI','HMI','','is_multi_temp','','','','34','1')
,('controller_type','HMI_35','hmi35','CTP_HMI_35','HMI','HMI','','is_multi_temp','','','','35','1')
,('controller_type','HMI_36','hmi36','CTP_HMI_36','HMI','HMI','','is_multi_temp','','','','36','1')
,('controller_type','I_BOX','iBox','CTP_I_BOX','I-Box','I-Box','','is_multi_temp','','','','31','1')
,('controller_type','I_BOX_II','iBoxIi','CTP_I_BOX_II','I-Box II','I-Box II','','is_multi_temp','','','','32','1')
,('controller_type','I_BOX2','iBox2','CTP_I_BOX2','I-Box2','I-Box2','','is_multi_temp','','','','30','1')
,('controller_type','MP_D','mpD','CTP_MP_D','MP-D','MP-D','','is_multi_temp','','','','10','1')
,('controller_type','MP_G','mpG','CTP_MP_G','MP-G','MP-G','','is_multi_temp','','','','24','1')
,('controller_type','MP_T','mpT','CTP_MP_T','MP-T','MP-T','','is_multi_temp','','','','23','1')
,('controller_type','NONE','none','CTP_NONE','None','None','','is_multi_temp','','','','0','1')
,('controller_type','POSITRON','positron','CTP_POSITRON','positron','positron','','is_multi_temp','','','','144','1')
,('controller_type','S_750I','s750i','CTP_S_750I','S-750i','DEET','','is_multi_temp','','','','112','1')
,('controller_type','S_750M','s750m','CTP_S_750M','S-750M','S750i Unit Controller MT','','is_multi_temp','1','','','113','1')
,('controller_type','SR2_MT_TRAILER','sr2MtTrailer','CTP_SR2_MT_TRAILER','SR2 MT Trailer','SR2 MultiZone','','is_multi_temp','1','','','39','1')
,('controller_type','SR2_MT_TRUCK','sr2MtTruck','CTP_SR2_MT_TRUCK','SR2 MT Truck','SR2 Truck-MultiZone','','is_multi_temp','1','','','40','1')
,('controller_type','SR2_ST_TRAILER','sr2StTrailer','CTP_SR2_ST_TRAILER','SR2 ST Trailer','SR2 Trailer','','is_multi_temp','','','','37','1')
,('controller_type','SR2_ST_TRUCK','sr2StTruck','CTP_SR2_ST_TRUCK','SR2 ST Truck','SR2-Truck','','is_multi_temp','','','','38','1')
,('controller_type','SR3_MT_TRAILER','sr3MtTrailer','CTP_SR3_MT_TRAILER','SR3 MT Trailer','SR3_TRAILER_MT','','is_multi_temp','1','','','47','1')
,('controller_type','SR3_MT_TRUCK','sr3MtTruck','CTP_SR3_MT_TRUCK','SR3 MT Truck','SR3_TRUCK_MT','','is_multi_temp','1','','','48','1')
,('controller_type','SR3_ST_TRAILER','sr3StTrailer','CTP_SR3_ST_TRAILER','SR3 ST Trailer','SR3_TRAILER_ST','','is_multi_temp','','','','45','1')
,('controller_type','SR3_ST_TRUCK','sr3StTruck','CTP_SR3_ST_TRUCK','SR3 ST Truck','SR3_TRUCK_ST','','is_multi_temp','','','','46','1')
,('controller_type','SR4_HMI','sr4Hmi','CTP_SR4_HMI','SR4_HMI','SR4_HMI','','is_multi_temp','','','','60','1')
,('controller_type','SR4_MT_TRAILER','sr4MtTrailer','CTP_SR4_MT_TRAILER','SR4 MT Trailer','SR4_TRAILER_MT','','is_multi_temp','1','','','55','1')
,('controller_type','SR4_MT_TRUCK','sr4MtTruck','CTP_SR4_MT_TRUCK','SR4 MT Truck','SR4_TRUCK_MT','','is_multi_temp','1','','','56','1')
,('controller_type','SR4_ST_TRAILER','sr4StTrailer','CTP_SR4_ST_TRAILER','SR4 ST Trailer','SR4_TRAILER_ST','','is_multi_temp','','','','53','1')
,('controller_type','SR4_ST_TRUCK','sr4StTruck','CTP_SR4_ST_TRUCK','SR4 ST Truck','SR4_TRUCK_ST','','is_multi_temp','','','','54','1')
,('controller_type','TGVI','tgvi','CTP_TGVI','TGVI','TGVI','','is_multi_temp','','','','6','1')
,('controller_type','TGVII_HEATER','tgviiHeater','CTP_TGVII_HEATER','TGVII Heater','TGVII Heater','','is_multi_temp','','','','73','1')
,('controller_type','TKDL_PRO','tkdlPro','CTP_TKDL_PRO','TKDL Pro','TKDL Pro','','is_multi_temp','','','','66','1')
,('controller_type','TKDL_XL','tkdlXl','CTP_TKDL_XL','TKDL XL','TKDL XL','','is_multi_temp','','','','65','1')
,('controller_type','TOUCHLOG','touchlog','CTP_TOUCHLOG','TOUCHLOG','TOUCHLOG','','is_multi_temp','','','','67','1')
,('controller_type','TSD_HMI','tsdHmi','CTP_TSD_HMI','TSD-HMI','TSD-HMI','','is_multi_temp','','','','41','1')
,('controller_type','TTMT','ttmt','CTP_TTMT','TTMT','TTMT','','is_multi_temp','','','','25','1')
,('controller_type','UNKNOWN','unknown','CTP_UNKNOWN','Unknown','Unknown','','is_multi_temp','','','','-1','1')
,('controller_type','UP_CR','upCr','CTP_UP_CR','UP-CR','UP-CR','','is_multi_temp','','','','26','1')
,('controller_type','UP_VP_14','upVp14','CTP_UP_VP_14','UP-VP','UP-VP','','is_multi_temp','','','','14','1')
,('controller_type','UP_VP_28','upVp28','CTP_UP_VP_28','UP-VP','UP-VP','','is_multi_temp','','','','28','1')
,('controller_type','UP_VP_29','upVp29','CTP_UP_VP_29','UP-VP','UP-VP','','is_multi_temp','','','','29','1')
,('controller_type','UPA','upa','CTP_UPA','UPA','UPA','','is_multi_temp','','','','13','1')
,('controller_type','UPA_PLUS','upaPlus','CTP_UPA_PLUS','upA+','upA+','','is_multi_temp','','','','8','1')
,('controller_type','UPIV','upiv','CTP_UPIV','UPIV','UPIV','','is_multi_temp','','','','1','1')
,('controller_type','UPIV_RC2','upivRc2','CTP_UPIV_RC2','uPIV RC2','uPIV RC2','','is_multi_temp','','','','5','1')
,('controller_type','UPIV_SCREW','upivScrew','CTP_UPIV_SCREW','uPIV Screw','uPIV Screw','','is_multi_temp','','','','11','1')
,('controller_type','UPIV_SMX','upivSmx','CTP_UPIV_SMX','uPIV SMX','uPIV SMX','','is_multi_temp','','','','3','1')
,('controller_type','UPIV_TCI','upivTci','CTP_UPIV_TCI','uPIV TCI','uPIV TCI','','is_multi_temp','','','','4','1')
,('controller_type','UPIV_TIP','upivTip','CTP_UPIV_TIP','uPIV TIP','uPIV TIP','','is_multi_temp','','','','9','1')
,('controller_type','UPIVE','upive','CTP_UPIVE','UpIVE','UpIVE','','is_multi_temp','','','','7','1')
,('controller_type','UPV_ETV','upvEtv','CTP_UPV_ETV','upV ETV','upV ETV','','is_multi_temp','','','','17','1')
,('controller_type','UPV_KOR','upvKor','CTP_UPV_KOR','upV KOR','upV KOR','','is_multi_temp','','','','12','1')
,('controller_type','UPV_MPR','upvMpr','CTP_UPV_MPR','upV MPR','upV MPR','','is_multi_temp','','','','15','1')
,('controller_type','UPV_SCREW_YANMAR','upvScrewYanmar','CTP_UPV_SCREW_YANMAR','upV Screw/Yanmar','upV Screw/Yanmar','','is_multi_temp','','','','16','1')
,('controller_type','UPVI_19','upvi19','CTP_UPVI_19','UpVI','UpVI','','is_multi_temp','','','','19','1')
,('controller_type','UPVI_20','upvi20','CTP_UPVI_20','UpVI','UpVI','','is_multi_temp','','','','20','1')
,('controller_type','UPVI_22','upvi22','CTP_UPVI_22','UpVI','UpVI','','is_multi_temp','','','','22','1')
,('controller_type','VP_TRUCK_VIA_TOUCHLOG','vpTruckViaTouchlog','CTP_VP_TRUCK_VIA_TOUCHLOG','VP Truck via TOUCHLOG','VP Truck via TOUCHLOG','','is_multi_temp','','','','64','1')
,('apu_country','CANADA','canada','CTR_CANADA','Canada','Canada','','','','','','2','1')
,('apu_country','MEXICO','mexico','CTR_MEXICO','Mexico','Mexico','','','','','','3','1')
,('apu_country','US','us','CTR_US','US','US','','','','','','1','1')
,('device_sim_type','PRIMARY_EMBEDDED_SIM','primaryEmbeddedSim','DST_PRIMARY_EMBEDDED_SIM','Primary/embedded SIM','Primary/embedded SIM','','','','','','1','1')
,('device_sim_type','SECONDARY_SIM','secondarySim','DST_SECONDARY_SIM','Secondary SIM','Secondary SIM','','','','','','2','1')
,('device_type','BLUEBOX','bluebox','DVT_BLUEBOX','BlueBox','description','','','','','','1','1')
,('device_type','TRACKING_V5','trackingV5','DVT_TRACKING_V5','TracKing V5','description','','','','','','2','1')
,('equipment_type','750I','750i','EQT_750I','750i','750i','','','','','','4','0')
,('equipment_type','APU','apu','EQT_APU','APU','APU','','','','','','1','1')
,('equipment_type','HEATKING','heatking','EQT_HEATKING','HeatKing','HeatKing','','','','','','3','0')
,('equipment_type','HMI_6','hmi6','EQT_HMI','HMI','HMI','','','','','','6','0')
,('equipment_type','REEFER','reefer','EQT_REEFER','Reefer','Reefer','','','','','','2','1')
,('equipment_type','UNKNOWN','unknown','EQT_UNKNOWN','Unknown','Unknown','','','','','','5','0')
,('gsm_provider_type','AT_T','atT','GSM_AT_T','AT&T','AT&T','','','','','','8','1')
,('gsm_provider_type','CUSTOMER_OWNED','customerOwned','GSM_CUSTOMER_OWNED','Customer Owned','Customer Owned','','','','','','3','1')
,('gsm_provider_type','MOBISTAR','mobistar','GSM_MOBISTAR','MobiStar','MobiStar','','','','','','7','1')
,('gsm_provider_type','O2_IRL','o2Irl','GSM_O2_IRL','O2 - IRL','O2 - IRL','','','','','','1','1')
,('gsm_provider_type','ORANGE','orange','GSM_ORANGE','Orange','Orange','','','','','','2','1')
,('gsm_provider_type','STARHUB','starhub','GSM_STARHUB','StarHub','StarHub','','','','','','9','1')
,('gsm_provider_type','T_MOBILE','tMobile','GSM_T_MOBILE','T-Mobile','T-Mobile','','','','','','6','1')
,('gsm_provider_type','UNKNOWN','unknown','GSM_UNKNOWN','Unknown','Unknown','','','','','','0','1')
,('gsm_provider_type','VODAFONE_IRL','vodafoneIrl','GSM_VODAFONE_IRL','Vodafone - IRL','Vodafone - IRL','','','','','','4','1')
,('gsm_provider_type','WYLESS','wyless','GSM_WYLESS','Wyless','Wyless','','','','','','5','1')
,('logging_interval','1','1','LIN_1','1','1','','','','','','1','1')
,('logging_interval','10','10','LIN_10','10','10','','','','','','4','0')
,('logging_interval','120','120','LIN_120','120','120','','','','','','9','1')
,('logging_interval','15','15','LIN_15','15','15','','','','','','5','1')
,('logging_interval','2','2','LIN_2','2','2','','','','','','2','0')
,('logging_interval','240','240','LIN_240','240','240','','','','','','8','1')
,('logging_interval','30','30','LIN_30','30','30','','','','','','6','1')
,('logging_interval','360','360','LIN_360','360','360','','','','','','10','1')
,('logging_interval','5','5','LIN_5','5','5','','','','','','3','1')
,('logging_interval','60','60','LIN_60','60','60','','','','','','7','1')
,('logging_interval','720','720','LIN_720','720','720','','','','','','11','1')
,('language','CZECH','czech','LNG_CZECH','Czech','Czech','','lang_id','CS','country_id','CZ','14','1')
,('language','DUTCH','dutch','LNG_DUTCH','Dutch','Dutch','','lang_id','NL','country_id','NL','1','1')
,('language','ENGLISH','english','LNG_ENGLISH','English','English','','lang_id','EN','country_id','IE','2','1')
,('language','ENGLISH_US','englishUs','LNG_ENGLISH_US','English (US)','English (US)','','lang_id','EN','country_id','US','4','1')
,('language','ESTONIAN','estonian','LNG_ESTONIAN','Estonian','Estonian','','lang_id','ET','country_id','ET','17','1')
,('language','FINNISH','finnish','LNG_FINNISH','Finnish','Finnish','','lang_id','FI','country_id','FI','10','1')
,('language','FRENCH','french','LNG_FRENCH','French','French','','lang_id','FR','country_id','FR','5','1')
,('language','GERMAN','german','LNG_GERMAN','German','German','','lang_id','DE','country_id','DE','6','1')
,('language','GREEK','greek','LNG_GREEK','Greek','Greek','','lang_id','EL','country_id','GR','12','1')
,('language','HEBREW','hebrew','LNG_HEBREW','Hebrew','Hebrew','','lang_id','IW','country_id','IW','9','1')
,('language','ITALIAN','italian','LNG_ITALIAN','Italian','Italian','','lang_id','IT','country_id','IT','7','1')
,('language','POLISH','polish','LNG_POLISH','Polish','Polish','','lang_id','PL','country_id','PL','13','1')
,('language','PORTUGUESE','portuguese','LNG_PORTUGUESE','Portuguese','Portuguese','','lang_id','PT','country_id','PG','16','1')
,('language','RUSSIAN','russian','LNG_RUSSIAN','Russian','Russian','','lang_id','RU','country_id','RU','11','1')
,('language','SPANISH','spanish','LNG_SPANISH','Spanish','Spanish','','lang_id','ES','country_id','ES','8','1')
,('language','SWEDISH','swedish','LNG_SWEDISH','Swedish','Swedish','','lang_id','SV','country_id','SW','15','1')
,('optiset_language_type','ARABIC','arabic','OLT_ARABIC','ARABIC','ARABIC','','language_rid','2','','','22','1')
,('optiset_language_type','BULGARIAN','bulgarian','OLT_BULGARIAN','BULGARIAN','BULGARIAN','','language_rid','2','','','17','1')
,('optiset_language_type','CHINESE','chinese','OLT_CHINESE','CHINESE','CHINESE','','language_rid','2','','','23','1')
,('optiset_language_type','CZECH','czech','OLT_CZECH','CZECH','CZECH','','language_rid','14','','','18','1')
,('optiset_language_type','DANISH','danish','OLT_DANISH','DANISH','DANISH','','language_rid','2','','','7','1')
,('optiset_language_type','DUTCH','dutch','OLT_DUTCH','DUTCH','DUTCH','','language_rid','1','','','6','1')
,('optiset_language_type','ENGLISH','english','OLT_ENGLISH','ENGLISH','ENGLISH','','language_rid','2','','','1','1')
,('optiset_language_type','FINNISH','finnish','OLT_FINNISH','FINNISH','FINNISH','','language_rid','10','','','13','1')
,('optiset_language_type','FRENCH','french','OLT_FRENCH','FRENCH','FRENCH','','language_rid','5','','','3','1')
,('optiset_language_type','GERMAN','german','OLT_GERMAN','GERMAN','GERMAN','','language_rid','6','','','4','1')
,('optiset_language_type','GREEK','greek','OLT_GREEK','GREEK','GREEK','','language_rid','12','','','19','1')
,('optiset_language_type','HEBREW','hebrew','OLT_HEBREW','HEBREW','HEBREW','','language_rid','9','','','21','1')
,('optiset_language_type','HUNGARIAN','hungarian','OLT_HUNGARIAN','HUNGARIAN','HUNGARIAN','','language_rid','2','','','15','1')
,('optiset_language_type','INVALID','invalid','OLT_INVALID','INVALID','INVALID','','language_rid','2','','','0','1')
,('optiset_language_type','ITALIAN','italian','OLT_ITALIAN','ITALIAN','ITALIAN','','language_rid','7','','','5','1')
,('optiset_language_type','JAPANESE','japanese','OLT_JAPANESE','JAPANESE','JAPANESE','','language_rid','2','','','10','1')
,('optiset_language_type','NORWEGIAN','norwegian','OLT_NORWEGIAN','NORWEGIAN','NORWEGIAN','','language_rid','2','','','11','1')
,('optiset_language_type','POLISH','polish','OLT_POLISH','POLISH','POLISH','','language_rid','13','','','14','1')
,('optiset_language_type','PORTUGUESE','portuguese','OLT_PORTUGUESE','PORTUGUESE','PORTUGUESE','','language_rid','2','','','8','1')
,('optiset_language_type','ROMANIAN','romanian','OLT_ROMANIAN','ROMANIAN','ROMANIAN','','language_rid','2','','','16','1')
,('optiset_language_type','RUSSIAN','russian','OLT_RUSSIAN','RUSSIAN','RUSSIAN','','language_rid','11','','','9','1')
,('optiset_language_type','SPANISH','spanish','OLT_SPANISH','SPANISH','SPANISH','','language_rid','8','','','2','1')
,('optiset_language_type','SWEDISH','swedish','OLT_SWEDISH','SWEDISH','SWEDISH','','language_rid','2','','','12','1')
,('optiset_language_type','TURKISH','turkish','OLT_TURKISH','TURKISH','TURKISH','','language_rid','2','','','20','1')
,('telematics_mode_type','IBOX_MODE','iboxMode','TMT_IBOX_MODE','IBox Mode','IBox Mode','','','','','','4','1')
,('telematics_mode_type','IBOX_MODE_QUALCOMM_NORTH_AMERICA','iboxModeQualcommNorthAmerica','TMT_IBOX_MODE_QUALCOMM_NORTH_AMERICA','IBox Mode - Qualcomm (North America)','IBox Mode - Qualcomm (North America)','','','','','','5','1')
,('telematics_mode_type','N_A','nA','TMT_N_A','N/A','N/A','','','','','','1','1')
,('telematics_mode_type','QUIET_MODE','quietMode','TMT_QUIET_MODE','Quiet Mode','Quiet Mode','','','','','','2','1')
,('telematics_mode_type','TRACKING_IBOX','trackingIbox','TMT_TRACKING_IBOX','Tracking+Ibox','Tracking+Ibox','','','','','','6','1')
,('telematics_mode_type','TRACKING_MODE','trackingMode','TMT_TRACKING_MODE','Tracking Mode','Tracking Mode','','','','','','3','1')


-- tk2_Accounts -- TODO add remaining tables
--,('customer_internal_view','Customer Internal View','Customer Internal View','CIV','tk2_Accounts','dbo','customer_internal_view')

--,('billing_option_type','Billing Option Type','Billing Option Type','BOT','tk2_Accounts','dbo','billing_option_type')

--,('fuel_type','Fuel Type','Fuel Type','FLT','tk2_Accounts','dbo','fuel_type')

,('billing_option_type','DEALER_TO_CUSTOMER','dealerToCustomer','BOT_DEALER_TO_CUSTOMER','Dealer to Customer','Dealer to Customer','','','','','','1','1')
,('billing_option_type','DEMO','demo','BOT_DEMO','Demo','Demo','','','','','','2','1')
,('billing_option_type','TK_CORP_TO_CUSTOMER','tKCorpToCustomer','BOT_TK_CORP_TO_CUSTOMER','TK Corp to Customer','TK Corp to Customer','','','','','','3','1')

,('fuel_type','LITRES',         'litres',           'FLT_LITRES',           'Litres','Litres','','','','','','1','1')
,('fuel_type','IMPERIAL_GALLONS','imperialGallons','FLT_IMPERIAL_GALLONS',  'Imperial Gallons','Imperial Gallons','','','','','','2','1')
,('fuel_type','US_GALLONS',        'usGallons',     'FLT_US_GALLONS',       'U.S. Gallons','U.S. Gallons','','','','','','3','1')


) AS source (lookup_list_code,code_without_prefix_all_caps,code_without_prefix_camel_case,code_with_prefix,short_desc,long_desc,notes,custom_col1_desc,custom_col1,custom_col2_desc,custom_col2,former_code,is_active)

ON target.code_with_prefix = source.code_with_prefix

WHEN MATCHED AND (   
        target.lookup_list_code <> source.lookup_list_code
     OR target.code_without_prefix_all_caps <> source.code_without_prefix_all_caps
     OR target.code_without_prefix_camel_case <> source.code_without_prefix_camel_case
     OR target.code_with_prefix <> source.code_with_prefix
     OR target.short_desc <> source.short_desc
     OR target.long_desc <> source.long_desc
     OR target.notes <> source.notes
     OR target.custom_col1_desc <> source.custom_col1_desc
     OR target.custom_col1 <> source.custom_col1
     OR target.custom_col2_desc <> source.custom_col2_desc
     OR target.custom_col2 <> source.custom_col2
     OR target.former_code <> source.former_code
     OR target.is_active <> source.is_active
    ) THEN
    UPDATE SET
        target.lookup_list_code = source.lookup_list_code,
        target.code_without_prefix_all_caps = source.code_without_prefix_all_caps,
        target.code_without_prefix_camel_case = source.code_without_prefix_camel_case,
        target.code_with_prefix = source.code_with_prefix,
        target.short_desc = source.short_desc,
        target.long_desc = source.long_desc,
        target.notes = source.notes,
        target.custom_col1_desc = source.custom_col1_desc,
        target.custom_col1 = source.custom_col1,
        target.custom_col2_desc = source.custom_col2_desc,
        target.custom_col2 = source.custom_col2,
        target.former_code = source.former_code,
        target.is_active = source.is_active

WHEN NOT MATCHED BY TARGET THEN
    INSERT (lookup_list_code,code_without_prefix_all_caps,code_without_prefix_camel_case,code_with_prefix,short_desc,long_desc,notes,custom_col1_desc,custom_col1,custom_col2_desc,custom_col2,former_code,is_active)
    VALUES (source.lookup_list_code,source.code_without_prefix_all_caps,source.code_without_prefix_camel_case,source.code_with_prefix,source.short_desc,source.long_desc,source.notes,source.custom_col1_desc,source.custom_col1,source.custom_col2_desc,source.custom_col2,source.former_code,source.is_active)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE
;
