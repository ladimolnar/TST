--===================================================================
-- FILE: SetTSTCheck.sql
-- This script will setup one of the databases used to test the 
-- TST infrastructure.
-- Suites and tests contained here will be fed into TST.
-- Validations contained in another database: TSTCheckMaster 
-- will actually test the TST features when run against suites 
-- and tests contained here. 
-- ==================================================================

USE tempdb
GO

-- =======================================================================
-- Creates the TSTCheck Database. If already exists then drops it first.
-- =======================================================================
IF EXISTS (SELECT [name] FROM sys.databases WHERE [name] = 'TSTCheck')
BEGIN
   DROP DATABASE TSTCheck
END

CREATE DATABASE TSTCheck
GO

USE TSTCheck
GO


-- =======================================================================
-- The actual functions and stored procedures
-- =======================================================================
GO

CREATE FUNCTION dbo.SVFn_AddTwoNumbers(@A int, @B int) RETURNS int
AS
BEGIN
   RETURN @A + @B
END
GO

CREATE PROCEDURE SV_GenerateSquence
AS
BEGIN
   SELECT 1
   UNION SELECT 2
   UNION SELECT 3
   UNION SELECT 4
   UNION SELECT 5
END
GO

-- =======================================================================
-- Used to test TST.dbo.SFN_SProcExists
-- =======================================================================
CREATE FUNCTION dbo.ExistingFc(@A int) RETURNS int
AS
BEGIN
   RETURN @A
END
GO

-- =======================================================================
-- Used to test TST.dbo.SFN_SProcExists
-- =======================================================================
CREATE PROCEDURE dbo.ExistingSProc
AS
BEGIN
   PRINT 'This is ExistingSProc'
END
GO


-- =======================================================================
-- Create a TST suite. Does not do anything in itself. 
-- Used to test TST.Data.SuiteExists
-- =======================================================================
CREATE PROCEDURE dbo.SQLTest_Suite1#TestA
AS
BEGIN
   EXEC TST.Assert.Pass 'Test suite' 
END
GO


-- =======================================================================
-- The TST test stored procedures
-- =======================================================================

CREATE PROCEDURE dbo.SQLTest_Log
AS
BEGIN
   EXEC TST.Assert.LogInfo  'Test log message in SQLTest_Log ĂÎÂȘȚăîâșț'
   EXEC TST.Assert.Pass 'Test pass message in SQLTest_Log ĂÎÂȘȚăîâșț'
END
GO

CREATE PROCEDURE dbo.SQLTest_LogNullContext
AS
BEGIN
   EXEC TST.Assert.LogInfo  NULL
   EXEC TST.Assert.Pass 'Test pass message in SQLTest_LogNullContext'
END
GO

CREATE PROCEDURE dbo.SQLTest_Fail
AS
BEGIN
   EXEC TST.Assert.Fail 'Test fail message in SQLTest_Fail ĂÎÂȘȚăîâșț'

   EXEC TST.Assert.LogInfo  'This log should not be executed'
END
GO

CREATE PROCEDURE dbo.SQLTest_FailNullContext
AS
BEGIN
   EXEC TST.Assert.Fail NULL

   EXEC TST.Assert.LogInfo  'This log should not be executed'
END
GO


CREATE PROCEDURE dbo.SQLTest_Pass
AS
BEGIN
   EXEC TST.Assert.Pass 'Test pass message in SQLTest_Pass'
END
GO

CREATE PROCEDURE dbo.SQLTest_PassNullContext
AS
BEGIN
   EXEC TST.Assert.Pass NULL
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsTrue
AS
BEGIN
   EXEC TST.Assert.Equals 'Test Assert.Equals in SQLTest_AssertEqualsTrue ĂÎÂȘȚăîâșț', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFalse
AS
BEGIN
   EXEC TST.Assert.Equals 'Test Assert.Equals in SQLTest_AssertEqualsFalse ĂÎÂȘȚăîâșț', 1, 2

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsExpectedParamIsNull
AS
BEGIN
   EXEC TST.Assert.Equals 'Test Assert.Equals in SQLTest_AssertEqualsExpectedParamIsNull', NULL, 1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsActualParamIsNull
AS
BEGIN
   EXEC TST.Assert.Equals 'Test Assert.Equals in SQLTest_AssertEqualsActualParamIsNull', 1, NULL

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsBothParamsAreNull
AS
BEGIN
   EXEC TST.Assert.Equals 'Test Assert.Equals in SQLTest_AssertEqualsBothParamsAreNull', NULL, NULL

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsNullContext
AS
BEGIN
   EXEC TST.Assert.Equals NULL, 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsTrue
AS
BEGIN
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in SQLTest_AssertNotEqualsTrue ĂÎÂȘȚăîâșț', 1, 2
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFalse
AS
BEGIN
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in SQLTest_AssertNotEqualsFalse ĂÎÂȘȚăîâșț', 1, 1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsExpectedParamIsNull
AS
BEGIN
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in SQLTest_AssertNotEqualsExpectedParamIsNull', NULL, 1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsActualParamIsNull
AS
BEGIN
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in SQLTest_AssertNotEqualsActualParamIsNull', 1, NULL

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsBothParamsAreNull
AS
BEGIN
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in SQLTest_AssertNotEqualsBothParamsAreNull', NULL, NULL

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsNullContext
AS
BEGIN
   EXEC TST.Assert.NotEquals NULL, 1, 2
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumEqualsTrue
AS
BEGIN
   EXEC TST.Assert.NumericEquals 'Test Assert.NumericEquals in SQLTest_AssertNumEqualsTrue ĂÎÂȘȚăîâșț', 1.123, 1.12345, 0.001
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumEqualsFalse
AS
BEGIN
   EXEC TST.Assert.NumericEquals 'Test Assert.NumericEquals in SQLTest_AssertNumEqualsFalse ĂÎÂȘȚăîâșț', 12345678901234567890123.456789012345678, 12345678901234567890123.456789012345676, 0.000000000000001

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumEqualsExpectedParamIsNull
AS
BEGIN
   EXEC TST.Assert.NumericEquals 'Test Assert.NumericEquals in SQLTest_AssertNumEqualsExpectedParamIsNull', NULL, 1.234, 0.1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumEqualsActualParamIsNull
