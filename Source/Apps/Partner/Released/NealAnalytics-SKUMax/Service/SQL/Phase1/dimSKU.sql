------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- dimSKU Table Creation Script							------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''dimSKU'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[dimSKU]'

SET @sqlScript = 
'CREATE TABLE [' + @schema + '].[dimSKU](
	[SKU] [nvarchar](10) NULL
	,[SKU_Name] [nvarchar](255) NULL
	,[Package_Size] [nvarchar](255) NULL
	,[Unit_Size] [nvarchar](255) NULL
	,[Pack_Type] [nvarchar](255) NULL
	,[Trade_Mark] [nvarchar](255) NULL
	,[Brand] [nvarchar](255) NULL
)'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
