------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- vwBuild_CustomerDash View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwBuild_CustomerDash'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwBuild_CustomerDash]'

SET @sqlScript = 
'CREATE VIEW [' + @schema + '].[vwBuild_CustomerDash] AS
SELECT 
	[cdv].[Customer]
	,[ModelID]
	,[Latitude]
	,[Longitude]
	,[ZipCode]
	,[Product]
	,[pValue]
	,[Sales Effect]
	,[MissingIndicator]
	,(	CASE 
			WHEN [Sales effect] > ISNULL([AvgSE], 0) 
			THEN 1 
			ELSE 0 
		END) AS [AboveAvgSE]
	,(	CASE 
			WHEN ISNULL(ts.[CumPctVol], 0) = ''0'' 
			THEN 0 
			ELSE 1 
		END) AS [TopVolSKU]
FROM [' + @schema + '].[vwCustomerDashBase] AS [cdv]
LEFT JOIN (SELECT 
				DISTINCT [Customer]
				,(AVG([Sales Effect]) OVER (PARTITION BY [Customer])) AS [AvgSE]
			FROM [' + @schema + '].[vwCustomerDashBase] AS [cdv]
			WHERE [missingindicator] = 0) AS [test]
	ON [cdv].[customer] = [test].[customer]
LEFT JOIN [' + @schema + '].[top90SKUs] AS [ts]
	ON [cdv].[product] = [ts].[SKU]'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
