------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- vwLast16Weeks View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwLast16Weeks'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwLast12Weeks]'

SET @sqlScript = 
'CREATE VIEW [' + @schema + '].[vwLast12Weeks] AS SELECT 
	 [Week]
	,[SKU]
	,SUM([Volume]) AS [Units]
FROM [' + @schema + '].[salesData]
WHERE [week] >= ''2016W25''
GROUP BY [Week]
	,[SKU]'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
