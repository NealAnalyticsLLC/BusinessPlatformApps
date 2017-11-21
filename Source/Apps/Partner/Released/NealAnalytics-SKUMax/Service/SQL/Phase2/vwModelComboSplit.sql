------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- vwModelComboSplit View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwModelComboSplit'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwModelComboSplit]'

SET @sqlScript = 
'CREATE VIEW [' + @schema + '].[vwModelComboSplit] AS SELECT
	[ModelID]
	,[Combo]
	,SUBSTRING([Combo], 0, CHARINDEX(''|'', [Combo])) As [Variable1]
	,SUBSTRING([Combo], CHARINDEX(''|'', [Combo]) + 1, CHARINDEX(''|'', [Combo], CHARINDEX(''|'', [Combo]) + 1) - CHARINDEX(''|'', [Combo]) - 1) As [Variable2]
	,SUBSTRING([Combo], CHARINDEX(''|'', [Combo], CHARINDEX(''|'', [Combo]) + 1) + 1, LEN([Combo])-CHARINDEX(''|'', [Combo], CHARINDEX(''|'', [Combo]) + 1)) As [Variable3]
FROM [' + @schema + '].[modelCombos]'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