AS
BEGIN
   EXEC TST.Assert.NumericEquals 'Test Assert.NumericEquals in SQLTest_AssertNumEqualsActualParamIsNull', 1.123, NULL, 0.1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumEqualsBothParamsAreNull
AS
BEGIN
   EXEC TST.Assert.NumericEquals 'Test Assert.NumericEquals in SQLTest_AssertNumEqualsBothParamsAreNull', NULL, NULL, 0.1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumEqualsNullContext
AS
BEGIN
   EXEC TST.Assert.NumericEquals NULL, 1.23456, 1.234, 0.001
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumNotEqualsTrue
AS
BEGIN
   EXEC TST.Assert.NumericNotEquals 'Test Assert.NumericNotEquals in SQLTest_AssertNumNotEqualsTrue', 1.123, 1.125, 0.001
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumNotEqualsFalse
AS
BEGIN
   EXEC TST.Assert.NumericNotEquals 'Test Assert.NumericNotEquals in SQLTest_AssertNumNotEqualsFalse', 12345678901234567890123.456789012345678, 12345678901234567890123.456789012345678, 0.000000000000001

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumNotEqualsExpectedParamIsNull
AS
BEGIN
   EXEC TST.Assert.NumericNotEquals 'Test Assert.NumericNotEquals in SQLTest_AssertNumNotEqualsExpectedParamIsNull', NULL, 1.234, 0.1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumNotEqualsActualParamIsNull
AS
BEGIN
   EXEC TST.Assert.NumericNotEquals 'Test Assert.NumericNotEquals in SQLTest_AssertNumNotEqualsActualParamIsNull', 1.123, NULL, 0.1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumNotEqualsBothParamsAreNull
AS
BEGIN
   EXEC TST.Assert.NumericNotEquals 'Test Assert.NumericNotEquals in SQLTest_AssertNumNotEqualsBothParamsAreNull', NULL, NULL, 0.1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumNotEqualsNullContext
AS
BEGIN
   EXEC TST.Assert.NumericNotEquals NULL, 1.234, 1.236, 0.001
END
GO

-- =======================================================================
-- START Suite AssertNumEqualsFail
-- Suite AssertNumEqualsFail will test failing Assert.NumericEquals with each 
-- data type
-- =======================================================================

CREATE PROCEDURE dbo.SQLTest_AssertNumEqualsFail#numeric             

AS
BEGIN
  
   DECLARE @Var_numeric   numeric(38,15)
   SET @Var_numeric = 12345678901234567890123.456789012345678

   EXEC TST.Assert.NumericEquals 'Test Assert.NumericEquals in suite AssertNumEqualsFail', 12345678901234567890123.456789012345676, @Var_numeric, 0.000000000000001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumEqualsFail#decimal             
AS
BEGIN
  
   DECLARE @Var_decimal   decimal(38,15)
   SET @Var_decimal = 12345678901234567890123.456789012345678
   
   EXEC TST.Assert.NumericEquals 'Test Assert.NumericEquals in suite AssertNumEqualsFail', 12345678901234567890123.456789012345676, @Var_decimal, 0.000000000000001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumEqualsFail#smallmoney
AS
BEGIN
  
   DECLARE @Var_smallmoney  smallmoney    
   SET @Var_smallmoney = -214748.3648

   EXEC TST.Assert.NumericEquals 'Test Assert.NumericEquals in suite AssertNumEqualsFail', -214748.3646, @Var_smallmoney, 0.0001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumEqualsFail#int                 
AS
BEGIN
  
   DECLARE @Var_int       int           
   SET @Var_int = 1000

   EXEC TST.Assert.NumericEquals 'Test Assert.NumericEquals in suite AssertNumEqualsFail', 1002, @Var_int, 1
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumEqualsFail#money               
AS
BEGIN
  
   DECLARE @Var_money     money         
   SET @Var_money = 922337203685477.5807

   EXEC TST.Assert.NumericEquals 'Test Assert.NumericEquals in suite AssertNumEqualsFail', 922337203685477.5805, @Var_money, 0.0001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumEqualsFail#float               
AS
BEGIN
  
   DECLARE @Var_float     float         
   SET @Var_float = 1.1234567890

   EXEC TST.Assert.NumericEquals 'Test Assert.NumericEquals in suite AssertNumEqualsFail', 1.1234567892, @Var_float, 0.0000000001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumEqualsFail#real                
AS
BEGIN
  
   DECLARE @Var_real      real          
   SET @Var_real = 1.234567 

   EXEC TST.Assert.NumericEquals 'Test Assert.NumericEquals in suite AssertNumEqualsFail', 1.234565, @Var_real, 0.000001 
   
END
GO

-- =======================================================================
-- END Suite AssertNumNotEqualsFail
-- =======================================================================

-- =======================================================================
-- START Suite AssertNumNotEqualsFail
-- Suite AssertNumNotEqualsFail will test failing Assert.NumericNotEquals
-- with each data type
-- =======================================================================

CREATE PROCEDURE dbo.SQLTest_AssertNumNotEqualsFail#numeric             

AS
BEGIN
  
   DECLARE @Var_numeric   numeric(38,15)
   SET @Var_numeric = 12345678901234567890123.456789012345678

   EXEC TST.Assert.NumericNotEquals 'Test Assert.NumericNotEquals in suite AssertNumNotEqualsFail', 12345678901234567890123.456789012345678, @Var_numeric, 0.000000000000001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumNotEqualsFail#decimal             
AS
BEGIN
  
   DECLARE @Var_decimal   decimal(38,15)
   SET @Var_decimal = 12345678901234567890123.456789012345678
   
   EXEC TST.Assert.NumericNotEquals 'Test Assert.NumericNotEquals in suite AssertNumNotEqualsFail', 12345678901234567890123.456789012345678, @Var_decimal, 0.000000000000001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumNotEqualsFail#smallmoney
AS
BEGIN
  
   DECLARE @Var_smallmoney  smallmoney    
   SET @Var_smallmoney = -214748.3648

   EXEC TST.Assert.NumericNotEquals 'Test Assert.NumericNotEquals in suite AssertNumNotEqualsFail', -214748.3648, @Var_smallmoney, 0.0001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumNotEqualsFail#int                 
