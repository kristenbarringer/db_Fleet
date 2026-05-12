CREATE TABLE [dbo].[yms_command_detail] (
    [rid]              INT           IDENTITY (1, 1) NOT NULL,
    [batch_command_id] VARCHAR (255) NOT NULL,
    [commandId]        VARCHAR (255) NOT NULL,
    [action]           VARCHAR (255) NOT NULL,
    [parameter]        VARCHAR (255) NULL,
    [status]           VARCHAR (255) NULL,
    [created]          DATETIME      DEFAULT (getdate()) NOT NULL,
    [updated]          DATETIME      DEFAULT (getdate()) NULL,
    [message]          VARCHAR (255) NULL
);
GO

ALTER TABLE [dbo].[yms_command_detail]
    ADD CONSTRAINT [idx_ymscmd] PRIMARY KEY CLUSTERED ([batch_command_id] ASC, [commandId] ASC);
GO

