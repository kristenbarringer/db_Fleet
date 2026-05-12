CREATE TABLE [dbo].[controller_type_model_type_mapping] (
    [platform_id]                            INT           NULL,
    [controller_type]                        NVARCHAR (50) NULL,
    [protocol_description]                   NVARCHAR (50) NULL,
    [controller_model_type]                  NVARCHAR (70) NULL,
    [controller_type_rid]                    INT           NULL,
    [controller_model_type_rid]              INT           NULL,
    [protocol_rid]                           TINYINT       NULL,
    [controller_type_model_type_mapping_rid] INT           IDENTITY (1, 1) NOT NULL
);
GO

ALTER TABLE [dbo].[controller_type_model_type_mapping]
    ADD CONSTRAINT [fk_controller_type_model_type_mapping_controller_model_type] FOREIGN KEY ([controller_model_type_rid]) REFERENCES [dbo].[controller_model_type] ([controller_model_type_rid]);
GO

ALTER TABLE [dbo].[controller_type_model_type_mapping]
    ADD CONSTRAINT [fk_controller_type_model_type_mapping_controller_type] FOREIGN KEY ([controller_type_rid]) REFERENCES [dbo].[controller_type] ([controller_type_rid]);
GO

