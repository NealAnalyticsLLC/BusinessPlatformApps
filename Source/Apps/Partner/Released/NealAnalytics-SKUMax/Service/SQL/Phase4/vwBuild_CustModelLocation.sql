------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- vwBuild_CustModelLocation View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwBuild_CustModelLocation'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwBuild_CustModelLocation]'

SET @sqlScript = 
'CREATE VIEW [' + @schema + '].[vwBuild_CustModelLocation] AS SELECT 
	[cm].[Customer]
	,[Latitude]
	,[Longitude]
	,[ZipCode]
	,[cm].[ModelID]
	,[Variable2]
	,[Variable1]
	,[Variable3]
	,COUNT(DISTINCT [SKU]) AS [Unique SKUs]
	,SUM([Volume]) AS [Total Sales Volume]
	,SUM(DISTINCT [Revenue]) AS [Total Sales Revenue]
	,AVG(DISTINCT [Revenue]) AS [Avg Sales Revenue]
	,COUNT(DISTINCT [week]) AS [Number of Sales Periods]
FROM [' + @schema + '].[dimCustomer] AS [cust]
INNER JOIN [' + @schema + '].[vwUniqCustomerModels] AS [cm]
	ON [cust].[Customer] = [cm].[Customer]
INNER JOIN [' + @schema + '].[salesData] AS [csd]
	ON [cm].[Customer] = [csd].[Customer]
GROUP BY [cm].[Customer]
	,[Latitude]
	,[Longitude]
	,[ZipCode]
	,[cm].[ModelID]
	,[Variable2]
	,[Variable1]
	,[Variable3]'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
