------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- vwUniqCustomerModels View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwUniqCustomerModels'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwUniqCustomerModels]'

SET @sqlScript = 
'CREATE VIEW [' + @schema + '].[vwUniqCustomerModels] AS SELECT 
	[Customer]
	,MIN([cml].[ModelID]) AS [ModelID] 
FROM [' + @schema + '].[vwAllCustomerModels] AS [cml]
INNER JOIN [' + @schema + '].[modelMeta] AS [mm]
	ON [cml].[ModelID] = [mm].[ModelID] 
WHERE [ModelBuilt] = 1 
GROUP BY [Customer]'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
