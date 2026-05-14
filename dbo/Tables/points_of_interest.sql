CREATE TABLE [dbo].[points_of_interest] (
    [poi_rid]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [description] NVARCHAR (255) NULL,
    [latitude]    FLOAT (53)     NOT NULL,
    [longitude]   FLOAT (53)     NOT NULL,
    [icon_id]     INT            NOT NULL,
    [tenant_id]   NVARCHAR (50)  NOT NULL,
    [created_at]  DATETIME       NULL,
    [updated_at]  DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([poi_rid] ASC)
);
GO

