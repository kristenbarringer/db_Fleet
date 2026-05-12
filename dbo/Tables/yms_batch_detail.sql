CREATE TABLE [dbo].[yms_batch_detail] (
    [rid]               INT           IDENTITY (1, 1) NOT NULL,
    [batch_command_id]  VARCHAR (255) NOT NULL,
    [batch_timestamp]   DATETIME      NULL,
    [batch_expiration]  DATETIME      NULL,
    [continue_on_error] BIT           NULL,
    [v1_asset_name]     VARCHAR (255) NOT NULL,
    [v1_user_id]        VARCHAR (255) NULL,
    [status]            INT           DEFAULT ((0)) NULL,
    [created]           DATETIME      DEFAULT (getdate()) NOT NULL,
    [updated]           DATETIME      DEFAULT (getdate()) NULL,
    [correlation_id]    VARCHAR (255) NULL,
    [event_id]          VARCHAR (255) NOT NULL
);
GO

ALTER TABLE [dbo].[yms_batch_detail]
    ADD CONSTRAINT [idx_ymsbatch] PRIMARY KEY CLUSTERED ([batch_command_id] ASC);
GO

ALTER TABLE [dbo].[yms_batch_detail]
    ADD CONSTRAINT [yms_batch_detail_unique_1] UNIQUE NONCLUSTERED ([event_id] ASC);
GO

