CREATE TABLE [dbo].[schema_versioning] (
    [version_rid]  INT            IDENTITY (1, 1) NOT NULL,
    [type]         NVARCHAR (50)  NOT NULL,
    [description]  NVARCHAR (200) NULL,
    [installed_by] NVARCHAR (100) DEFAULT (user_name()) NOT NULL,
    [installed_on] DATETIME       DEFAULT (getdate()) NOT NULL,
    [file_name]    NVARCHAR (200) NULL,
    [success]      BIT            NOT NULL
);
GO

ALTER TABLE [dbo].[schema_versioning]
    ADD CONSTRAINT [schema_versioning_pk] PRIMARY KEY CLUSTERED ([version_rid] ASC);
GO

