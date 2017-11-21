------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- vwBuild_ConaData View Creation Script				------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwBuild_SKUData'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwBuild_SKUData]'

SET @sqlScript = 
'CREATE VIEW [' + @schema + '].[vwBuild_SKUData] AS SELECT
	[base].[Customer]
	,[base].[SKU]
	,[cmv].[ModelID]
	,[estimate]
	,[pvalue]
	,[Units]
	,[RecordCount]
 FROM (	SELECT
			[customer]
			,[SKU]
			,SUM([Volume]) AS [Units]
			,Count(*) AS [RecordCount]
		FROM [' + @schema + '].[salesData]
		GROUP BY [customer]
			,[SKU]) AS [base]
LEFT JOIN [' + @schema + '].[vwUniqCustomerModels] AS [cmv]
	ON [base].[customer] = [cmv].[customer]
LEFT JOIN [' + @schema + '].[modeloutput] AS [mo]
	ON [cmv].[modelid] = [mo].[modelid]
	AND [base].[SKU] = REPLACE([mo].[variable], ''`'', '''')'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