AS
BEGIN
  
   DECLARE @Var_int       int           
   SET @Var_int = 1000

   EXEC TST.Assert.NumericNotEquals 'Test Assert.NumericNotEquals in suite AssertNumNotEqualsFail', 1000, @Var_int, 1
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumNotEqualsFail#money               
AS
BEGIN
  
   DECLARE @Var_money     money         
   SET @Var_money = 922337203685477.5807

   EXEC TST.Assert.NumericNotEquals 'Test Assert.NumericNotEquals in suite AssertNumNotEqualsFail', 922337203685477.5807, @Var_money, 0.0001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumNotEqualsFail#float               
AS
BEGIN
  
   DECLARE @Var_float     float         
   SET @Var_float = 1.1234567890

   EXEC TST.Assert.NumericNotEquals 'Test Assert.NumericNotEquals in suite AssertNumNotEqualsFail', 1.1234567890, @Var_float, 0.0000000001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNumNotEqualsFail#real                
AS
BEGIN
  
   DECLARE @Var_real      real          
   SET @Var_real = 1.234567 

   EXEC TST.Assert.NumericNotEquals 'Test Assert.NumericNotEquals in suite AssertNumNotEqualsFail', 1.234567, @Var_real, 0.000001 
   
END
GO

-- =======================================================================
-- END Suite AssertNumNotEqualsFail
-- =======================================================================

CREATE PROCEDURE dbo.SQLTest_AssertFloatEqualsTrue
AS
BEGIN
   EXEC TST.Assert.FloatEquals 'Test Assert.FloatEquals in SQLTest_AssertFloatEqualsTrue ĂÎÂȘȚăîâșț', 1.23456789012345, 1.23456789012346, 0.00000000000001
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatEqualsFalse
AS
BEGIN
   EXEC TST.Assert.FloatEquals 'Test Assert.FloatEquals in SQLTest_AssertFloatEqualsFalse ĂÎÂȘȚăîâșț', 1.23456789012345, 1.23456789012347, 0.00000000000001

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatEqualsExpectedParamIsNull
AS
BEGIN
   EXEC TST.Assert.FloatEquals 'Test Assert.FloatEquals in SQLTest_AssertFloatEqualsExpectedParamIsNull', NULL, 1.234, 0.1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatEqualsActualParamIsNull
AS
BEGIN
   EXEC TST.Assert.FloatEquals 'Test Assert.FloatEquals in SQLTest_AssertFloatEqualsActualParamIsNull', 1.123, NULL, 0.1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatEqualsBothParamsAreNull
AS
BEGIN
   EXEC TST.Assert.FloatEquals 'Test Assert.FloatEquals in SQLTest_AssertFloatEqualsBothParamsAreNull', NULL, NULL, 0.1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatEqualsNullContext
AS
BEGIN
   EXEC TST.Assert.FloatEquals NULL, 1.23456, 1.234, 0.001
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatNotEqualsTrue
AS
BEGIN
   EXEC TST.Assert.FloatNotEquals 'Test Assert.FloatNotEquals in SQLTest_AssertFloatNotEqualsTrue ĂÎÂȘȚăîâșț', 1.23456789012345, 1.23456789012347, 0.00000000000001
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatNotEqualsFalse
AS
BEGIN
   EXEC TST.Assert.FloatNotEquals 'Test Assert.FloatNotEquals in SQLTest_AssertFloatNotEqualsFalse ĂÎÂȘȚăîâșț', 1.23456789012345, 1.23456789012346, 0.00000000000001

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatNotEqualsExpectedParamIsNull
AS
BEGIN
   EXEC TST.Assert.FloatNotEquals 'Test Assert.FloatNotEquals in SQLTest_AssertFloatNotEqualsExpectedParamIsNull', NULL, 1.234, 0.1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatNotEqualsActualParamIsNull
AS
BEGIN
   EXEC TST.Assert.FloatNotEquals 'Test Assert.FloatNotEquals in SQLTest_AssertFloatNotEqualsActualParamIsNull', 1.123, NULL, 0.1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatNotEqualsBothParamsAreNull
AS
BEGIN
   EXEC TST.Assert.FloatNotEquals 'Test Assert.FloatNotEquals in SQLTest_AssertFloatNotEqualsBothParamsAreNull', NULL, NULL, 0.1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatNotEqualsNullContext
AS
BEGIN
   EXEC TST.Assert.FloatNotEquals NULL, 1.236, 1.234, 0.001
END
GO

-- =======================================================================
-- START Suite AssertFloatEqualsFail
-- Suite AssertFloatEqualsFail will test failing Assert.FloatEquals with each 
-- data type
-- =======================================================================

CREATE PROCEDURE dbo.SQLTest_AssertFloatEqualsFail#numeric             

AS
BEGIN
  
   DECLARE @Var_numeric   numeric(15,5)
   SET @Var_numeric = 1234567890.12345

   EXEC TST.Assert.FloatEquals 'Test Assert.FloatEquals in suite AssertFloatEqualsFail', 1234567890.12347, @Var_numeric, 0.00001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatEqualsFail#decimal             
AS
BEGIN
  
   DECLARE @Var_decimal   decimal(15,5)
   SET @Var_decimal = 1234567890.12345
   
   EXEC TST.Assert.FloatEquals 'Test Assert.FloatEquals in suite AssertFloatEqualsFail', 1234567890.12347, @Var_decimal, 0.00001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatEqualsFail#smallmoney
AS
BEGIN
  
   DECLARE @Var_smallmoney  smallmoney    
   SET @Var_smallmoney = -214748.3648

   EXEC TST.Assert.FloatEquals 'Test Assert.FloatEquals in suite AssertFloatEqualsFail', -214748.3646, @Var_smallmoney, 0.0001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatEqualsFail#int                 
AS
BEGIN
  
   DECLARE @Var_int       int           
   SET @Var_int = 1000

   EXEC TST.Assert.FloatEquals 'Test Assert.FloatEquals in suite AssertFloatEqualsFail', 1002, @Var_int, 1
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatEqualsFail#money               
AS
BEGIN
  
   DECLARE @Var_money     money         
   SET @Var_money = 12345678901.2345

   EXEC TST.Assert.FloatEquals 'Test Assert.FloatEquals in suite AssertFloatEqualsFail', 12345678901.2347, @Var_money, 0.0001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatEqualsFail#float               
