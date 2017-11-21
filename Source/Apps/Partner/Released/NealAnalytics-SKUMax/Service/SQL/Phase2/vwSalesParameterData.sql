------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- vwSalesParameterData View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwSalesParameterData'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwSalesParameterData]'

SET @sqlScript = 
'CREATE VIEW [' + @schema + '].[vwSalesParameterData] AS
	SELECT
		[Week]
		,[sd].[Customer]
		,[Revenue]
		,[SKU]
		,[Volume]
		,[Variable1]
		,[Variable2]
		,[Variable3]
	FROM [' + @schema + '].[salesData] AS [sd]
	INNER JOIN [' + @schema + '].[dimCustomer] as [dc]
		ON [sd].[Customer] = [dc].[Customer]
'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
