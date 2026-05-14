CREATE TABLE [dbo].[asset_activation_status] (
    [rid]                INT           IDENTITY (1, 1) NOT NULL,
    [status_description] VARCHAR (100) NULL,
    [active]             BIT           NULL,
    [created]            DATETIME      DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([rid] ASC)
);
GO

