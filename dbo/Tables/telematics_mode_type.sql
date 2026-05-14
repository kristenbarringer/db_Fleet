CREATE TABLE [dbo].[telematics_mode_type] (
    [rid]         TINYINT       IDENTITY (1, 1) NOT NULL,
    [description] VARCHAR (200) NOT NULL,
    [created]     DATETIME      NOT NULL
);
GO

ALTER TABLE [dbo].[telematics_mode_type]
    ADD CONSTRAINT [idx_telematics_mode_typePK] PRIMARY KEY CLUSTERED ([rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[telematics_mode_type]
    ADD CONSTRAINT [DF_telematics_mode_type_created] DEFAULT (getdate()) FOR [created];
GO

