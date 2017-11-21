------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- vwBuild_Top90SKUs View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwBuild_Top90SKUs'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwBuild_Top90SKUs]'

SET @sqlScript = 
'CREATE VIEW [' + @schema + '].[vwBuild_Top90SKUs] AS
SELECT * 
FROM (	SELECT
			[SKU]
			,[SalesVol]
			,[PctVol]
			,SUM([PctVol]) OVER (ORDER BY [SalesVol] DESC ROWS UNBOUNDED PRECEDING) AS [CumPctVol]
		FROM (	SELECT 
					[SKU]
					,SUM([Volume]) AS [SalesVol]
					,SUM([Volume])/(SELECT 
									SUM([Volume]) 
								FROM [' + @schema + '].[salesData]) AS [PctVol]
				FROM [' + @schema + '].[salesData]
				GROUP BY SKU) AS [Base]
		) AS [Base2]
WHERE [CumPctVol] <= 0.80000'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
