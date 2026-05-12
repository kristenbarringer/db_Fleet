CREATE TABLE [dbo].[equipment_type] (
    [equipment_type_rid] INT           IDENTITY (1, 1) NOT NULL,
    [name]               NVARCHAR (50) NOT NULL,
    [description]        NVARCHAR (50) NOT NULL,
    [created]            DATETIME      NOT NULL,
    [active]             BIT           DEFAULT ((0)) NOT NULL
);
GO

ALTER TABLE [dbo].[equipment_type]
    ADD CONSTRAINT [DF_equipment_type_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[equipment_type]
    ADD CONSTRAINT [idx_equipment_typePK] PRIMARY KEY CLUSTERED ([equipment_type_rid] ASC);
GO

