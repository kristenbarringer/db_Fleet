/*
drop table if exists [dbo].[test_referring_tbl] ;
*/
CREATE TABLE [dbo].[test_referring_tbl] (
    [Id]        VARCHAR (50)  NOT NULL  ,    
    [test_type1_code]         VARCHAR (50)     NOT NULL,
    [test_type2_code]         VARCHAR (50)     NOT NULL,
    [test_type3_code]         VARCHAR (50)     NOT NULL,
    [notes]        NVARCHAR (MAX)   NULL
);
GO
/* TODO FIX THIS
ALTER TABLE test_referring_tbl
ADD CONSTRAINT FK_test_referring_tbl_test_type1
    FOREIGN KEY (test_type1_code)
    REFERENCES lookup_code(code);

ALTER TABLE test_referring_tbl
ADD CONSTRAINT FK_test_referring_tbl_test_type2
    FOREIGN KEY (test_type2_code)
    REFERENCES lookup_code(code);

ALTER TABLE test_referring_tbl
ADD CONSTRAINT FK_test_referring_tbl_test_type3
    FOREIGN KEY (test_type3_code)
    REFERENCES lookup_code(code);
   
GO */
