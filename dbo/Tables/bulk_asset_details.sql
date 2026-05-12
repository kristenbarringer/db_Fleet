CREATE TABLE [dbo].[bulk_asset_details] (
    [rid]                  INT           IDENTITY (1, 1) NOT NULL,
    [device_serial_number] VARCHAR (100) NOT NULL,
    [tenant_id]            VARCHAR (50)  NOT NULL,
    [status]               VARCHAR (50)  NOT NULL,
    [tracker_rid]          INT           NOT NULL,
    [created_at]           DATETIME      NULL,
    [updated_at]           DATETIME      NULL
);
GO

ALTER TABLE [dbo].[bulk_asset_details]
    ADD CONSTRAINT [bulk_asset_details_bulk_activation_tracker_FK] FOREIGN KEY ([tracker_rid]) REFERENCES [dbo].[bulk_activation_tracker] ([rid]);
GO

ALTER TABLE [dbo].[bulk_asset_details]
    ADD CONSTRAINT [bulk_asset_details_pk] PRIMARY KEY CLUSTERED ([rid] ASC);
GO

