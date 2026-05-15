/*print 'TODO - exclude from build';

select * from [dbo].[lookup_code_list] where lookup_type_code = 'controller_model_type';
select * from [dbo].[lookup_code] where lookup_type = 'controller_model_type';
select * from controller 


select * from [dbo].[test_referring_tbl] ;
select * from [dbo].[lookup_code] where lookup_type not in (select lookup_type_code from lookup_code_list);
select * from [dbo].[lookup_code_list];
select * from billing_service_level
select * from controller_model_type

-- test that foreign keys are working
insert into dbo.lookup_code ([lookup_type],[code],[short_desc],[long_desc],[notes],[custom_col1] )
values ('test_type4', 'TEST04444', 'Van', 'CommercialKLB_20260514_1759', '', '');

update dbo.lookup_code set lookup_type = '89';

insert into dbo.test_referring_tbl (ID, test_type1_code, test_type2_code, test_type3_code, notes )
values ('4', 'TEST01dggg', 'TEST02dgggg', 'TEST03dgggg', '');

update dbo.test_referring_tbl set test_type1_code = '89';

select * from lookup_code lc
inner join lookup_code_list ll on lc.lookup_list_code = ll.lookup_list_code 
where lc.lookup_list_code like '%lang%' and short_desc like '%English%'

*/