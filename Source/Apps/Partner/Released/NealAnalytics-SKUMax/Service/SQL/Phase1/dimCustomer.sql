------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- dimCustomer Table Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''dimCustomer'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[dimCustomer]'

SET @sqlScript = 
'CREATE TABLE [' + @schema + '].[dimCustomer](
	[Customer] [nvarchar](255) NULL
	,[CustomerName] [nvarchar](255) NULL
	,[Variable1] [nvarchar](255) NULL
	,[Variable2] [nvarchar](255) NULL
	,[Variable3] [nvarchar](255) NULL
	,[Latitude] [float] NULL
	,[Longitude] [float] NULL
	,[ZipCode] [int] NULL
)'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
