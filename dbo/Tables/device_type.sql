CREATE TABLE [dbo].[device_type] (
    [device_type_rid] INT           IDENTITY (1, 1) NOT NULL,
    [name]            NVARCHAR (50) NOT NULL,
    [description]     NVARCHAR (50) NOT NULL,
    [created]         DATETIME      NOT NULL
);
GO

ALTER TABLE [dbo].[device_type]
    ADD CONSTRAINT [idx_device_typePK] PRIMARY KEY CLUSTERED ([device_type_rid] ASC);
GO

ALTER TABLE [dbo].[device_type]
    ADD CONSTRAINT [DF_device_type_created] DEFAULT (getdate()) FOR [created];
GO

