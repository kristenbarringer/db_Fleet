CREATE TABLE [dbo].[geo_fence] (
    [geo_fence_rid]     INT             IDENTITY (1, 1) NOT NULL,
    [description]       NVARCHAR (60)   NULL,
    [tenant_id]         INT             NULL,
    [co_ord_1_x]        DECIMAL (9, 6)  NULL,
    [co_ord_1_y]        DECIMAL (9, 6)  NULL,
    [co_ord_2_x]        DECIMAL (9, 6)  NULL,
    [co_ord_2_y]        DECIMAL (9, 6)  NULL,
    [co_ord_3_x]        DECIMAL (9, 6)  NULL,
    [co_ord_3_y]        DECIMAL (9, 6)  NULL,
    [co_ord_4_x]        DECIMAL (9, 6)  NULL,
    [co_ord_4_y]        DECIMAL (9, 6)  NULL,
    [created]           DATETIME        NULL,
    [colour_rid]        INT             NULL,
    [active_flag]       BIT             NULL,
    [boundary_long_1]   DECIMAL (11, 8) NULL,
    [boundary_lat_1]    DECIMAL (11, 8) NULL,
    [boundary_long_2]   DECIMAL (11, 8) NULL,
    [boundary_lat_2]    DECIMAL (11, 8) NULL,
    [noise_reduction]   BIT             NULL,
    [work_schedule_rid] INT             NULL,
    [total_points]      INT             NULL,
    [radius]            DECIMAL (9, 6)  NULL,
    [co_ordinates]      VARCHAR (MAX)   NULL,
    [is_created]        BIT             NULL,
    [is_updated]        BIT             NULL
);
GO

ALTER TABLE [dbo].[geo_fence]
    ADD CONSTRAINT [DF_geo_fence_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[geo_fence]
    ADD CONSTRAINT [DF_geo_fence_isupdated] DEFAULT ((0)) FOR [is_updated];
GO

ALTER TABLE [dbo].[geo_fence]
    ADD CONSTRAINT [DF_geo_fence_iscreated] DEFAULT ((0)) FOR [is_created];
GO

ALTER TABLE [dbo].[geo_fence]
    ADD CONSTRAINT [DF_geo_fence_noise_reduction] DEFAULT ((0)) FOR [noise_reduction];
GO

ALTER TABLE [dbo].[geo_fence]
    ADD CONSTRAINT [DF_geo_fence_colour] DEFAULT ((1)) FOR [colour_rid];
GO

ALTER TABLE [dbo].[geo_fence]
    ADD CONSTRAINT [DF_geo_fence_active_flag] DEFAULT ((1)) FOR [active_flag];
GO

ALTER TABLE [dbo].[geo_fence]
    ADD CONSTRAINT [idx_geo_fencePK] PRIMARY KEY CLUSTERED ([geo_fence_rid] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);
GO

ALTER TABLE [dbo].[geo_fence]
    ADD CONSTRAINT [FK_geo_fence_colour] FOREIGN KEY ([colour_rid]) REFERENCES [dbo].[colour] ([colour_rid]);


GO
ALTER TABLE [dbo].[geo_fence] NOCHECK CONSTRAINT [FK_geo_fence_colour];
GO

ALTER TABLE [dbo].[geo_fence]
    ADD CONSTRAINT [FK_geo_fence_work_schedule] FOREIGN KEY ([work_schedule_rid]) REFERENCES [dbo].[work_schedule] ([work_schedule_rid]);


GO
ALTER TABLE [dbo].[geo_fence] NOCHECK CONSTRAINT [FK_geo_fence_work_schedule];
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_unique_geo_fence]
    ON [dbo].[geo_fence]([geo_fence_rid] ASC, [tenant_id] ASC);
GO

