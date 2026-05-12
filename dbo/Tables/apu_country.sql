CREATE TABLE [dbo].[apu_country] (
    [country_id]   INT            IDENTITY (1, 1) NOT NULL,
    [country_name] NVARCHAR (100) NOT NULL
);
GO

ALTER TABLE [dbo].[apu_country]
    ADD CONSTRAINT [idx_tkapucountryPK] PRIMARY KEY CLUSTERED ([country_id] ASC);
GO