AS
BEGIN
  
   DECLARE @Var_float     float         
   SET @Var_float = 1.23456789012345

   EXEC TST.Assert.FloatEquals 'Test Assert.FloatEquals in suite AssertFloatEqualsFail', 1.23456789012347, @Var_float, 0.00000000000001
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatEqualsFail#real                
AS
BEGIN
  
   DECLARE @Var_real      real          
   SET @Var_real = 1.234567 

   EXEC TST.Assert.FloatEquals 'Test Assert.FloatEquals in suite AssertFloatEqualsFail', 1.234565, @Var_real, 0.000001 
   
END
GO

-- =======================================================================
-- END Suite AssertFloatEqualsFail
-- =======================================================================

-- =======================================================================
-- START Suite AssertFloatNotEqualsFail
-- Suite Assert.FloatNotEquals will test failing Assert.FloatNotEquals with 
-- each data type.
-- =======================================================================

CREATE PROCEDURE dbo.SQLTest_AssertFloatNotEqualsFail#numeric             

AS
BEGIN
  
   DECLARE @Var_numeric   numeric(15,5)
   SET @Var_numeric = 1234567890.12345

   EXEC TST.Assert.FloatNotEquals 'Test Assert.FloatNotEquals in suite AssertFloatNotEqualsFail', 1234567890.12346, @Var_numeric, 0.00002
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatNotEqualsFail#decimal             
AS
BEGIN
  
   DECLARE @Var_decimal   decimal(15,5)
   SET @Var_decimal = 1234567890.12345
   
   EXEC TST.Assert.FloatNotEquals 'Test Assert.FloatNotEquals in suite AssertFloatNotEqualsFail', 1234567890.12346, @Var_decimal, 0.00002
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatNotEqualsFail#smallmoney
AS
BEGIN
  
   DECLARE @Var_smallmoney  smallmoney    
   SET @Var_smallmoney = -214748.3648

   EXEC TST.Assert.FloatNotEquals 'Test Assert.FloatNotEquals in suite AssertFloatNotEqualsFail', -214748.3647, @Var_smallmoney, 0.0002
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatNotEqualsFail#int                 
AS
BEGIN
  
   DECLARE @Var_int       int           
   SET @Var_int = 1000

   EXEC TST.Assert.FloatNotEquals 'Test Assert.FloatNotEquals in suite AssertFloatNotEqualsFail', 1001, @Var_int, 2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatNotEqualsFail#money               
AS
BEGIN
  
   DECLARE @Var_money     money         
   SET @Var_money = 12345678901.2345

   EXEC TST.Assert.FloatNotEquals 'Test Assert.FloatNotEquals in suite AssertFloatNotEqualsFail', 12345678901.2346, @Var_money, 0.0002
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatNotEqualsFail#float               
AS
BEGIN
  
   DECLARE @Var_float     float         
   SET @Var_float = 1.23456789012345

   EXEC TST.Assert.FloatNotEquals 'Test Assert.FloatNotEquals in suite AssertFloatNotEqualsFail', 1.23456789012346, @Var_float, 0.00000000000002
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertFloatNotEqualsFail#real
AS
BEGIN
  
   DECLARE @Var_real      real          
   SET @Var_real = 1.234567 

   EXEC TST.Assert.FloatNotEquals 'Test Assert.FloatNotEquals in suite AssertFloatNotEqualsFail', 1.234566, @Var_real, 0.000002 
   
END
GO

-- =======================================================================
-- END Suite AssertFloatNotEqualsFail
-- =======================================================================


CREATE PROCEDURE GetTwoLongString
   @LongString1   varchar(max) OUT,
   @LongString2   varchar(max) OUT
AS 
BEGIN

   DECLARE @Count int 
   SET @Count = 5

   SET @LongString1 = ''
   SET @LongString2 = ''

   WHILE (@Count > 0)
   BEGIN
      SET @LongString1 = @LongString1 + '01234567890'
      SET @LongString2 = @LongString2 + '01234567890'
      
      SET @Count=@Count-10
   END

END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNVarCharMaxEqualsPass
AS
BEGIN

   DECLARE @LongString1   varchar(max)
   DECLARE @LongString2   varchar(max)

   EXEC GetTwoLongString @LongString1 OUT, @LongString2 OUT

   EXEC TST.Assert.NVarCharMaxEquals 'Test Assert.NVarCharMaxEquals in SQLTest_AssertNVarCharMaxEqualsPass', @LongString1, @LongString2

END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNVarCharMaxEqualsFail
AS
BEGIN

   DECLARE @LongString1   varchar(max)
   DECLARE @LongString2   varchar(max)

   EXEC GetTwoLongString @LongString1 OUT, @LongString2 OUT
   SET @LongString2 = @LongString2 + 'a'

   EXEC TST.Assert.NVarCharMaxEquals 'Test Assert.NVarCharMaxEquals in SQLTest_AssertNVarCharMaxEqualsFail', @LongString1, @LongString2

END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNVarCharMaxEqualsExpectedParamIsNull
AS
BEGIN
   EXEC TST.Assert.NVarCharMaxEquals 'Test Assert.NVarCharMaxEquals in SQLTest_AssertNVarCharMaxEqualsExpectedParamIsNull', NULL, '123'
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNVarCharMaxEqualsActualParamIsNull
AS
BEGIN
   EXEC TST.Assert.NVarCharMaxEquals 'Test Assert.NVarCharMaxEquals in SQLTest_AssertNVarCharMaxEqualsActualParamIsNull', '123', NULL
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNVarCharMaxEqualsBothParamsAreNull
AS
BEGIN
   EXEC TST.Assert.NVarCharMaxEquals 'Test Assert.NVarCharMaxEquals in SQLTest_AssertNVarCharMaxEqualsBothParamsAreNull', NULL, NULL
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNVarCharMaxEqualsNullContext
AS
BEGIN
   EXEC TST.Assert.NVarCharMaxEquals NULL, '123', '123'
END
GO


CREATE PROCEDURE dbo.SQLTest_AssertNVarCharMaxNotEqualsPass
AS
BEGIN

   DECLARE @LongString1   varchar(max)
   DECLARE @LongString2   varchar(max)

   EXEC GetTwoLongString @LongString1 OUT, @LongString2 OUT
   SET @LongString2 = @LongString2 + 'a'

   EXEC TST.Assert.NVarCharMaxNotEquals 'Test Assert.NVarCharMaxNotEquals in SQLTest_AssertNVarCharMaxNotEqualsPass', @LongString1, @LongString2

