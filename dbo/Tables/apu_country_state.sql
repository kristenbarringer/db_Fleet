CREATE TABLE [dbo].[apu_country_state] (
    [state_id]         INT            IDENTITY (1, 1) NOT NULL,
    [country_id]       INT            NOT NULL,
    [state_short_form] NVARCHAR (50)  NOT NULL,
    [state_full_form]  NVARCHAR (100) NOT NULL,
    [fuel_rate]        DECIMAL (5, 2) NULL,
    [updated_date]     DATETIME       NOT NULL,
    FOREIGN KEY ([country_id]) REFERENCES [dbo].[apu_country] ([country_id])
);
GO

ALTER TABLE [dbo].[apu_country_state]
    ADD CONSTRAINT [idx_tkapucountrystatePK] PRIMARY KEY CLUSTERED ([state_id] ASC);
GO

