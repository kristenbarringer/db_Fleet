CREATE TABLE [dbo].[controller_model_type] (
    [controller_model_type_rid] INT           IDENTITY (1, 1) NOT NULL,
    [description]               NVARCHAR (50) NOT NULL,
    [created]                   DATETIME      NULL
);
GO

ALTER TABLE [dbo].[controller_model_type]
    ADD CONSTRAINT [controller_model_type_ridPK] PRIMARY KEY CLUSTERED ([controller_model_type_rid] ASC);
GO

