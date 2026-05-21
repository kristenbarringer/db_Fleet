CREATE TABLE [dbo].[controller_type_model_type_mapping]
(
    [platform_id] INT NULL,
    [controller_type] NVARCHAR (50) NULL,
    [protocol_description] NVARCHAR (50) NULL,
    [controller_model_type] NVARCHAR (70) NULL,
    [controller_type_code] VARCHAR(30) NULL,
    [controller_model_type_code] VARCHAR(30) NULL,
    [protocol_code] VARCHAR(30) NULL,
    [controller_type_model_type_mapping_rid] INT IDENTITY (1, 1) NOT NULL
);
GO

ALTER TABLE [dbo].[controller_type_model_type_mapping]
    ADD CONSTRAINT [fk_controller_type_model_type_mapping_controller_model_type] FOREIGN KEY ([controller_model_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[controller_type_model_type_mapping]
    ADD CONSTRAINT [fk_controller_type_model_type_mapping_controller_type] FOREIGN KEY ([controller_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

