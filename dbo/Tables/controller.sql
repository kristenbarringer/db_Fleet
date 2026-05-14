CREATE TABLE [dbo].[controller] (
    [controller_rid]              INT           IDENTITY (1, 1) NOT NULL,
    [controller_name]             NVARCHAR (50) NOT NULL,
    [controller_type_rid]         INT           NOT NULL,
    [created]                     DATETIME      NOT NULL,
    [tenant_id]                   NVARCHAR (50) NOT NULL,
    [equipment_rid]               INT           NOT NULL,
    [controller_serial_number]    NVARCHAR (50) NULL,
    [controller_software_version] NVARCHAR (50) NULL,
    [updated]                     DATETIME      NULL,
    [auto_update_sent]            BIT           NULL
);
GO

ALTER TABLE [dbo].[controller]
    ADD CONSTRAINT [DF_controller_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[controller]
    ADD CONSTRAINT [DF_equipment_v1migration] DEFAULT ((1)) FOR [equipment_rid];
GO

ALTER TABLE [dbo].[controller]
    ADD CONSTRAINT [DF_controller_type_v1migration] DEFAULT ((1)) FOR [controller_type_rid];
GO

ALTER TABLE [dbo].[controller]
    ADD CONSTRAINT [FK_controller_equipment] FOREIGN KEY ([equipment_rid]) REFERENCES [dbo].[equipment] ([equipment_rid]);
GO

ALTER TABLE [dbo].[controller]
    ADD CONSTRAINT [FK_controller_controller_type] FOREIGN KEY ([controller_type_rid]) REFERENCES [dbo].[controller_type] ([controller_type_rid]);
GO

ALTER TABLE [dbo].[controller]
    ADD CONSTRAINT [idx_controllerPK] PRIMARY KEY CLUSTERED ([controller_rid] ASC) WITH (FILLFACTOR = 100);
GO

