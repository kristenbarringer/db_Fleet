CREATE TABLE [dbo].[control_table_reefer] (
    [SourceSchema]      NVARCHAR (50)  NULL,
    [SourceTable]       NVARCHAR (50)  NULL,
    [destinationSchema] NVARCHAR (50)  NULL,
    [destinationTable]  NVARCHAR (50)  NULL,
    [jsonmapping]       NVARCHAR (MAX) NULL,
    [Hooksscript]       NVARCHAR (MAX) NULL,
    [minrid]            INT            NULL,
    [maxrid]            INT            NULL
);
GO