END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNVarCharMaxNotEqualsFail
AS
BEGIN

   DECLARE @LongString1   varchar(max)
   DECLARE @LongString2   varchar(max)

   EXEC GetTwoLongString @LongString1 OUT, @LongString2 OUT

   EXEC TST.Assert.NVarCharMaxNotEquals 'Test Assert.NVarCharMaxNotEquals in SQLTest_AssertNVarCharMaxNotEqualsFail', @LongString1, @LongString2

END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNVarCharMaxNotEqualsExpectedParamIsNull
AS
BEGIN
   EXEC TST.Assert.NVarCharMaxNotEquals 'Test Assert.NVarCharMaxNotEquals in SQLTest_AssertNVarCharMaxNotEqualsExpectedParamIsNull', NULL, '123'
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNVarCharMaxNotEqualsActualParamIsNull
AS
BEGIN
   EXEC TST.Assert.NVarCharMaxNotEquals 'Test Assert.NVarCharMaxNotEquals in SQLTest_AssertNVarCharMaxNotEqualsActualParamIsNull', '123', NULL
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNVarCharMaxNotEqualsBothParamsAreNull
AS
BEGIN
   EXEC TST.Assert.NVarCharMaxNotEquals 'Test Assert.NVarCharMaxNotEquals in SQLTest_AssertNVarCharMaxNotEqualsBothParamsAreNull', NULL, NULL
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNVarCharMaxNotEqualsNullContext
AS
BEGIN
   EXEC TST.Assert.NVarCharMaxNotEquals NULL, '123', 'abc'
END
GO


CREATE PROCEDURE dbo.SQLTest_AssertLikeTrue
AS
BEGIN
   EXEC TST.Assert.IsLike 'Test Assert.IsLike in SQLTest_AssertLikeTrue ĂÎÂȘȚăîâșț', 'abc%', 'abc 123'
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertLikeFalse
AS
BEGIN
   EXEC TST.Assert.IsLike 'Test Assert.IsLike in SQLTest_AssertLikeFalse ĂÎÂȘȚăîâșț', 'abc%', 'xyz 123'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertLikeExpectedParamIsNull
AS
BEGIN
   EXEC TST.Assert.IsLike 'Test Assert.IsLike in SQLTest_AssertLikeExpectedParamIsNull', NULL, 'abc'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertLikeActualParamIsNull
AS
BEGIN
   EXEC TST.Assert.IsLike 'Test Assert.IsLike in SQLTest_AssertLikeActualParamIsNull', 'abc%', NULL

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertLikeBothParamsAreNull
AS
BEGIN
   EXEC TST.Assert.IsLike 'Test Assert.IsLike in SQLTest_AssertLikeBothParamsAreNull', NULL, NULL

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertLikeNullContext
AS
BEGIN
   EXEC TST.Assert.IsLike NULL, 'abc%', 'abc xyz'
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotLikeTrue
AS
BEGIN
   EXEC TST.Assert.IsNotLike 'Test Assert.IsNotLike in SQLTest_AssertNotLikeTrue ĂÎÂȘȚăîâșț', 'abc%', 'xyz 123'
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotLikeFalse
AS
BEGIN
   EXEC TST.Assert.IsNotLike 'Test Assert.IsNotLike in SQLTest_AssertNotLikeFalse ĂÎÂȘȚăîâșț', 'abc%', 'abc 123'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotLikeExpectedParamIsNull
AS
BEGIN
   EXEC TST.Assert.IsNotLike 'Test Assert.IsNotLike in SQLTest_AssertNotLikeExpectedParamIsNull', NULL, 'abc'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotLikeActualParamIsNull
AS
BEGIN
   EXEC TST.Assert.IsNotLike 'Test Assert.IsNotLike in SQLTest_AssertNotLikeActualParamIsNull', 'abc%', NULL

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotLikeBothParamsAreNull
AS
BEGIN
   EXEC TST.Assert.IsNotLike 'Test Assert.IsNotLike in SQLTest_AssertNotLikeBothParamsAreNull', NULL, NULL

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotLikeNullContext
AS
BEGIN
   EXEC TST.Assert.IsNotLike NULL, 'abc%', 'xyz 123'
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertIsNullTrue
AS
BEGIN
   EXEC TST.Assert.IsNull 'Test Assert.IsNull in SQLTest_AssertIsNullTrue ĂÎÂȘȚăîâșț', NULL
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertIsNullFalse
AS
BEGIN
   EXEC TST.Assert.IsNull 'Test Assert.IsNull in SQLTest_AssertIsNullFalse ĂÎÂȘȚăîâșț', 1

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertIsNullNullContext
AS
BEGIN
   EXEC TST.Assert.IsNull NULL, NULL
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertIsNotNullTrue
AS
BEGIN
   EXEC TST.Assert.IsNotNull 'Test Assert.IsNotNull in SQLTest_AssertIsNotNullTrue ĂÎÂȘȚăîâșț', 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertIsNotNullFalse
AS
BEGIN
   EXEC TST.Assert.IsNotNull 'Test Assert.IsNotNull in SQLTest_AssertIsNotNullFalse ĂÎÂȘȚăîâșț', NULL

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertIsNotNullNullContext
AS
BEGIN
   EXEC TST.Assert.IsNotNull NULL, 1
END
GO


-- =======================================================================
-- START Suite AssertEqualsFail
-- Suite AssertEqualsFail will test failing Assert.Equals with each 
-- data type
-- =======================================================================

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#bigint
AS
BEGIN
  
   DECLARE @Var_bigint_1    bigint        
   DECLARE @Var_bigint_2    bigint             
   SET @Var_bigint_1        = CAST(9223372036854775807 AS bigint) 
   SET @Var_bigint_2        = CAST(9223372036854775806 AS bigint)
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_bigint_1, @Var_bigint_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#numeric             

