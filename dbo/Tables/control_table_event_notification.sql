CREATE TABLE [dbo].[control_table_event_notification] (
    [SourceSchema]      NVARCHAR (50)  NULL,
    [SourceTable]       NVARCHAR (150) NULL,
    [destinationSchema] NVARCHAR (150) NULL,
    [destinationTable]  NVARCHAR (150) NULL,
    [jsonmapping]       NVARCHAR (MAX) NULL,
    [Hooksscript]       NVARCHAR (MAX) NULL
);
GO

