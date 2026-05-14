CREATE TABLE [dbo].[user_recent_search] (
    [search_rid]   INT            IDENTITY (1, 1) NOT NULL,
    [user_rid]     INT            NOT NULL,
    [query_string] NVARCHAR (MAX) NOT NULL,
    [query_hash]   NVARCHAR (MAX) NOT NULL,
    [created]      DATETIME       NOT NULL,
    [updated]      DATETIME       NULL,
    [tenant_id]    NVARCHAR (50)  NULL,
    [search_name]  NVARCHAR (50)  NULL
);
GO

ALTER TABLE [dbo].[user_recent_search]
    ADD CONSTRAINT [DF_user_recent_search_created] DEFAULT (getdate()) FOR [created];
GO

ALTER TABLE [dbo].[user_recent_search]
    ADD CONSTRAINT [idx_user_recent_searchPK] PRIMARY KEY CLUSTERED ([search_rid] ASC);
GO

