------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- vwProducts View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwProducts'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwProducts]'

SET @sqlScript = 
'CREATE VIEW [' + @schema + '].[vwProducts] AS SELECT 
	[ds].[SKU]
	,[SKU_Name]
	,[Package_Size]
	,[Unit_Size]
	,[Pack_Type]
	,[Trade_Mark]
	,[Brand]
	,SUM([Volume]) AS [Sales_Volume]
FROM [' + @schema + '].[dimSKU] AS [ds]
INNER JOIN [' + @schema + '].[salesData] AS [csd]
	ON [ds].[SKU] = [csd].[SKU]
GROUP BY [ds].[SKU]
	,[SKU_Name]
	,[Package_Size]
	,[Unit_Size]
	,[Pack_Type]
	,[Trade_Mark]
	,[Brand]'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
