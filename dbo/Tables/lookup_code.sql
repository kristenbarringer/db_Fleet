/*
drop table if exists [dbo].[test_referring_tbl] ;
drop table if exists [dbo].[lookup_code];
*/
CREATE TABLE [dbo].[lookup_code] (
   -- [Id]        UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    code   NVARCHAR (50)    NOT NULL, -- code_with_prefix (PRIMARY KEY)
    lookup_list_code   VARCHAR (50)    NOT NULL,
    code_without_prefix_all_caps   NVARCHAR (50)    NOT NULL,
    code_without_prefix_camel_case   NVARCHAR (50)    NOT NULL,
    short_desc   NVARCHAR (50)    NOT NULL,
    long_desc   NVARCHAR (50)    NOT NULL,
    notes   NVARCHAR (50)    NOT NULL,
    custom_col1_desc   NVARCHAR (50)    NOT NULL,
    custom_col1   NVARCHAR (50)    NOT NULL,
    custom_col2_desc   NVARCHAR (50)    NOT NULL,
    custom_col2   NVARCHAR (50)    NOT NULL,
    former_code   NVARCHAR (50)    NOT NULL,
    is_active   NVARCHAR (50)    NOT NULL,
    [created_date] DATETIME         NOT NULL,
    [created_by]   VARCHAR (50)     NOT NULL,
    [updated_date] DATETIME         NULL,
    [updated_by]   VARCHAR (50)     NULL
);
GO

ALTER TABLE [dbo].[lookup_code]
    ADD CONSTRAINT [DEFAULT_lookup_code_created_by] DEFAULT (suser_sname()) FOR [created_by];
GO

ALTER TABLE [dbo].[lookup_code]
    ADD CONSTRAINT [DEFAULT_lookup_code_updated_by] DEFAULT (suser_sname()) FOR [updated_by];
GO

ALTER TABLE [dbo].[lookup_code]
    ADD CONSTRAINT [DEFAULT_lookup_code_updated_date] DEFAULT (getutcdate()) FOR [updated_date];
GO

ALTER TABLE [dbo].[lookup_code]
    ADD CONSTRAINT [DEFAULT_lookup_code_created_date] DEFAULT (getutcdate()) FOR [created_date];
GO

ALTER TABLE [dbo].[lookup_code]
    ADD CONSTRAINT [PK_lookup_code] PRIMARY KEY CLUSTERED (code ASC);
GO
ALTER TABLE lookup_code
ADD CONSTRAINT FK_lookup_code
    FOREIGN KEY (lookup_list_code)
    REFERENCES lookup_code_list(lookup_list_code);

