------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- SKUData View Creation Script							------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''SKUData'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[SKUData]'

SET @sqlScript = 
'CREATE TABLE [' + @schema + '].[SKUData]
(
	[Customer] [nvarchar](50) NULL,
	[SKU] [nvarchar](25) NULL,
	[ModelID] [nvarchar](255) NULL,
	[estimate] [float] NULL,
	[pValue] [float] NULL,
	[Units] [float] NULL,
	[RecordCount] [int] NULL
)'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
