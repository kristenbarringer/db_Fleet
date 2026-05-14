CREATE TABLE [dbo].[mq_parameter] (
    [mq_parameter_rid] INT           NOT NULL,
    [description]      NVARCHAR (50) NOT NULL,
    [created]          DATETIME      NOT NULL
);
GO

ALTER TABLE [dbo].[mq_parameter]
    ADD CONSTRAINT [idx_mq_parameterPK] PRIMARY KEY CLUSTERED ([mq_parameter_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[mq_parameter]
    ADD CONSTRAINT [DF_mq_parameter_created] DEFAULT (getdate()) FOR [created];
GO

