CREATE TABLE [dbo].[artifact_audit] (
    [artificat_audit_rid]        INT            IDENTITY (1, 1) NOT NULL,
    [artifact_id]                NVARCHAR (100) NULL,
    [status]                     INT            NULL,
    [device_model_type_rid]      INT            NULL,
    [controller_model_type_rids] NVARCHAR (MAX) NULL,
    [user_rid]                   INT            NULL,
    [created]                    DATETIME       NULL,
    [tenant_id]                  VARCHAR (50)   NULL
);
GO

ALTER TABLE [dbo].[artifact_audit]
    ADD CONSTRAINT [idx_artifact_auditPK] PRIMARY KEY CLUSTERED ([artificat_audit_rid] ASC) WITH (FILLFACTOR = 100);
GO

