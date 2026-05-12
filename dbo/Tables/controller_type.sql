CREATE TABLE [dbo].[controller_type] (
    [controller_type_rid] INT           IDENTITY (1, 1) NOT NULL,
    [name]                NVARCHAR (50) NOT NULL,
    [description]         NVARCHAR (50) NOT NULL,
    [created]             DATETIME      NOT NULL,
    [is_multi_temp]       BIT           DEFAULT ((0)) NULL
);
GO

ALTER TABLE [dbo].[controller_type]
    ADD CONSTRAINT [DF_controller_type_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[controller_type]
    ADD CONSTRAINT [idx_controller_typePK] PRIMARY KEY CLUSTERED ([controller_type_rid] ASC);
GO

