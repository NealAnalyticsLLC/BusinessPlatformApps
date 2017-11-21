------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- vwSKUAnalysis View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwSKUAnalysis'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwSKUAnalysis]'

SET @sqlScript = 
'CREATE VIEW [' + @schema + '].[vwSKUAnalysis] AS SELECT 
	[MO].[ModelID]
	,RIGHT(LEFT([Variable],7),6) AS [SKU]
	,[Estimate]
	,[TotalSold]
	,[WeeksSold]
FROM [' + @schema + '].[modelOutput] AS [MO]
LEFT JOIN (	SELECT 
				[ModelID]
				,[SKU]
				,SUM([Volume]) AS [TotalSold]
				,COUNT(*) AS [WeeksSold]
			FROM [' + @schema + '].[salesData] AS [csd]
			LEFT JOIN [' + @schema + '].[vwUniqCustomerModels] AS [cmv]
				ON [csd].[Customer] = [cmv].[Customer]
			WHERE [modelid] is not null
			GROUP BY [ModelID]
				,[SKU]
			) [tbl2]
ON [MO].[ModelID] = [tbl2].[ModelID]
	AND RIGHT(LEFT([MO].[Variable],7),6) = [tbl2].[SKU]
WHERE [pvalue] < 0.010000
	AND [Variable] <> ''(Intercept)'''

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
