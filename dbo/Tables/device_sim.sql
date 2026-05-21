CREATE TABLE [dbo].[device_sim]
(
    [device_rid] INT NOT NULL,
    [device_sim_type_code] VARCHAR(30) NOT NULL,
    [active] BIT NOT NULL,
    [tenant_id] NVARCHAR (200) NOT NULL,
    [mobile_number] NVARCHAR (70) NULL,
    [sim_number] NVARCHAR (50) NULL,
    [created] DATETIME NULL
);
GO

ALTER TABLE [dbo].[device_sim]
    ADD CONSTRAINT [FK_device_sim_device] FOREIGN KEY ([device_rid]) REFERENCES [dbo].[device] ([device_rid]) ON DELETE CASCADE ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[device_sim]
    ADD CONSTRAINT [fk_device_sim_device_sim_type_code] FOREIGN KEY ([device_sim_type_code]) REFERENCES [dbo].[lookup_code] ([code]);
GO

ALTER TABLE [dbo].[device_sim]
    ADD CONSTRAINT [DF_device_sim_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[device_sim]
    ADD CONSTRAINT [DF_device_sim_active] DEFAULT ((0)) FOR [active];
GO

ALTER TABLE [dbo].[device_sim]
    ADD CONSTRAINT [idx_device_simPK] PRIMARY KEY CLUSTERED ([device_rid] ASC, [device_sim_type_code] ASC, [tenant_id] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

