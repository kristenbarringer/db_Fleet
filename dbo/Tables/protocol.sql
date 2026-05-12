CREATE TABLE [dbo].[protocol] (
    [protocol_rid] TINYINT       NOT NULL,
    [description]  NVARCHAR (50) NOT NULL
);
GO

ALTER TABLE [dbo].[protocol]
    ADD CONSTRAINT [protocolPK] PRIMARY KEY CLUSTERED ([protocol_rid] ASC);
GO

