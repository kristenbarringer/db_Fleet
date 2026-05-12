CREATE TABLE [dbo].[User_group_mapping_changeLog] (
    [ChangeLogId]        BIGINT         IDENTITY (1, 1) NOT NULL,
    [change_type]        NVARCHAR (20)  NOT NULL,
    [user_rid]           INT            NOT NULL,
    [user_name]          NVARCHAR (100) NOT NULL,
    [vehicle_group_rid]  INT            NOT NULL,
    [vehicle_group_name] NVARCHAR (100) NOT NULL,
    [Customer_rid]       INT            NOT NULL,
    [created]            DATETIME       NULL,
    [Processed]          BIT            NOT NULL,
    [ProcessedAt]        DATETIME2 (7)  NULL
);
GO

ALTER TABLE [dbo].[User_group_mapping_changeLog]
    ADD CONSTRAINT [DF_User_group_mapping_changeLog_Processed] DEFAULT ((0)) FOR [Processed];
GO

