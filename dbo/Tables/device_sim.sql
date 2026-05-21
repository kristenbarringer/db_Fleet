CREATE TABLE [dbo].[device_sim]
(
    [device_rid] INT NOT NULL,
    [is_primary] BIT NOT NULL,
    [is_embedded] BIT NOT NULL,
    [carrier_code] VARCHAR(30) NULL,
    -- TODO add values to lookup_code for carrier_code = AT&T, 3IRE, CORE (table did not exist before)
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
    ADD CONSTRAINT [DF_device_sim_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[device_sim]
    ADD CONSTRAINT [DF_device_sim_active] DEFAULT ((0)) FOR [active];
GO

ALTER TABLE [dbo].[device_sim]
    ADD CONSTRAINT [DF_device_sim_is_primary] DEFAULT ((1)) FOR [is_primary];
GO

ALTER TABLE [dbo].[device_sim]
    ADD CONSTRAINT [DF_device_sim_is_embedded] DEFAULT ((1)) FOR [is_embedded];
GO

ALTER TABLE [dbo].[device_sim]
    ADD CONSTRAINT [idx_device_simPK] PRIMARY KEY CLUSTERED ([device_rid] ASC, [tenant_id] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

