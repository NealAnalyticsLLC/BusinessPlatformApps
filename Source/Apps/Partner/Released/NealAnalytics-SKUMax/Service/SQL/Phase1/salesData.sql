------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- salesData Table Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''salesData'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[salesData]'

SET @sqlScript = 
'CREATE TABLE [' + @schema + '].[salesData]
(
	[Week] [nvarchar](25) NULL,
	[Customer] [nvarchar](50) NULL,
	[SKU] [nvarchar](25) NULL,
	[Revenue] [float] NULL,	
	[Volume] [float] NULL
)'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