AS
BEGIN
  
   DECLARE @Var_numeric_1   numeric(38,15)
   DECLARE @Var_numeric_2   numeric(38,15)     
   SET @Var_numeric_1       = CAST(12345678901234567890123.456789012345678 AS numeric(38,15)) 
   SET @Var_numeric_2       = CAST(12345678901234567890123.456789012345679 AS numeric(38,15))
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_numeric_1, @Var_numeric_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#bit                 
AS
BEGIN
  
   DECLARE @Var_bit_1       bit           
   DECLARE @Var_bit_2       bit                
   SET @Var_bit_1           = CAST(1 AS bit) 
   SET @Var_bit_2           = CAST(0 AS bit)
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_bit_1, @Var_bit_2

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#smallint            
AS
BEGIN
  
   DECLARE @Var_smallint_1  smallint      
   DECLARE @Var_smallint_2  smallint           
   SET @Var_smallint_1      = CAST(32767 AS smallint) 
   SET @Var_smallint_2      = CAST(32766 AS smallint)
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_smallint_1, @Var_smallint_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#decimal             
AS
BEGIN
  
   DECLARE @Var_decimal_1   decimal(38,15)
   DECLARE @Var_decimal_2   decimal(38,15)     
   SET @Var_decimal_1       = CAST(12345678901234567890123.456789012345678 AS decimal(38,15)) 
   SET @Var_decimal_2       = CAST(12345678901234567890123.456789012345679 AS decimal(38,15))
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_decimal_1, @Var_decimal_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#smallmoney
AS
BEGIN
  
   DECLARE @Var_smallmoney_1  smallmoney    
   DECLARE @Var_smallmoney_2  smallmoney         
   SET @Var_smallmoney_1      = CAST(-214748.3648  AS smallmoney) 
   SET @Var_smallmoney_2      = CAST(-214748.3647  AS smallmoney)
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_smallmoney_1, @Var_smallmoney_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#int                 
AS
BEGIN
  
   DECLARE @Var_int_1       int           
   DECLARE @Var_int_2       int                
   SET @Var_int_1           = CAST(-2147483648 AS int) 
   SET @Var_int_2           = CAST(-2147483647 AS int)
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_int_1, @Var_int_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#tinyint             
AS
BEGIN
  
   DECLARE @Var_tinyint_1   tinyint       
   DECLARE @Var_tinyint_2   tinyint            
   SET @Var_tinyint_1       = CAST(255 AS tinyint) 
   SET @Var_tinyint_2       = CAST(254 AS tinyint)
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_tinyint_1, @Var_tinyint_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#money               
AS
BEGIN
  
   DECLARE @Var_money_1     money         
   DECLARE @Var_money_2     money              
   SET @Var_money_1         = CAST(922337203685477.5807 AS money) 
   SET @Var_money_2         = CAST(922337203685477.5806 AS money)
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_money_1, @Var_money_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#datetime            
AS
BEGIN
  
   DECLARE @Var_datetime_1  datetime      
   DECLARE @Var_datetime_2  datetime           
   SET @Var_datetime_1      = CAST('2001-01-01 23:59:59.199' AS datetime) 
   SET @Var_datetime_2      = CAST('2001-01-01 23:59:59.198' AS datetime)
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_datetime_1, @Var_datetime_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#char                
AS
BEGIN
  
   DECLARE @Var_char_1      char          
   DECLARE @Var_char_2      char               
   SET @Var_char_1          = CAST('a' AS char) 
   SET @Var_char_2          = CAST('B' AS char)
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_char_1, @Var_char_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#varchar             
AS
BEGIN
  
   DECLARE @Var_varchar_1   varchar(10)   
   DECLARE @Var_varchar_2   varchar(10)        
   SET @Var_varchar_1       = CAST('1234567890' AS varchar(10)) 
   SET @Var_varchar_2       = CAST('1234567891' AS varchar(10))
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_varchar_1, @Var_varchar_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#nchar               
AS
BEGIN
  
   DECLARE @Var_nchar_1     nchar         
   DECLARE @Var_nchar_2     nchar              
   SET @Var_nchar_1         = CAST(N'a' AS nchar) 
   SET @Var_nchar_2         = CAST(N'b' AS nchar)
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_nchar_1, @Var_nchar_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO


CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#nvarchar            
AS
BEGIN
  
   DECLARE @Var_nvarchar_1  nvarchar(10)  
   DECLARE @Var_nvarchar_2  nvarchar(10)       
   SET @Var_nvarchar_1      = CAST(N'1234567890' AS nvarchar(10)) 
   SET @Var_nvarchar_2      = CAST(N'1234567891' AS nvarchar(10))
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_nvarchar_1, @Var_nvarchar_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#binary              
AS
BEGIN
  
   DECLARE @Var_binary_1    binary(10)    
   DECLARE @Var_binary_2    binary(10)         
   SET @Var_binary_1        = CAST('1111' AS binary(10)) 
   SET @Var_binary_2        = CAST('11111' AS binary(10))
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_binary_1, @Var_binary_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertEqualsFail#sql_variant         
AS
BEGIN
  
   DECLARE @Var_sql_variant_1    sql_variant   
   DECLARE @Var_sql_variant_2    sql_variant        
   SET @Var_sql_variant_1        = CAST(1 AS sql_variant) 
   SET @Var_sql_variant_2        = CAST(2 AS sql_variant)
   EXEC TST.Assert.Equals 'Test Assert.Equals in suite AssertEqualsFail', @Var_sql_variant_1, @Var_sql_variant_2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

-- =======================================================================
-- END Suite AssertEqualsFail
-- =======================================================================

-- =======================================================================
-- START Suite AssertNotEqualsFail
-- Suite AssertNotEqualsFail will test failing Assert.NotEquals with each 
-- data type
-- =======================================================================

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#bigint
AS
BEGIN
  
   DECLARE @Var_bigint    bigint        
   SET @Var_bigint        = CAST(9223372036854775807 AS bigint) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', 9223372036854775807, @Var_bigint
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#numeric             

