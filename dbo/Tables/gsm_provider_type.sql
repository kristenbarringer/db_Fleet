CREATE TABLE [dbo].[gsm_provider_type] (
    [rid]         INT           NOT NULL,
    [description] NVARCHAR (50) NOT NULL,
    [created]     DATETIME      NOT NULL
);
GO

ALTER TABLE [dbo].[gsm_provider_type]
    ADD CONSTRAINT [idx_gsm_provider_typePK] PRIMARY KEY CLUSTERED ([rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[gsm_provider_type]
    ADD CONSTRAINT [DF_gsm_provider_type_created] DEFAULT (getdate()) FOR [created];
GO

