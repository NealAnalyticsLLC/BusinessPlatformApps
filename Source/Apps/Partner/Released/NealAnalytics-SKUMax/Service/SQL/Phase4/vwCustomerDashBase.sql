------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- vwCustomerDashBase View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwCustomerDashBase'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwCustomerDashBase]'

SET @sqlScript = 
'CREATE VIEW [' + @schema + '].[vwCustomerDashBase] AS SELECT [cv2].[Customer]
	,[cv2].[ModelID]
	,[Latitude]
	,[Longitude]
	,[Zipcode]
	,[cv1].[Product]
	,[pvalue]
	,[Sales Effect]
	,ISNULL([TotalSalesVolume], 0) AS [TotalSalesVolume]
	,(CASE 
		WHEN ISNULL([WeekCount], 0) = 0 
		THEN 1 ELSE 0 
		END) AS [MissingIndicator]
FROM (	SELECT 
			[Customer]
			,MIN([cm].[ModelID]) AS [ModelID]
			,[cm].[Latitude]
			,[cm].[Longitude]
			,[cm].ZipCode
		FROM [' + @schema + '].[vwAllCustomerModels] AS [cm]
		INNER JOIN [' + @schema + '].[modelmeta] AS [mm]
			ON [cm].[ModelID] = [mm].[ModelID]
		WHERE [modelbuilt] = 1
		GROUP BY [Customer]
			,[cm].[ZipCode]
			,[cm].[Latitude]
			,[cm].[Longitude]) AS [cv2]
LEFT JOIN (	SELECT 
				[ModelID]
				,REPLACE([Variable],''`'','''') AS [Product]
				,[Estimate] AS [Sales Effect]
				,[pValue]
			FROM [' + @schema + '].[modelOutput]
			WHERE [Variable] <> ''(Intercept)'') AS [cv1]
	ON [cv2].[ModelID] = [cv1].[ModelID]
LEFT JOIN (	SELECT 
				[Customer]
				,[SKU] AS [Product]
				,SUM([Volume]) AS [TotalSalesVolume]
				,COUNT([Week]) AS [WeekCount]
			FROM [' + @schema + '].[salesData]
			WHERE [Week] > CONCAT(YEAR(GETDATE()),''W'', DATEPART([Week],GETDATE()) - 12)
			GROUP BY [Customer]
				,[SKU]) AS [cv3]
	ON [cv2].[Customer] = [cv3].[Customer]
		AND [cv1].[product] = [cv3].[product]
WHERE [pvalue] < 0.01'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