AS
BEGIN
  
   DECLARE @Var_numeric   numeric(38,15)
   SET @Var_numeric       = CAST(12345678901234567890123.456789012345678 AS numeric(38,15)) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', 12345678901234567890123.456789012345678, @Var_numeric
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#bit                 
AS
BEGIN
  
   DECLARE @Var_bit       bit           
   SET @Var_bit           = CAST(1 AS bit) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', 1, @Var_bit
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#smallint            
AS
BEGIN
  
   DECLARE @Var_smallint  smallint      
   SET @Var_smallint      = CAST(32767 AS smallint) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', 32767, @Var_smallint
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#decimal             
AS
BEGIN
  
   DECLARE @Var_decimal   decimal(38,15)
   SET @Var_decimal       = CAST(12345678901234567890123.456789012345678 AS decimal(38,15)) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', 12345678901234567890123.456789012345678, @Var_decimal
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#smallmoney          
AS
BEGIN
  
   DECLARE @Var_smallmoney  smallmoney    
   SET @Var_smallmoney      = CAST(-214748.3648  AS smallmoney) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', -214748.3648, @Var_smallmoney
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#int                 
AS
BEGIN
  
   DECLARE @Var_int       int           
   SET @Var_int           = CAST(-2147483648 AS int) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', -2147483648, @Var_int
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#tinyint             
AS
BEGIN
  
   DECLARE @Var_tinyint   tinyint       
   SET @Var_tinyint       = CAST(255 AS tinyint) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', 255, @Var_tinyint
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#money               
AS
BEGIN
  
   DECLARE @Var_money     money         
   SET @Var_money         = CAST(922337203685477.5807 AS money) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', 922337203685477.5807, @Var_money
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#datetime            
AS
BEGIN
  
   DECLARE @Var_datetime1 datetime      
   DECLARE @Var_datetime2 datetime      
   SET @Var_datetime1      = CAST('2001-01-01 23:59:59.199' AS datetime) 
   SET @Var_datetime2      = CAST('2001-01-01 23:59:59.199' AS datetime) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', @Var_datetime1, @Var_datetime2
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#char                
AS
BEGIN
  
   DECLARE @Var_char      char          
   SET @Var_char          = CAST('a' AS char) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', 'a', @Var_char
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#varchar             
AS
BEGIN
  
   DECLARE @Var_varchar   varchar(10)   
   SET @Var_varchar       = CAST('1234567890' AS varchar(10)) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', '1234567890', @Var_varchar
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#nchar               
AS
BEGIN
  
   DECLARE @Var_nchar     nchar         
   SET @Var_nchar         = CAST(N'a' AS nchar) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', N'a', @Var_nchar
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO


CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#nvarchar            
AS
BEGIN
  
   DECLARE @Var_nvarchar  nvarchar(10)  
   SET @Var_nvarchar      = CAST(N'1234567890' AS nvarchar(10)) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', N'1234567890', @Var_nvarchar
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#binary              
AS
BEGIN
  
   DECLARE @Var_binary    binary(10)    
   SET @Var_binary        = CAST('1111' AS binary(10)) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', 0x31313131000000000000, @Var_binary
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_AssertNotEqualsFail#sql_variant         
AS
BEGIN
  
   DECLARE @Var_sql_variant    sql_variant   
   SET @Var_sql_variant        = CAST(1 AS sql_variant) 
   EXEC TST.Assert.NotEquals 'Test Assert.NotEquals in suite AssertNotEqualsFail', 1, @Var_sql_variant
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

-- =======================================================================
-- END Suite AssertNotEqualsFail
-- =======================================================================

-- =======================================================================
-- START Suite AssertEqualsIncompatibleData
-- Suite AssertEqualsIncompatibleData will test Assert.Equals called 
-- with incompatible data types.
-- =======================================================================

CREATE PROCEDURE SQLTest_AssertEqualsIncompatibleData#bigint_float
AS
BEGIN
   DECLARE @Var_bigint  bigint
   DECLARE @Var_float   float
   SET @Var_bigint   = 10
   SET @Var_float    = 10
   
   EXEC TST.Assert.Equals 'Test Assert in SQLTest_AssertEqualsIncompatibleData#bigint_float', @Var_bigint, @Var_float

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE SQLTest_AssertEqualsIncompatibleData#numeric_real
AS
BEGIN
   DECLARE @Var_numeric    numeric(10,5)
   DECLARE @Var_real       real
   SET @Var_numeric  = 10
   SET @Var_real     = 10
   
   EXEC TST.Assert.Equals 'Test Assert in SQLTest_AssertEqualsIncompatibleData#numeric_real', @Var_numeric, @Var_real

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE SQLTest_AssertEqualsIncompatibleData#bit_datetime
AS
BEGIN
   DECLARE @Var_bit        bit 
   DECLARE @Var_datetime   datetime
   SET @Var_bit      = 1
   SET @Var_datetime = '2001-01-01'
   
   EXEC TST.Assert.Equals 'Test Assert in SQLTest_AssertEqualsIncompatibleData#bit_datetime', @Var_bit, @Var_datetime

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE SQLTest_AssertEqualsIncompatibleData#varchar_smallint
AS
BEGIN
   DECLARE @Var_varchar    varchar(10) 
   DECLARE @Var_smallint   smallint
   SET @Var_varchar  = '10'
   SET @Var_smallint = 10
   
   EXEC TST.Assert.Equals 'Test Assert in SQLTest_AssertEqualsIncompatibleData#varchar_smallint', @Var_varchar, @Var_smallint

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE SQLTest_AssertEqualsIncompatibleData#varchar_binary
AS
BEGIN
   DECLARE @Var_varchar    varchar(10)
   DECLARE @Var_binary     binary(10)
   SET @Var_varchar  = '10'
   SET @Var_binary   = 0x3131
   
   EXEC TST.Assert.Equals 'Test Assert in SQLTest_AssertEqualsIncompatibleData#varchar_binary', @Var_varchar, @Var_binary

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE SQLTest_AssertEqualsIncompatibleData#varchar_uniqueidentifier
AS
BEGIN
   DECLARE @Var_varchar             varchar(10)
   DECLARE @Var_uniqueidentifier    uniqueidentifier
   SET @Var_varchar           = 'CAC8EF33-D483-4f1f-9D64-B8EB3965D5A6'
   SET @Var_uniqueidentifier  = 'CAC8EF33-D483-4f1f-9D64-B8EB3965D5A6'
   
   EXEC TST.Assert.Equals 'Test Assert in SQLTest_AssertEqualsIncompatibleData#varchar_uniqueidentifier', @Var_varchar, @Var_uniqueidentifier

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

-- =======================================================================
-- END Suite AssertEqualsIncompatibleData
-- =======================================================================

-- =======================================================================
-- START Suite AssertEqualsApproximateNumeric
-- =======================================================================

