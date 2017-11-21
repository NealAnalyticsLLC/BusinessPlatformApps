------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- spBuild_CustomerDash View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.routines WHERE SPECIFIC_NAME = ''spBuild_CustomerDash'' AND SPECIFIC_SCHEMA = ''' + @schema + ''' AND ROUTINE_TYPE LIKE ''%PROCEDURE%'') 
  DROP PROCEDURE [' + @schema + '].[spBuild_CustomerDash]'

SET @sqlScript = 
'CREATE PROCEDURE [' + @schema + '].[spBuild_CustomerDash]
	AS 

	BEGIN
		DELETE FROM [' + @schema + '].[customerDash]
		INSERT INTO [' + @schema + '].[customerDash]
		SELECT * FROM [' + @schema + '].[vwBuild_CustomerDash]
	END'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
