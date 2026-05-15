/*
drop table if exists [dbo].[test_referring_tbl];
drop table if exists [dbo].[lookup_code];
drop table if exists [dbo].[lookup_code_list];

select * from [dbo].[test_referring_tbl];
select * from [dbo].[lookup_code];
select * from [dbo].[lookup_code_list];
*/
CREATE TABLE [dbo].[lookup_code_list] (
    [Id]        UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    [lookup_type_code]  VARCHAR (50)     NOT NULL,
    [short_desc]   NVARCHAR (50)    NOT NULL,
    [long_desc]    NVARCHAR (50)    NOT    NULL,
    [notes]        NVARCHAR (MAX)   NULL,
    [custom_col1]  NVARCHAR (MAX)   NULL,
    [former_table_db]    NVARCHAR (50)    NULL,
    [former_table_schema]    NVARCHAR (50)    NULL,
    [former_table_name]    NVARCHAR (50)  ,
    [created_date] DATETIME         NOT NULL,
    [created_by]   VARCHAR (50)     NOT NULL,
    [updated_date] DATETIME         NULL,
    [updated_by]   VARCHAR (50)     NULL
);
GO

ALTER TABLE [dbo].[lookup_code_list]
    ADD CONSTRAINT [DEFAULT_lookup_code_list_new_created_by] DEFAULT (suser_sname()) FOR [created_by];
GO

ALTER TABLE [dbo].[lookup_code_list]
    ADD CONSTRAINT [DEFAULT_lookup_code_list_new_updated_by] DEFAULT (suser_sname()) FOR [updated_by];
GO

ALTER TABLE [dbo].[lookup_code_list]
    ADD CONSTRAINT [DEFAULT_lookup_code_list_new_updated_date] DEFAULT (getutcdate()) FOR [updated_date];
GO

ALTER TABLE [dbo].[lookup_code_list]
    ADD CONSTRAINT [DEFAULT_lookup_code_list_new_created_date] DEFAULT (getutcdate()) FOR [created_date];
GO

ALTER TABLE [dbo].[lookup_code_list]
    ADD CONSTRAINT [PK_lookup_code_list_new] PRIMARY KEY CLUSTERED (lookup_type_code ASC);
GO

