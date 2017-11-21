------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- top90SKUs Table Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''top90SKUs'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[top90SKUs]'

SET @sqlScript = 
'CREATE TABLE [' + @schema + '].[top90SKUs] (
	[SKU] [nvarchar](10) NULL
	,[SalesVol] [float] NULL
	,[PctVol] [float] NULL
	,[CumPctVol] [float] NULL
)'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
