------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- modelMeta Table Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''modelMeta'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[modelMeta]'

SET @sqlScript = 
'CREATE TABLE [' + @schema + '].[modelMeta] (
    [ModelID] [varchar](255) NOT NULL
    ,[ModelBuilt] [float] NULL
    ,[NumbofObs] [float] NULL
	,[TotalSKUs] [float] NULL
	,[NumbSKUs] [float] NULL
	,[NumbCust] [float] NULL
    ,[dateCreated] [datetime] NOT NULL
	,[ModelRunName] [varchar](255) NULL
)'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
