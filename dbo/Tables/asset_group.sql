CREATE TABLE [dbo].[asset_group] (
    [asset_group_rid]      INT           IDENTITY (1, 1) NOT NULL,
    [asset_group_name]     NVARCHAR (50) NOT NULL,
    [tenant_id]            NVARCHAR (50) NOT NULL,
    [created]              DATETIME      NOT NULL,
    [updated]              DATETIME      NULL,
    [v1_vehicle_group_rid] INT           NULL
);
GO

ALTER TABLE [dbo].[asset_group]
    ADD CONSTRAINT [idx_asset_groupPK] PRIMARY KEY CLUSTERED ([asset_group_rid] ASC);
GO

ALTER TABLE [dbo].[asset_group]
    ADD CONSTRAINT [DF_asset_group_created] DEFAULT (getdate()) FOR [created];
GO

CREATE NONCLUSTERED INDEX [IX_asset_group_tenant_id]
    ON [dbo].[asset_group]([tenant_id] ASC);
GO

