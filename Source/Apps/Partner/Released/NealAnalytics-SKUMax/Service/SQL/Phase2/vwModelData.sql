------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- vwModelData View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM [Information_schema].[tables] WHERE [Table_Name] = ''vwModelData'' AND [TABLE_SCHEMA] = ''' + @schema + ''' AND [TABLE_TYPE] LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwModelData]'

SET @sqlScript = 
'CREATE VIEW [' + @schema + '].[vwModelData] AS SELECT
	[mc].[ModelID]
	,SUBSTRING([Combo], 0, CHARINDEX(''|'', [Combo])) AS [Variable1]
	,SUBSTRING([Combo], CHARINDEX(''|'', [Combo]) + 1, CHARINDEX(''|'', [Combo], CHARINDEX(''|'', [Combo]) + 1) - CHARINDEX(''|'', [Combo]) - 1) AS [Variable2]
	,SUBSTRING([Combo], CHARINDEX(''|'', [Combo], CHARINDEX(''|'', [Combo]) + 1) + 1, LEN([Combo])-CHARINDEX(''|'', [Combo], CHARINDEX(''|'', [Combo]) + 1)) AS [Variable3]
	,[ModelBuilt]
	,[NumbofObs]
	,[TotalSKUs]
	,[NumbSKUs]
	,[NumbCust]
FROM [' + @schema + '].[modelCombos] AS [mc]
INNER JOIN [' + @schema + '].[modelmeta] AS [mm]
	ON [mc].[ModelID] = [mm].[ModelID]'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
