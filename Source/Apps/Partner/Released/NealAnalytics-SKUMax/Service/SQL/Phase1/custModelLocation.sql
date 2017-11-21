------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- custModelLocation View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''custModelLocation'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[custModelLocation]'

SET @sqlScript = 
'CREATE TABLE [' + @schema + '].[custModelLocation] (
	[Customer] [nvarchar](255) NULL
	,[Latitude] [float] NULL
	,[Longitude] [float] NULL
	,[ZipCode] [int] NULL
	,[ModelID] [nvarchar](255) NULL
	,[Variable2] [nvarchar](255) NULL
	,[Variable1] [nvarchar](255) NULL
	,[Variable3] [nvarchar](255) NULL
	,[Unique SKUs] [int] NULL
	,[Total Sales Volume] [float] NULL
	,[Total Sales Revenue] [float] NULL
	,[Avg Sales Revenue] [float] NULL
	,[Number of Sales Periods] [int] NULL
)'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
