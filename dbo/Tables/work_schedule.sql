CREATE TABLE [dbo].[work_schedule] (
    [work_schedule_rid] INT            IDENTITY (100, 1) NOT NULL,
    [tenant_id]         INT            NULL,
    [description]       NVARCHAR (100) NULL,
    [created]           DATETIME       NULL,
    [timezone_rid]      INT            NULL
);
GO

ALTER TABLE [dbo].[work_schedule]
    ADD CONSTRAINT [idx_work_schedulePK] PRIMARY KEY CLUSTERED ([work_schedule_rid] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

