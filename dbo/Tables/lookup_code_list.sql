CREATE TABLE [dbo].[lookup_code] (
    [Id]        UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    [lookup_type]  VARCHAR (50)     NOT NULL,
    [code]         VARCHAR (50)     NOT NULL,
    [short_desc]   NVARCHAR (50)    NOT NULL,
    [long_desc]    NVARCHAR (50)    NOT NULL,
    [notes]        NVARCHAR (MAX)   NULL,
    [custom_col1]  NVARCHAR (MAX)   NULL,
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
    ADD CONSTRAINT [PK_lookup_code] PRIMARY KEY CLUSTERED ([Id] ASC);
GO

