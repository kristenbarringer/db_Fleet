CREATE TABLE [dbo].[bulk_activation_tracker] (
    [rid]           INT           IDENTITY (1, 1) NOT NULL,
    [total_count]   INT           NOT NULL,
    [tenant_id]     VARCHAR (50)  NOT NULL,
    [created_by]    INT           NOT NULL,
    [created_at]    DATETIME      NULL,
    [current_state] NVARCHAR (30) NOT NULL,
    [updated_at]    DATETIME      NULL
);
GO

ALTER TABLE [dbo].[bulk_activation_tracker]
    ADD CONSTRAINT [bulk_activation_tracker_pk] PRIMARY KEY CLUSTERED ([rid] ASC);
GO

