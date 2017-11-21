------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- modelOutput Table Creation Script						------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- created by:	TORBEA									------------------------------------------------------------
----- creation on:	11/10/16								------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
----- This code drops all tables associated with a SKU Max	------------------------------------------------------------
----- project. The code cleans tables in the reverse order	------------------------------------------------------------
----- that they were built. 								------------------------------------------------------------
-----														------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------



DECLARE @phase_1 NVARCHAR(MAX)
DECLARE @phase_2 NVARCHAR(MAX)
DECLARE @phase_3 NVARCHAR(MAX)
DECLARE @phase_4 NVARCHAR(MAX)
DECLARE @phase_5 NVARCHAR(MAX)
DECLARE @schema NVARCHAR(25)

SET @schema = 'dbo'

SET @phase_5 = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwBuild_CustomerDash'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwBuild_CustomerDash]'

SET @phase_4 = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwSKUAnalysis'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwSKUAnalysis]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwCustomerDashBase'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwCustomerDashBase]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwCustModelLocation'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwCustModelLocation]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwBuild_SKUData'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwBuild_SKUData]'

SET @phase_3 = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwUniqCustomerModels'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwUniqCustomerModels]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwAllCustomerModels'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwAllCustomerModels]'

SET @phase_2 = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwProducts'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwProducts]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwModelData'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwModelData]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwModelComboSplit'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwModelComboSplit]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwLast16Weeks'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwLast16Weeks]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''vwBuild_Top90SKUs'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%VIEW%'') 
  DROP VIEW [' + @schema + '].[vwBuild_Top90SKUs]'  
  
SET @phase_1 = 
'IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''top90SKUs'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[top90SKUs]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''SKUData'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[SKUData]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''salesData'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[salesData]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''modelOutput'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[modelOutput]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''modelMeta'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[modelMeta]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''modelGlance'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[modelGlance]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''modelCombos'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[modelCombos]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''dimSKU'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[dimSKU]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''dimCustomer'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[dimCustomer]
  
  IF EXISTS(SELECT * FROM Information_schema.tables WHERE Table_Name = ''customerDash'' AND TABLE_SCHEMA = ''' + @schema + ''' AND TABLE_TYPE LIKE ''%TABLE%'') 
  DROP TABLE [' + @schema + '].[customerDash]'

EXECUTE sp_executesql @phase_5
EXECUTE sp_executesql @phase_4
EXECUTE sp_executesql @phase_3
EXECUTE sp_executesql @phase_2
EXECUTE sp_executesql @phase_1

