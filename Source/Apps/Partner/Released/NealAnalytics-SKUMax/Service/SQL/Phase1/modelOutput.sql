------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- modelOutput Table Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''modelOutput'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[modelOutput]'

SET @sqlScript = 
'CREATE TABLE [' + @schema + '].[modelOutput] (
    [ModelID] [varchar](255) NOT NULL 
    ,[Variable] [varchar](255) NOT NULL 
    ,[Estimate] [float] NULL 
    ,[StdError] [float] NULL 
    ,[tValue] [float] NULL 
    ,[pValue] [float] NULL 
    ,[dateCreated] [datetime] NOT NULL
)'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
