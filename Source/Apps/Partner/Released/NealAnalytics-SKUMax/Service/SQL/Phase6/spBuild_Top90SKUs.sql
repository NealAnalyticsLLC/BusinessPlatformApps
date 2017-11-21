------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- spBuild_Top90SKUs View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.routines WHERE SPECIFIC_NAME = ''spBuild_Top90SKUs'' AND SPECIFIC_SCHEMA = ''' + @schema + ''' AND ROUTINE_TYPE LIKE ''%PROCEDURE%'') 
  DROP PROCEDURE [' + @schema + '].[spBuild_Top90SKUs]'

SET @sqlScript = 
'CREATE PROCEDURE [' + @schema + '].[spBuild_Top90SKUs]
	AS 

	BEGIN
		DELETE FROM [' + @schema + '].[top90SKUs]
		INSERT INTO [' + @schema + '].[top90SKUs]
		SELECT * FROM [' + @schema + '].[vwBuild_Top90SKUs]
	END'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
