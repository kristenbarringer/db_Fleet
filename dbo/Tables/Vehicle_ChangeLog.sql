CREATE TABLE [dbo].[Vehicle_ChangeLog] (
    [ChangeLogId]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [Vehicle_rid]    INT            NULL,
    [ChangeType]     VARCHAR (10)   NULL,
    [ChangedColumns] NVARCHAR (MAX) NULL,
    [OldData]        NVARCHAR (MAX) NULL,
    [NewData]        NVARCHAR (MAX) NULL,
    [DetectedAt]     DATETIME2 (7)  DEFAULT (sysdatetime()) NULL,
    [Exported]       BIT            DEFAULT ((0)) NULL,
    [Processed]      BIT            DEFAULT ((0)) NOT NULL,
    [ProcessedAt]    DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([ChangeLogId] ASC)
);
GO