CREATE PROCEDURE SQLTest_AssertEqualsApproximateNumeric#float
AS
BEGIN
   DECLARE @Var_float float
   SET @Var_float = 1
   
   EXEC TST.Assert.Equals 'Test Assert in SQLTest_AssertEqualsApproximateNumeric#_float', @Var_float, @Var_float

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE SQLTest_AssertEqualsApproximateNumeric#real
AS
BEGIN
   DECLARE @Var_real real
   SET @Var_real = 1
   
   EXEC TST.Assert.Equals 'Test Assert in SQLTest_AssertEqualsApproximateNumeric#_real', @Var_real, @Var_real

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

-- =======================================================================
-- END Suite AssertEqualsApproximateNumeric
-- =======================================================================

-- =======================================================================
-- START Suite AssertNotEqualsIncompatibleData
-- Suite AssertNotEqualsIncompatibleData will test Assert.NotEquals called 
-- with incompatible data types.
-- =======================================================================

CREATE PROCEDURE SQLTest_AssertNotEqualsIncompatibleData#bigint_float
AS
BEGIN
   DECLARE @Var_bigint  bigint
   DECLARE @Var_float   float
   SET @Var_bigint   = 10
   SET @Var_float    = 11
   
   EXEC TST.Assert.NotEquals 'Test Assert in SQLTest_AssertNotEqualsIncompatibleData#bigint_float', @Var_bigint, @Var_float

   EXEC TST.Assert.LogInfo              'This log should not be executed'
   EXEC TST.Assert.NotEquals  'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE SQLTest_AssertNotEqualsIncompatibleData#numeric_real
AS
BEGIN
   DECLARE @Var_numeric    numeric(10,5)
   DECLARE @Var_real       real
   SET @Var_numeric  = 10
   SET @Var_real     = 11
   
   EXEC TST.Assert.NotEquals 'Test Assert in SQLTest_AssertNotEqualsIncompatibleData#numeric_real', @Var_numeric, @Var_real

   EXEC TST.Assert.LogInfo              'This log should not be executed'
   EXEC TST.Assert.NotEquals  'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE SQLTest_AssertNotEqualsIncompatibleData#bit_datetime
AS
BEGIN
   DECLARE @Var_bit        bit 
   DECLARE @Var_datetime   datetime
   SET @Var_bit      = 1
   SET @Var_datetime = '2001-01-01'
   
   EXEC TST.Assert.NotEquals 'Test Assert in SQLTest_AssertNotEqualsIncompatibleData#bit_datetime', @Var_bit, @Var_datetime

   EXEC TST.Assert.LogInfo              'This log should not be executed'
   EXEC TST.Assert.NotEquals  'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE SQLTest_AssertNotEqualsIncompatibleData#varchar_smallint
AS
BEGIN
   DECLARE @Var_varchar    varchar(10) 
   DECLARE @Var_smallint   smallint
   SET @Var_varchar  = '10'
   SET @Var_smallint = 11
   
   EXEC TST.Assert.NotEquals 'Test Assert in SQLTest_AssertNotEqualsIncompatibleData#varchar_smallint', @Var_varchar, @Var_smallint

   EXEC TST.Assert.LogInfo              'This log should not be executed'
   EXEC TST.Assert.NotEquals  'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE SQLTest_AssertNotEqualsIncompatibleData#varchar_binary
AS
BEGIN
   DECLARE @Var_varchar    varchar(10)
   DECLARE @Var_binary     binary(10)
   SET @Var_varchar  = '10'
   SET @Var_binary   = 0x3131
   
   EXEC TST.Assert.NotEquals 'Test Assert in SQLTest_AssertNotEqualsIncompatibleData#varchar_binary', @Var_varchar, @Var_binary

   EXEC TST.Assert.LogInfo              'This log should not be executed'
   EXEC TST.Assert.NotEquals  'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE SQLTest_AssertNotEqualsIncompatibleData#varchar_uniqueidentifier
AS
BEGIN
   DECLARE @Var_varchar             varchar(10)
   DECLARE @Var_uniqueidentifier    uniqueidentifier
   SET @Var_varchar           = 'CAC8EF33-D483-4f1f-9D64-B8EB3965D500'
   SET @Var_uniqueidentifier  = 'CAC8EF33-D483-4f1f-9D64-B8EB3965D5A6'
   
   EXEC TST.Assert.NotEquals 'Test Assert in SQLTest_AssertNotEqualsIncompatibleData#varchar_uniqueidentifier', @Var_varchar, @Var_uniqueidentifier

   EXEC TST.Assert.LogInfo              'This log should not be executed'
   EXEC TST.Assert.NotEquals  'This assert should not be executed', 1, 1
END
GO

-- =======================================================================
-- END Suite AssertNotEqualsIncompatibleData
-- =======================================================================


-- =======================================================================
-- START Suite AssertNotEqualsApproximateNumeric
-- =======================================================================

CREATE PROCEDURE SQLTest_AssertNotEqualsApproximateNumeric#float
AS
BEGIN
   DECLARE @Var_float float
   SET @Var_float = 1
   
   EXEC TST.Assert.NotEquals 'Test Assert in SQLTest_AssertNotEqualsApproximateNumeric#_float', @Var_float, @Var_float

   EXEC TST.Assert.LogInfo              'This log should not be executed'
   EXEC TST.Assert.NotEquals  'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE SQLTest_AssertNotEqualsApproximateNumeric#real
AS
BEGIN
   DECLARE @Var_real real
   SET @Var_real = 1
   
   EXEC TST.Assert.NotEquals 'Test Assert in SQLTest_AssertNotEqualsApproximateNumeric#_real', @Var_real, @Var_real

   EXEC TST.Assert.LogInfo              'This log should not be executed'
   EXEC TST.Assert.NotEquals  'This assert should not be executed', 1, 1
END
GO

-- =======================================================================
-- END Suite AssertNotEqualsApproximateNumeric
-- =======================================================================

CREATE PROCEDURE dbo.SQLTest_Test_RunTimeError
AS
BEGIN

   DECLARE @TempVar int
   SET @TempVar = ISNULL(@TempVar, 'null');  -- This will generate a run-time error
   
   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_Test_NoAssert
AS
BEGIN
   EXEC TST.Assert.LogInfo 'This is SQLTest_Test_NoAssert'
END
GO

USE tempdb
GO
