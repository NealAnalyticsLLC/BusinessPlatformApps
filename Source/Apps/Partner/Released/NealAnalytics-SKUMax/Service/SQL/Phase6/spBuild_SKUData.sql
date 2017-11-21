------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- spBuild_SKUData View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.routines WHERE SPECIFIC_NAME = ''spBuild_SKUData'' AND SPECIFIC_SCHEMA = ''' + @schema + ''' AND ROUTINE_TYPE LIKE ''%PROCEDURE%'') 
  DROP PROCEDURE [' + @schema + '].[spBuild_SKUData]'

SET @sqlScript = 
'CREATE PROCEDURE [' + @schema + '].[spBuild_SKUData]
	AS 

	BEGIN
		DELETE FROM [' + @schema + '].[SKUData]
		INSERT INTO [' + @schema + '].[SKUData]
		SELECT * FROM [' + @schema + '].[vwBuild_SKUData]
	END'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
