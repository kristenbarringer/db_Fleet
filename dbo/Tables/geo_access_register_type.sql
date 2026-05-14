CREATE TABLE [dbo].[geo_access_register_type] (
    [geo_access_register_type_rid] INT           NOT NULL,
    [description]                  NVARCHAR (50) NULL
);
GO

ALTER TABLE [dbo].[geo_access_register_type]
    ADD CONSTRAINT [PK_geo_access_register_type] PRIMARY KEY CLUSTERED ([geo_access_register_type_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

