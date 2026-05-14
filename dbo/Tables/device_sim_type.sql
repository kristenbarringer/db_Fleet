CREATE TABLE [dbo].[device_sim_type] (
    [rid]         TINYINT      IDENTITY (1, 1) NOT NULL,
    [description] VARCHAR (50) NOT NULL,
    [created]     DATETIME     NULL
);
GO

ALTER TABLE [dbo].[device_sim_type]
    ADD CONSTRAINT [DF_device_sim_type_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[device_sim_type]
    ADD CONSTRAINT [idx_device_sim_typePK] PRIMARY KEY CLUSTERED ([rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

