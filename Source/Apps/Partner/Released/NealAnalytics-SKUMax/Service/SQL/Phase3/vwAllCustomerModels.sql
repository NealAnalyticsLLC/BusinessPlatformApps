------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- vwAllCustomerModels View Creation Script				------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwAllCustomerModels'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwAllCustomerModels]'

SET @sqlScript = 
'CREATE VIEW [' + @schema + '].[vwAllCustomerModels] AS SELECT 
	[cm].[Customer]
	,[Latitude]
	,[Longitude]
	,[ZipCode]
	,[cm].[ModelID]
	,[cm].[Variable2]
	,[cm].[Variable1]
	,[cm].[Variable3]
FROM
(SELECT
	[parm].[Customer]
	,[ModelID]
	,[split].[Variable2]
	,[split].[Variable1]
	,[split].[Variable3]
FROM [' + @schema + '].[vwModelComboSplit] AS [split]
INNER JOIN (SELECT 
				[Customer]
				,[Variable2]
				,[Variable1]
				,[Variable3]
			FROM [' + @schema + '].[dimCustomer]) AS [parm] 
	ON [parm].[Variable2] = [split].[Variable2]
		AND [parm].[Variable1] = [split].[Variable1]
		AND [parm].[Variable3] = [split].[Variable3]
UNION SELECT
	[parm].[Customer]
	,[ModelID]
	,[split].[Variable2]
	,[split].[Variable1]
	,[split].[Variable3]
FROM [' + @schema + '].[vwModelComboSplit] AS [split]
INNER JOIN (SELECT 
				[Customer]
				,[Variable2]
				,[Variable1]
				,'''' AS [Variable3]
			FROM [' + @schema + '].[dimCustomer]) AS [parm] 
	ON [parm].[Variable2] = [split].[Variable2]
		AND [parm].[Variable1] = [split].[Variable1]
		AND [parm].[Variable3] = [split].[Variable3]
UNION SELECT
	[parm].[Customer]
	,[ModelID]
	,[split].[Variable2]
	,[split].[Variable1]
	,[split].[Variable3]
FROM [' + @schema + '].[vwModelComboSplit] AS [split]
INNER JOIN (SELECT 
				[Customer]
				,'''' AS [Variable2]
				,[Variable1]
				,'''' AS [Variable3]
			FROM [' + @schema + '].[dimCustomer]) AS [parm] 
	ON [parm].[Variable2] = [split].[Variable2]
		AND [parm].[Variable1] = [split].[Variable1]
		AND [parm].[Variable3] = [split].[Variable3]) AS [cm]
INNER JOIN [' + @schema + '].[dimCustomer] AS [cust]
	ON [cm].[customer] = [cust].[customer]'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
