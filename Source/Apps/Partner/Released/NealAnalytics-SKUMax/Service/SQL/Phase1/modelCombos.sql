------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- modelCombos Table Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''modelCombos'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[modelCombos]'

SET @sqlScript = 
'CREATE TABLE [' + @schema + '].[modelCombos] (
    [ModelID] [varchar](255) NOT NULL
	,[RunModel] [int] NOT NULL
    ,[Combo] [varchar](255) NULL  
    ,[dateCreated] [datetime] NOT NULL
)'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
