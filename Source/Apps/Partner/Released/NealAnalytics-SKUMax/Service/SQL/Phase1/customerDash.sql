------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- customerDash Table Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''customerDash'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[customerDash]'

SET @sqlScript = 
'CREATE TABLE [' + @schema + '].[customerDash] (
	[Customer] [nvarchar](9) NULL
	,[ModelID] [nvarchar](10) NULL
	,[Latitude] [float] NULL
	,[Longitude] [float] NULL
	,[ZipCode] [nvarchar](5) NULL
	,[Product] [nvarchar](255) NULL
	,[pValue] [float] NULL
	,[Sales Effect] [float] NULL
	,[MissingIndicator] [int] NULL
	,[AboveAvgSE] [int] NULL
	,[TopVolSKU] [int] NULL
)'   

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
