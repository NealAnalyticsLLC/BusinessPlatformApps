------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- spBuild_CustModelLocation View Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

DECLARE @existTest NVARCHAR(MAX)
DECLARE @sqlScript NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @existTest = 
'IF EXISTS(SELECT * FROM Information_schema.routines WHERE SPECIFIC_NAME = ''spBuild_CustModelLocation'' AND SPECIFIC_SCHEMA = ''' + @schema + ''' AND ROUTINE_TYPE LIKE ''%PROCEDURE%'') 
  DROP PROCEDURE [' + @schema + '].[spBuild_CustModelLocation]'

SET @sqlScript = 
'CREATE PROCEDURE [' + @schema + '].[spBuild_CustModelLocation]
	AS 

	BEGIN
		DELETE FROM [' + @schema + '].[custModelLocation]
		INSERT INTO [' + @schema + '].[custModelLocation]
		SELECT * FROM [' + @schema + '].[vwBuild_CustModelLocation]
	END'

EXECUTE sp_executesql @existTest
EXECUTE sp_executesql @sqlScript
