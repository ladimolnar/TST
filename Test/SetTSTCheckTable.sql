--===================================================================
-- FILE: SetTSTCheckTable.sql
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
-- Creates the TSTCheckTable Database. If already exists then drops it first.
-- =======================================================================
IF EXISTS (SELECT [name] FROM sys.databases WHERE [name] = 'TSTCheckTable')
BEGIN
   DROP DATABASE TSTCheckTable
END

CREATE DATABASE TSTCheckTable
GO

USE TSTCheckTable
GO

-- =======================================================================
-- The TST test stored procedures
-- =======================================================================

CREATE PROCEDURE dbo.SQLTest_TablesDifferentSizes
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ActualResult   (Test int)
   CREATE TABLE #ExpectedResult (Test int)
   
   INSERT INTO #ExpectedResult VALUES (1)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesDifferentSizes'

END
GO


CREATE PROCEDURE dbo.SQLTest_TablesDifferentSchemaCols1
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 int)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 int, C2 int)
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesDifferentSchemaCols1'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1

END
GO


CREATE PROCEDURE dbo.SQLTest_TablesDifferentSchemaCols2
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 int, C2 int)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 int)
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesDifferentSchemaCols2'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesDifferentSchemaCols3
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 int)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C2 int)
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesDifferentSchemaCols3'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1

END
GO


CREATE PROCEDURE dbo.SQLTest_TablesDifferentSchemaColTypes1
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 int)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 varchar)
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesDifferentSchemaColTypes1'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO


CREATE PROCEDURE dbo.SQLTest_TablesDifferentSchemaColTypes2
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 varchar(10) )
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 varchar(11) )
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesDifferentSchemaColTypes2'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesDifferentSchemaCollation
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 varchar(10) COLLATE SQL_Latin1_General_CP1_CS_AS)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 varchar(10) COLLATE SQL_Latin1_General_Cp1_CI_AS)
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesDifferentSchemaCollation'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesColTypeText
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 text)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 text)
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesColTypeText'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesColTypeNText
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 ntext)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 ntext)
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesColTypeNText'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesColTypeImage
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 image)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 image)
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesColTypeImage'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesColTypeTimestamp
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 Timestamp)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 Timestamp)
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesColTypeTimestamp'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesNoPrimaryKey
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID int, C1 varchar)
   CREATE TABLE #ActualResult    (ID int, C1 varchar)
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesNoPrimaryKey'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesDifferentPrimaryKey
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY, ID2 int, C1 varchar)
   CREATE TABLE #ActualResult    (ID1 int, ID2 int PRIMARY KEY, C1 varchar)
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesDifferentPrimaryKey'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesPrimaryKeyColsDifferentOrder
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int NOT NULL, ID2 int NOT NULL, C1 int, C2 varchar(10), C3 bit)
   ALTER TABLE  #ExpectedResult ADD CONSTRAINT PK_ExpectedResult PRIMARY KEY CLUSTERED (ID1, ID2)

   CREATE TABLE #ActualResult  (ID1 int NOT NULL, ID2 int NOT NULL, C1 int, C2 varchar(10), C3 bit)
   ALTER TABLE  #ActualResult ADD CONSTRAINT PK_ActualResult PRIMARY KEY CLUSTERED (ID2, ID1)
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesPrimaryKeyColsDifferentOrder'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO


CREATE PROCEDURE dbo.SQLTest_TablesCompareColumnNamesWithBlanks
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  ([ID 1] int PRIMARY KEY NOT NULL, [First Column] int, [ Second Column ] varchar(10), [ ThirdColumn] int, [ForthColumn ] bit)
   CREATE TABLE #ActualResult    ([ID 1] int PRIMARY KEY NOT NULL, [First Column] int, [ Second Column ] varchar(10), [ ThirdColumn] int, [ForthColumn ] bit)

   INSERT INTO #ExpectedResult VALUES (1, 1000, 'abc', 10, 0)
   INSERT INTO #ExpectedResult VALUES (2, 2000, 'XYZ', 20, 1)
   
   INSERT INTO #ActualResult   VALUES (1, 1000, 'abc', 10, 0)
   INSERT INTO #ActualResult   VALUES (2, 2000, 'XYZ', 20, 1)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareColumnNamesWithBlanks'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareColumnNamesWithBlanksAndIgnoredColumns
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  ([ID 1] int PRIMARY KEY NOT NULL, [First Column] int, [ Second Column ] varchar(10), [ ThirdColumn] int, [ForthColumn ] bit)
   CREATE TABLE #ActualResult    ([ID 1] int PRIMARY KEY NOT NULL, [First Column] int, [ Second Column ] varchar(10), [ ThirdColumn] int, [ForthColumn ] bit)

   INSERT INTO #ExpectedResult VALUES (1, 1000, 'abc+', 10, 0)
   INSERT INTO #ExpectedResult VALUES (2, 2000, 'XYZ+', 20, 1)
   
   INSERT INTO #ActualResult   VALUES (1, 1000, 'abc-', 11, 2)
   INSERT INTO #ActualResult   VALUES (2, 2000, 'XYZ-', 21, 3)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareColumnNamesWithBlanksAndIgnoredColumns', ' Second Column ; ThirdColumn;ForthColumn '

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameDataPK1
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, C1 int, C2 varchar(10), C3 bit)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, C1 int, C2 varchar(10), C3 bit)

   INSERT INTO #ExpectedResult VALUES (1, 1000, 'abc', 1)
   INSERT INTO #ExpectedResult VALUES (2, 2000, 'ĂÎÂȘȚăîâșț', 0)
   
   INSERT INTO #ActualResult VALUES (1, 1000, 'abc', 1)
   INSERT INTO #ActualResult VALUES (2, 2000, 'ĂÎÂȘȚăîâșț', 0)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameDataPK1 ĂÎÂȘȚăîâșț'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameDataNullContext
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, C1 int, C2 varchar(10), C3 bit)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, C1 int, C2 varchar(10), C3 bit)

   INSERT INTO #ExpectedResult VALUES (1, 1000, 'abc', 1)
   INSERT INTO #ExpectedResult VALUES (2, 2000, 'ĂÎÂȘȚăîâșț', 0)
   
   INSERT INTO #ActualResult VALUES (1, 1000, 'abc', 1)
   INSERT INTO #ActualResult VALUES (2, 2000, 'ĂÎÂȘȚăîâșț', 0)

   EXEC TST.Assert.TableEquals NULL

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameDataPK3
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int NOT NULL, ID2 int NOT NULL, ID3 int NOT NULL, C1 int, C2 varchar(10), C3 bit)
   ALTER TABLE  #ExpectedResult ADD CONSTRAINT PK_ExpectedResult PRIMARY KEY CLUSTERED (ID1, ID2, ID3)

   CREATE TABLE #ActualResult    (ID1 int NOT NULL, ID2 int NOT NULL, ID3 int NOT NULL, C1 int, C2 varchar(10), C3 bit)
   ALTER TABLE  #ActualResult   ADD CONSTRAINT PK_ActualResult   PRIMARY KEY CLUSTERED (ID1, ID2, ID3)

   INSERT INTO #ExpectedResult VALUES (0, 0, 0, 1000, 'abc', 1)
   INSERT INTO #ExpectedResult VALUES (0, 0, 1, 1001, 'abcc', 0)
   INSERT INTO #ExpectedResult VALUES (0, 1, 0, 1002, 'abccc', 1)
   INSERT INTO #ExpectedResult VALUES (0, 1, 1, 1003, 'abcccc', 0)
   INSERT INTO #ExpectedResult VALUES (1, 0, 0, 1004, 'abccccc', 1)
   INSERT INTO #ExpectedResult VALUES (1, 0, 1, 1005, 'abcccccc', 0)
   INSERT INTO #ExpectedResult VALUES (1, 1, 0, 1006, 'abccccccc', 1)
   INSERT INTO #ExpectedResult VALUES (1, 1, 1, 1007, 'ĂÎÂȘȚăîâșț', 0)
   
   INSERT INTO #ActualResult VALUES (0, 0, 0, 1000, 'abc', 1)
   INSERT INTO #ActualResult VALUES (0, 0, 1, 1001, 'abcc', 0)
   INSERT INTO #ActualResult VALUES (0, 1, 0, 1002, 'abccc', 1)
   INSERT INTO #ActualResult VALUES (0, 1, 1, 1003, 'abcccc', 0)
   INSERT INTO #ActualResult VALUES (1, 0, 0, 1004, 'abccccc', 1)
   INSERT INTO #ActualResult VALUES (1, 0, 1, 1005, 'abcccccc', 0)
   INSERT INTO #ActualResult VALUES (1, 1, 0, 1006, 'abccccccc', 1)
   INSERT INTO #ActualResult VALUES (1, 1, 1, 1007, 'ĂÎÂȘȚăîâșț', 0)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameDataPK3'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameDataReversedColumns
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, C1 int, C2 varchar(10), C3 bit)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, C3 bit, C2 varchar(10), C1 int)

   INSERT INTO #ExpectedResult VALUES (1, 1000, 'abc', 1)
   INSERT INTO #ExpectedResult VALUES (2, 2000, 'ĂÎÂȘȚăîâșț', 0)
   
   INSERT INTO #ActualResult VALUES (1, 1, 'abc', 1000)
   INSERT INTO #ActualResult VALUES (2, 0, 'ĂÎÂȘȚăîâșț', 2000)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameDataReversedColumns'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentDataPK1_Case1
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, C1 int, C2 varchar(10), C3 bit)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, C1 int, C2 varchar(10), C3 bit)

   INSERT INTO #ExpectedResult VALUES (1, 1000, 'abc', 1)
   INSERT INTO #ExpectedResult VALUES (2, 2000, 'ĂÎÂȘȚăîâșt', 0)
   
   INSERT INTO #ActualResult VALUES (1, 1000, 'abc', 1)
   INSERT INTO #ActualResult VALUES (2, 2000, 'ĂÎÂȘȚăîâșț', 0)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentDataPK1_Case1'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO


CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentDataPK1_Case2
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, C1 int, C2 varchar(10), C3 bit)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, C1 int, C2 varchar(10), C3 bit)

   INSERT INTO #ExpectedResult VALUES (1, 1000, 'abc', 1)
   INSERT INTO #ExpectedResult VALUES (2, 2000, 'def', 0)
   
   INSERT INTO #ActualResult VALUES (2, 1000, 'abc', 1)
   INSERT INTO #ActualResult VALUES (1, 2000, 'def', 0)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentDataPK1_Case2'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO


CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentDataPK1_Case3
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, C1 int, C2 varchar(10), C3 bit)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, C1 int, C2 varchar(10), C3 bit)

   INSERT INTO #ExpectedResult VALUES (1, 1000, 'abc', 1)
   INSERT INTO #ExpectedResult VALUES (2, 2000, 'def', 0)
   
   INSERT INTO #ActualResult VALUES (1, 1000, 'abc', 1)
   INSERT INTO #ActualResult VALUES (3, 2000, 'def', 0)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentDataPK1_Case3'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentDataPK1_Case4
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, C1 int, C2 varchar(10), C3 bit)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, C1 int, C2 varchar(10), C3 bit)

   INSERT INTO #ExpectedResult VALUES ( 1, 1000, 'abc', 1)
   INSERT INTO #ExpectedResult VALUES (10, NULL,  NULL, NULL)
   
   INSERT INTO #ActualResult   VALUES ( 1, 1000, 'abc', 1)
   INSERT INTO #ActualResult   VALUES (11, NULL,  NULL, NULL)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentDataPK1_Case4'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentDataPK3_Case1
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int NOT NULL, ID2 int NOT NULL, ID3 int NOT NULL, C1 int, C2 varchar(10), C3 bit)
   ALTER TABLE  #ExpectedResult ADD CONSTRAINT PK_ExpectedResult PRIMARY KEY CLUSTERED (ID1, ID2, ID3)

   CREATE TABLE #ActualResult    (ID1 int NOT NULL, ID2 int NOT NULL, ID3 int NOT NULL, C1 int, C2 varchar(10), C3 bit)
   ALTER TABLE  #ActualResult   ADD CONSTRAINT PK_ActualResult   PRIMARY KEY CLUSTERED (ID1, ID2, ID3)

   INSERT INTO #ExpectedResult VALUES (0, 0, 0, 1000, 'abc', 1)
   INSERT INTO #ExpectedResult VALUES (0, 0, 1, 2000, 'xyz', 0)
   
   INSERT INTO #ActualResult   VALUES (0, 0, 0, 1234, 'abc', 1)
   INSERT INTO #ActualResult   VALUES (0, 0, 1, 2000, 'xyz', 0)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentDataPK3_Case1'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentDataPK3_Case2
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int NOT NULL, ID2 int NOT NULL, ID3 int NOT NULL, C1 int, C2 varchar(10), C3 bit)
   ALTER TABLE  #ExpectedResult ADD CONSTRAINT PK_ExpectedResult PRIMARY KEY CLUSTERED (ID1, ID2, ID3)

   CREATE TABLE #ActualResult    (ID1 int NOT NULL, ID2 int NOT NULL, ID3 int NOT NULL, C1 int, C2 varchar(10), C3 bit)
   ALTER TABLE  #ActualResult   ADD CONSTRAINT PK_ActualResult   PRIMARY KEY CLUSTERED (ID1, ID2, ID3)

   INSERT INTO #ExpectedResult VALUES (0, 0, 0, 1000, 'abc', 1)
   INSERT INTO #ExpectedResult VALUES (0, 0, 1, 2000, 'xyz', 0)
   
   INSERT INTO #ActualResult   VALUES (0, 0, 1, 1000, 'abc', 1)
   INSERT INTO #ActualResult   VALUES (0, 0, 0, 2000, 'xyz', 0)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentDataPK3_Case2'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO


CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentDataPK3_Case3
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int NOT NULL, ID2 int NOT NULL, ID3 int NOT NULL, C1 int, C2 varchar(10), C3 bit)
   ALTER TABLE  #ExpectedResult ADD CONSTRAINT PK_ExpectedResult PRIMARY KEY CLUSTERED (ID1, ID2, ID3)

   CREATE TABLE #ActualResult    (ID1 int NOT NULL, ID2 int NOT NULL, ID3 int NOT NULL, C1 int, C2 varchar(10), C3 bit)
   ALTER TABLE  #ActualResult   ADD CONSTRAINT PK_ActualResult   PRIMARY KEY CLUSTERED (ID1, ID2, ID3)

   INSERT INTO #ExpectedResult VALUES (0, 0, 0, 1000, 'abc', 1)
   INSERT INTO #ExpectedResult VALUES (0, 0, 1, 2000, 'xyz', 0)
   
   INSERT INTO #ActualResult   VALUES (0, 0, 0, 1000, 'abc', 1)
   INSERT INTO #ActualResult   VALUES (0, 0, 3, 2000, 'xyz', 0)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentDataPK3_Case3'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentDataPK3_Case4
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int NOT NULL, ID2 int NOT NULL, ID3 int NOT NULL, C1 int, C2 varchar(10), C3 bit)
   ALTER TABLE  #ExpectedResult ADD CONSTRAINT PK_ExpectedResult PRIMARY KEY CLUSTERED (ID1, ID2, ID3)

   CREATE TABLE #ActualResult    (ID1 int NOT NULL, ID2 int NOT NULL, ID3 int NOT NULL, C1 int, C2 varchar(10), C3 bit)
   ALTER TABLE  #ActualResult   ADD CONSTRAINT PK_ActualResult   PRIMARY KEY CLUSTERED (ID1, ID2, ID3)

   INSERT INTO #ExpectedResult VALUES (0, 0,  0, 1000, 'abc', 1)
   INSERT INTO #ExpectedResult VALUES (0, 0, 10, NULL,  NULL, NULL)
   
   INSERT INTO #ActualResult   VALUES (0, 0,  0, 1000, 'abc', 1)
   INSERT INTO #ActualResult   VALUES (0, 0, 11, NULL,  NULL, NULL)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentDataPK3_Case4'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameDataOneCollation
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (
      ID1 int PRIMARY KEY NOT NULL, 
      C1 int, 
      C2 varchar(10) COLLATE SQL_Latin1_General_Cp437_CI_AS, 
      C3 varchar(10) COLLATE SQL_Latin1_General_Cp437_CI_AS)
      
   CREATE TABLE #ActualResult    (
      ID1 int PRIMARY KEY NOT NULL, 
      C1 int, 
      C2 varchar(10) COLLATE SQL_Latin1_General_Cp437_CI_AS, 
      C3 varchar(10) COLLATE SQL_Latin1_General_Cp437_CI_AS)

   INSERT INTO #ExpectedResult VALUES (1, 1000, 'abc', 'def')
   INSERT INTO #ExpectedResult VALUES (2, 1001, 'xyz', 'klm')
   INSERT INTO #ExpectedResult VALUES (3, NULL,  NULL, NULL)
   
   INSERT INTO #ActualResult   VALUES (1, 1000, 'ABC', 'DEF')
   INSERT INTO #ActualResult   VALUES (2, 1001, 'XYZ', 'KLM')
   INSERT INTO #ActualResult   VALUES (3, NULL,  NULL, NULL)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameDataOneCollation'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameDataVariousCollation
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (
      ID1 int PRIMARY KEY NOT NULL, 
      C1 int, 
      C2 varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS, 
      C3 varchar(10) COLLATE SQL_Latin1_General_Cp437_CI_AS)
      
   CREATE TABLE #ActualResult    (
      ID1 int PRIMARY KEY NOT NULL, 
      C1 int, 
      C2 varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS, 
      C3 varchar(10) COLLATE SQL_Latin1_General_Cp437_CI_AS)

   INSERT INTO #ExpectedResult VALUES (1, 1000, 'abc', 'def')
   INSERT INTO #ExpectedResult VALUES (2, 1001, 'xyz', 'klm')
   INSERT INTO #ExpectedResult VALUES (3, NULL,  NULL, NULL)
   
   INSERT INTO #ActualResult   VALUES (1, 1000, 'ABC', 'DEF')
   INSERT INTO #ActualResult   VALUES (2, 1001, 'XYZ', 'KLM')
   INSERT INTO #ActualResult   VALUES (3, NULL,  NULL, NULL)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameDataVariousCollation'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentDataVariousCollation
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (
      ID1 int PRIMARY KEY NOT NULL, 
      C1 int, 
      C2 varchar(10) COLLATE SQL_Latin1_General_CP1_CS_AS, 
      C3 varchar(10) COLLATE SQL_Latin1_General_Cp437_CS_AS)
      
   CREATE TABLE #ActualResult    (
      ID1 int PRIMARY KEY NOT NULL, 
      C1 int, 
      C2 varchar(10) COLLATE SQL_Latin1_General_CP1_CS_AS, 
      C3 varchar(10) COLLATE SQL_Latin1_General_Cp437_CS_AS)

   INSERT INTO #ExpectedResult VALUES (1, 1000, 'abc', 'def')
   INSERT INTO #ExpectedResult VALUES (2, 1001, 'xyz', 'klm')
   INSERT INTO #ExpectedResult VALUES (3, NULL,  NULL, NULL)
   
   INSERT INTO #ActualResult   VALUES (1, 1000, 'ABC', 'DEF')
   INSERT INTO #ActualResult   VALUES (2, 1001, 'XYZ', 'KLM')
   INSERT INTO #ActualResult   VALUES (3, NULL,  NULL, NULL)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentDataVariousCollation'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO


CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_BigInt
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 BigInt)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 BigInt)

   INSERT INTO #ExpectedResult VALUES (1,                 NULL)
   INSERT INTO #ExpectedResult VALUES (2,                    0)
   INSERT INTO #ExpectedResult VALUES (3,  9223372036854775807)
   INSERT INTO #ExpectedResult VALUES (4, -9223372036854775808)

   INSERT INTO #ActualResult   VALUES (1,                 NULL)
   INSERT INTO #ActualResult   VALUES (2,                    0)
   INSERT INTO #ActualResult   VALUES (3,  9223372036854775807)
   INSERT INTO #ActualResult   VALUES (4, -9223372036854775808)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_BigInt'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_BigInt
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 BigInt)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 BigInt)

   INSERT INTO #ExpectedResult VALUES (1, -9223372036854775808)
   INSERT INTO #ActualResult   VALUES (1,  9223372036854775807)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_BigInt'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_Int
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Int)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Int)
   
   INSERT INTO #ExpectedResult VALUES (1,        NULL)
   INSERT INTO #ExpectedResult VALUES (2,           0)
   INSERT INTO #ExpectedResult VALUES (3,  2147483647)
   INSERT INTO #ExpectedResult VALUES (4, -2147483648)

   INSERT INTO #ActualResult   VALUES (1,        NULL)
   INSERT INTO #ActualResult   VALUES (2,           0)
   INSERT INTO #ActualResult   VALUES (3,  2147483647)
   INSERT INTO #ActualResult   VALUES (4, -2147483648)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_Int'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_Int
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Int)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Int)
   
   INSERT INTO #ExpectedResult VALUES (1, -2147483648)
   INSERT INTO #ActualResult   VALUES (1,  2147483647)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_Int'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_SmallInt
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 SmallInt)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 SmallInt)

   INSERT INTO #ExpectedResult VALUES (1,   NULL)
   INSERT INTO #ExpectedResult VALUES (2,      0)
   INSERT INTO #ExpectedResult VALUES (3,  32767)
   INSERT INTO #ExpectedResult VALUES (4, -32768)

   INSERT INTO #ActualResult   VALUES (1,   NULL)
   INSERT INTO #ActualResult   VALUES (2,      0)
   INSERT INTO #ActualResult   VALUES (3,  32767)
   INSERT INTO #ActualResult   VALUES (4, -32768)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_SmallInt'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_SmallInt
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 SmallInt)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 SmallInt)
   
   INSERT INTO #ExpectedResult VALUES (1, -32768)
   INSERT INTO #ActualResult   VALUES (1,  32767)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_SmallInt'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_TinyInt
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 TinyInt)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 TinyInt)

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,     0)
   INSERT INTO #ExpectedResult VALUES (3,   244)
   INSERT INTO #ExpectedResult VALUES (4,   255)

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,     0)
   INSERT INTO #ActualResult   VALUES (3,   244)
   INSERT INTO #ActualResult   VALUES (4,   255)
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_TinyInt'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_TinyInt
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 TinyInt)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 TinyInt)
   
   INSERT INTO #ExpectedResult VALUES (1, 254)
   INSERT INTO #ActualResult   VALUES (1, 255)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_TinyInt'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_Money
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Money)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Money)

   INSERT INTO #ExpectedResult VALUES (1,                  NULL)
   INSERT INTO #ExpectedResult VALUES (2,                     0)
   INSERT INTO #ExpectedResult VALUES (3,  922337203685477.5807)
   INSERT INTO #ExpectedResult VALUES (4, -922337203685477.5808)

   INSERT INTO #ActualResult   VALUES (1,                  NULL)
   INSERT INTO #ActualResult   VALUES (2,                     0)
   INSERT INTO #ActualResult   VALUES (3,  922337203685477.5807)
   INSERT INTO #ActualResult   VALUES (4, -922337203685477.5808)
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_Money'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_Money
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Money)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Money)
   
   INSERT INTO #ExpectedResult VALUES (1, -922337203685477.5808)
   INSERT INTO #ActualResult   VALUES (1,  922337203685477.5807)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_Money'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_SmallMoney
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 SmallMoney)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 SmallMoney)

   INSERT INTO #ExpectedResult VALUES (1,         NULL)
   INSERT INTO #ExpectedResult VALUES (2,            0)
   INSERT INTO #ExpectedResult VALUES (3,  214748.3647)
   INSERT INTO #ExpectedResult VALUES (4, -214748.3648)

   INSERT INTO #ActualResult   VALUES (1,         NULL)
   INSERT INTO #ActualResult   VALUES (2,            0)
   INSERT INTO #ActualResult   VALUES (3,  214748.3647)
   INSERT INTO #ActualResult   VALUES (4, -214748.3648)
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_SmallMoney'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_SmallMoney
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 SmallMoney)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 SmallMoney)
   
   INSERT INTO #ExpectedResult VALUES (1, -214748.3648)
   INSERT INTO #ActualResult   VALUES (1,  214748.3647)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_SmallMoney'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_Bit
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Bit)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Bit)

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,     0)
   INSERT INTO #ExpectedResult VALUES (3,     1)

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,     0)
   INSERT INTO #ActualResult   VALUES (3,     1)
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_Bit'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_Bit
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Bit)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Bit)
   
   INSERT INTO #ExpectedResult VALUES (1, 0)
   INSERT INTO #ActualResult   VALUES (1, 1)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_Bit'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_Decimal
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Decimal(38,10))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Decimal(38,10))

   INSERT INTO #ExpectedResult VALUES (1,                                     NULL)
   INSERT INTO #ExpectedResult VALUES (2,                                        0)
   INSERT INTO #ExpectedResult VALUES (3,                                        1)
   INSERT INTO #ExpectedResult VALUES (4,                         12345.0123456789)
   INSERT INTO #ExpectedResult VALUES (5,  2345678901234567890123456789.0123456789)
   INSERT INTO #ExpectedResult VALUES (6, -2345678901234567890123456789.0123456789)

   INSERT INTO #ActualResult   VALUES (1,                                     NULL)
   INSERT INTO #ActualResult   VALUES (2,                                        0)
   INSERT INTO #ActualResult   VALUES (3,                                        1)
   INSERT INTO #ActualResult   VALUES (4,                         12345.0123456789)
   INSERT INTO #ActualResult   VALUES (5,  2345678901234567890123456789.0123456789)
   INSERT INTO #ActualResult   VALUES (6, -2345678901234567890123456789.0123456789)
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_Decimal'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_Decimal
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Decimal(38,10))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Decimal(38,10))
   
   INSERT INTO #ExpectedResult VALUES (1, 2345678901234567890123456789.0123456788)
   INSERT INTO #ActualResult   VALUES (1, 2345678901234567890123456789.0123456789)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_Decimal'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_Numeric
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Numeric(38,20))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Numeric(38,20))

   INSERT INTO #ExpectedResult VALUES (1,                                     NULL)
   INSERT INTO #ExpectedResult VALUES (2,                                        0)
   INSERT INTO #ExpectedResult VALUES (3,                                        1)
   INSERT INTO #ExpectedResult VALUES (4,               12345.01234567890123456789)
   INSERT INTO #ExpectedResult VALUES (5,  234567890123456789.01234567890123456789)
   INSERT INTO #ExpectedResult VALUES (6, -234567890123456789.01234567890123456789)

   INSERT INTO #ActualResult   VALUES (1,                                     NULL)
   INSERT INTO #ActualResult   VALUES (2,                                        0)
   INSERT INTO #ActualResult   VALUES (3,                                        1)
   INSERT INTO #ActualResult   VALUES (4,               12345.01234567890123456789)
   INSERT INTO #ActualResult   VALUES (5,  234567890123456789.01234567890123456789)
   INSERT INTO #ActualResult   VALUES (6, -234567890123456789.01234567890123456789)
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_Numeric'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_Numeric
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Numeric(38,20))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Numeric(38,20))
   
   INSERT INTO #ExpectedResult VALUES (1, 234567890123456789.01234567890123456788)
   INSERT INTO #ActualResult   VALUES (1, 234567890123456789.01234567890123456789)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_Numeric'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_Float
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Float(53))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Float(53))

   INSERT INTO #ExpectedResult VALUES (1,               NULL)
   INSERT INTO #ExpectedResult VALUES (2,                  0)
   INSERT INTO #ExpectedResult VALUES (3,                  1)
   INSERT INTO #ExpectedResult VALUES (4,   1234567890123456)
   INSERT INTO #ExpectedResult VALUES (5,  123456789012345.6)
   INSERT INTO #ExpectedResult VALUES (6,  1.234567890123456)
   INSERT INTO #ExpectedResult VALUES (7, -1.234567890123456)

   INSERT INTO #ActualResult   VALUES (1,               NULL)
   INSERT INTO #ActualResult   VALUES (2,                  0)
   INSERT INTO #ActualResult   VALUES (3,                  1)
   INSERT INTO #ActualResult   VALUES (4,   1234567890123456)
   INSERT INTO #ActualResult   VALUES (5,  123456789012345.6)
   INSERT INTO #ActualResult   VALUES (6,  1.234567890123456)
   INSERT INTO #ActualResult   VALUES (7, -1.234567890123456)
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_Float'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_Float
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Float(53))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Float(53))
   
   INSERT INTO #ExpectedResult VALUES (1, 1.234567890123457)
   INSERT INTO #ActualResult   VALUES (1, 1.234567890123456)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_Float'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_Real
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Real)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Real)

   INSERT INTO #ExpectedResult VALUES (1,         NULL)
   INSERT INTO #ExpectedResult VALUES (2,            0)
   INSERT INTO #ExpectedResult VALUES (3,            1)
   INSERT INTO #ExpectedResult VALUES (4,     12345678)
   INSERT INTO #ExpectedResult VALUES (5,   1.23456789)

   INSERT INTO #ActualResult   VALUES (1,         NULL)
   INSERT INTO #ActualResult   VALUES (2,            0)
   INSERT INTO #ActualResult   VALUES (3,            1)
   INSERT INTO #ActualResult   VALUES (4,     12345678)
   INSERT INTO #ActualResult   VALUES (5,   1.23456789)
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_Real'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_Real
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Real)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Real)
   
   INSERT INTO #ExpectedResult VALUES (1, 1.23456789)
   INSERT INTO #ActualResult   VALUES (1, 1.23456781)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_Real'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_DateTime
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 DateTime)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 DateTime)

   INSERT INTO #ExpectedResult VALUES (1,                        NULL)
   INSERT INTO #ExpectedResult VALUES (2,   '1753-01-01 00:00:00.000')
   INSERT INTO #ExpectedResult VALUES (3,   '1900-01-01 00:00:00.000')
   INSERT INTO #ExpectedResult VALUES (4,   '2000-01-01 23:59:59.000')
   INSERT INTO #ExpectedResult VALUES (5,   '2000-01-01 23:59:59.999')

   INSERT INTO #ActualResult   VALUES (1,                        NULL)
   INSERT INTO #ActualResult   VALUES (2,   '1753-01-01 00:00:00.000')
   INSERT INTO #ActualResult   VALUES (3,   '1900-01-01 00:00:00.000')
   INSERT INTO #ActualResult   VALUES (4,   '2000-01-01 23:59:59.000')
   INSERT INTO #ActualResult   VALUES (5,   '2000-01-01 23:59:59.999')
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_DateTime'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_DateTime
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 DateTime)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 DateTime)
   
   INSERT INTO #ExpectedResult VALUES (1, '2000-01-01 23:59:59.010')
   INSERT INTO #ActualResult   VALUES (1, '2000-01-01 23:59:59.000')

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_DateTime'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_SmallDateTime
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 SmallDateTime)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 SmallDateTime)

   INSERT INTO #ExpectedResult VALUES (1,                 NULL)
   INSERT INTO #ExpectedResult VALUES (2,   '1900-01-01 00:00')
   INSERT INTO #ExpectedResult VALUES (3,   '2000-01-01 23:59')
   INSERT INTO #ExpectedResult VALUES (4,   '2000-01-01 23:59')

   INSERT INTO #ActualResult   VALUES (1,                 NULL)
   INSERT INTO #ActualResult   VALUES (2,   '1900-01-01 00:00')
   INSERT INTO #ActualResult   VALUES (3,   '2000-01-01 23:59')
   INSERT INTO #ActualResult   VALUES (4,   '2000-01-01 23:59')
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_SmallDateTime'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_SmallDateTime
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 SmallDateTime)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 SmallDateTime)
   
   INSERT INTO #ExpectedResult VALUES (1, '2000-01-01 23:58')
   INSERT INTO #ActualResult   VALUES (1, '2000-01-01 23:59')

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_SmallDateTime'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO


CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_Char
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Char)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Char)

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,    '')
   INSERT INTO #ExpectedResult VALUES (3,   'A')
   INSERT INTO #ExpectedResult VALUES (4,   'a')

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,    '')
   INSERT INTO #ActualResult   VALUES (3,   'A')
   INSERT INTO #ActualResult   VALUES (4,   'a')
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_Char'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_Char
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Char COLLATE SQL_Latin1_General_CP1_CS_AS)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Char COLLATE SQL_Latin1_General_CP1_CS_AS)
   
   INSERT INTO #ExpectedResult VALUES (1, 'a')
   INSERT INTO #ActualResult   VALUES (1, 'A')

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_Char'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_NChar
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 NChar COLLATE SQL_Romanian_Cp1250_CI_AS)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 NChar COLLATE SQL_Romanian_Cp1250_CI_AS)

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,   N'')
   INSERT INTO #ExpectedResult VALUES (3,  N'A')
   INSERT INTO #ExpectedResult VALUES (4,  N'B')
   INSERT INTO #ExpectedResult VALUES (5,  N'Ă')
   INSERT INTO #ExpectedResult VALUES (6,  N'Ș')

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,   N'')
   INSERT INTO #ActualResult   VALUES (3,  N'a')
   INSERT INTO #ActualResult   VALUES (4,  N'b')
   INSERT INTO #ActualResult   VALUES (5,  N'ă')
   INSERT INTO #ActualResult   VALUES (6,  N'ș')
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_NChar'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_NChar
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 NChar)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 NChar)
   
   INSERT INTO #ExpectedResult VALUES (1, N'ț')
   INSERT INTO #ActualResult   VALUES (1, N't')

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_NChar'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_Char100
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Char(100))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Char(100))

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,    '')
   INSERT INTO #ExpectedResult VALUES (3,   '1')
   INSERT INTO #ExpectedResult VALUES (4,   '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890')

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,    '')
   INSERT INTO #ActualResult   VALUES (3,   '1')
   INSERT INTO #ActualResult   VALUES (4,   '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890')
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_Char100'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_Char100
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Char(100) COLLATE SQL_Latin1_General_CP1_CS_AS)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Char(100) COLLATE SQL_Latin1_General_CP1_CS_AS)
   
   INSERT INTO #ExpectedResult VALUES (1,   '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789A')
   INSERT INTO #ActualResult   VALUES (1,   '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789a')

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_Char100'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_NChar100
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 NChar(100))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 NChar(100))

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,   N'')
   INSERT INTO #ExpectedResult VALUES (3,  N'1')
   INSERT INTO #ExpectedResult VALUES (4,  N'1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890')

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,   N'')
   INSERT INTO #ActualResult   VALUES (3,  N'1')
   INSERT INTO #ActualResult   VALUES (4,  N'1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890')
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_NChar100'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_NChar100
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 NChar(100) COLLATE SQL_Latin1_General_CP1_CS_AS)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 NChar(100) COLLATE SQL_Latin1_General_CP1_CS_AS)
   
   INSERT INTO #ExpectedResult VALUES (1,  N'123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789A')
   INSERT INTO #ActualResult   VALUES (1,  N'123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789a')

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_NChar100'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_VarChar
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 VarChar)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 VarChar)

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,    '')
   INSERT INTO #ExpectedResult VALUES (3,   '1')
   INSERT INTO #ExpectedResult VALUES (4,   'A')

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,    '')
   INSERT INTO #ActualResult   VALUES (3,   '1')
   INSERT INTO #ActualResult   VALUES (4,   'A')
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_VarChar'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_VarChar
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 VarChar COLLATE SQL_Latin1_General_CP1_CS_AS)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 VarChar COLLATE SQL_Latin1_General_CP1_CS_AS)
   
   INSERT INTO #ExpectedResult VALUES (1,   'A')
   INSERT INTO #ActualResult   VALUES (1,   'a')

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_VarChar'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_NVarChar
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 NVarChar(10))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 NVarChar(10))

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,   N'')
   INSERT INTO #ExpectedResult VALUES (3,  N'abcdefghij')
   INSERT INTO #ExpectedResult VALUES (4,  N'ĂÎÂȘȚăîâșț')

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,   N'')
   INSERT INTO #ActualResult   VALUES (3,  N'abcdefghij')
   INSERT INTO #ActualResult   VALUES (4,  N'ĂÎÂȘȚăîâșț')
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_NVarChar'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_NVarChar
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 NVarChar(10) )
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 NVarChar(10) )
   
   INSERT INTO #ExpectedResult VALUES (1,  N'ĂÎÂȘȚăîâșț')
   INSERT INTO #ActualResult   VALUES (1,  N'ĂÎÂȘȚăîâșt')

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_NVarChar'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_VarChar100
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 VarChar(100))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 VarChar(100))

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,    '')
   INSERT INTO #ExpectedResult VALUES (3,   '1')
   INSERT INTO #ExpectedResult VALUES (4,   '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890')

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,    '')
   INSERT INTO #ActualResult   VALUES (3,   '1')
   INSERT INTO #ActualResult   VALUES (4,   '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890')
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_VarChar100'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_VarChar100
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 VarChar(100) COLLATE SQL_Latin1_General_CP1_CS_AS)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 VarChar(100) COLLATE SQL_Latin1_General_CP1_CS_AS)
   
   INSERT INTO #ExpectedResult VALUES (1,   '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789A')
   INSERT INTO #ActualResult   VALUES (1,   '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789a')

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_VarChar100'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_NVarChar100
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 NVarChar(100))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 NVarChar(100))

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,   N'')
   INSERT INTO #ExpectedResult VALUES (3,  N'1')
   INSERT INTO #ExpectedResult VALUES (4,  N'1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890')

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,   N'')
   INSERT INTO #ActualResult   VALUES (3,  N'1')
   INSERT INTO #ActualResult   VALUES (4,  N'1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890')
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_NVarChar100'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_NVarChar100
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 NVarChar(100) COLLATE SQL_Latin1_General_CP1_CS_AS)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 NVarChar(100) COLLATE SQL_Latin1_General_CP1_CS_AS)
   
   INSERT INTO #ExpectedResult VALUES (1,  N'123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789A')
   INSERT INTO #ActualResult   VALUES (1,  N'123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789a')

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_NVarChar100'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_VarCharMax
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 VarChar(max))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 VarChar(max))

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,    '')
   INSERT INTO #ExpectedResult VALUES (3,   '1')
   INSERT INTO #ExpectedResult VALUES (4,   '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890')

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,    '')
   INSERT INTO #ActualResult   VALUES (3,   '1')
   INSERT INTO #ActualResult   VALUES (4,   '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890')
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_VarCharMax'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_VarCharMax
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 VarChar(max) COLLATE SQL_Latin1_General_CP1_CS_AS)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 VarChar(max) COLLATE SQL_Latin1_General_CP1_CS_AS)
   
   INSERT INTO #ExpectedResult VALUES (1,   '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789A')
   INSERT INTO #ActualResult   VALUES (1,   '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789a')

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_VarCharMax'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO


CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_NVarCharMax
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 NVarChar(max))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 NVarChar(max))

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,   N'')
   INSERT INTO #ExpectedResult VALUES (3,  N'1')
   INSERT INTO #ExpectedResult VALUES (4,  N'12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890')

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,   N'')
   INSERT INTO #ActualResult   VALUES (3,  N'1')
   INSERT INTO #ActualResult   VALUES (4,  N'12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890')
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_NVarCharMax'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_NVarCharMax
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 NVarChar(max) COLLATE SQL_Latin1_General_CP1_CS_AS)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 NVarChar(max) COLLATE SQL_Latin1_General_CP1_CS_AS)
   
   INSERT INTO #ExpectedResult VALUES (1,  N'1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789A')
   INSERT INTO #ActualResult   VALUES (1,  N'1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789a')

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_NVarCharMax'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_Binary
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Binary)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Binary)

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,  0x00)
   INSERT INTO #ExpectedResult VALUES (3,  0x01)
   INSERT INTO #ExpectedResult VALUES (4,  0xFF)

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,  0x00)
   INSERT INTO #ActualResult   VALUES (3,  0x01)
   INSERT INTO #ActualResult   VALUES (4,  0xFF)
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_Binary'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_Binary
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Binary)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Binary)
   
   INSERT INTO #ExpectedResult VALUES (1,   0x00)
   INSERT INTO #ActualResult   VALUES (1,   0x01)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_Binary'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_Binary10
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Binary(10))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Binary(10))

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,  0x00)
   INSERT INTO #ExpectedResult VALUES (3,  0x01)
   INSERT INTO #ExpectedResult VALUES (4,  0x112233445566778899AA)

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,  0x00)
   INSERT INTO #ActualResult   VALUES (3,  0x01)
   INSERT INTO #ActualResult   VALUES (4,  0x112233445566778899AA)
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_Binary10'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_Binary10
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Binary(10))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Binary(10))
   
   INSERT INTO #ExpectedResult VALUES (1,   0x112233445566778899AA)
   INSERT INTO #ActualResult   VALUES (1,   0x112233445566778899AB)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_Binary10'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_VarBinary
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 VarBinary)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 VarBinary)

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,  0x00)
   INSERT INTO #ExpectedResult VALUES (3,  0x01)
   INSERT INTO #ExpectedResult VALUES (4,  0xFF)

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,  0x00)
   INSERT INTO #ActualResult   VALUES (3,  0x01)
   INSERT INTO #ActualResult   VALUES (4,  0xFF)
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_VarBinary'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_VarBinary
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 VarBinary)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 VarBinary)
   
   INSERT INTO #ExpectedResult VALUES (1,   0x00)
   INSERT INTO #ActualResult   VALUES (1,   0x01)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_VarBinary'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_VarBinary10
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 VarBinary(10))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 VarBinary(10))

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,  0x00)
   INSERT INTO #ExpectedResult VALUES (3,  0x01)
   INSERT INTO #ExpectedResult VALUES (4,  0x112233445566778899AA)

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,  0x00)
   INSERT INTO #ActualResult   VALUES (3,  0x01)
   INSERT INTO #ActualResult   VALUES (4,  0x112233445566778899AA)
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_VarBinary10'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_VarBinary10
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 VarBinary(10))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 VarBinary(10))
   
   INSERT INTO #ExpectedResult VALUES (1,   0x112233445566778899AA)
   INSERT INTO #ActualResult   VALUES (1,   0x112233445566778899AB)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_VarBinary10'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_VarBinaryMax
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 VarBinary(max))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 VarBinary(max))

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,  0x00)
   INSERT INTO #ExpectedResult VALUES (3,  0x01)
   INSERT INTO #ExpectedResult VALUES (4,  0x112233445566778899AA)

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,  0x00)
   INSERT INTO #ActualResult   VALUES (3,  0x01)
   INSERT INTO #ActualResult   VALUES (4,  0x112233445566778899AA)
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_VarBinaryMax'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_VarBinaryMax
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 VarBinary(max))
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 VarBinary(max))
   
   INSERT INTO #ExpectedResult VALUES (1,   0x112233445566778899AA)
   INSERT INTO #ActualResult   VALUES (1,   0x112233445566778899AB)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_VarBinaryMax'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_Uniqueidentifier
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Uniqueidentifier)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Uniqueidentifier)

   INSERT INTO #ExpectedResult VALUES (1,                                    NULL)
   INSERT INTO #ExpectedResult VALUES (2,  '00000000-0000-0000-0000-000000000000')
   INSERT INTO #ExpectedResult VALUES (3,  '6A88E546-117B-400F-B69C-C355D827D68C')

   INSERT INTO #ActualResult   VALUES (1,                                    NULL)
   INSERT INTO #ActualResult   VALUES (2,  '00000000-0000-0000-0000-000000000000')
   INSERT INTO #ActualResult   VALUES (3,  '6A88E546-117B-400F-B69C-C355D827D68C')
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_Uniqueidentifier'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_Uniqueidentifier
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 Uniqueidentifier)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 Uniqueidentifier)
   
   INSERT INTO #ExpectedResult VALUES (1,   '6A88E546-117B-400F-B69C-C355D827D68C')
   INSERT INTO #ActualResult   VALUES (1,   '6A88E546-117B-400F-B69C-C355D827D68D')

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_Uniqueidentifier'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO


CREATE PROCEDURE dbo.SQLTest_TablesCompareSameData_SQLVariant
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 sql_variant)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 sql_variant)

   INSERT INTO #ExpectedResult VALUES (1,  NULL)
   INSERT INTO #ExpectedResult VALUES (2,     0)
   INSERT INTO #ExpectedResult VALUES (3,  CAST('2001-01-01 23:59:59.100' as varchar) )
   INSERT INTO #ExpectedResult VALUES (4,  'abc')

   INSERT INTO #ActualResult   VALUES (1,  NULL)
   INSERT INTO #ActualResult   VALUES (2,     0)
   INSERT INTO #ActualResult   VALUES (3,  CAST('2001-01-01 23:59:59.100' as varchar) )
   INSERT INTO #ActualResult   VALUES (4,  'abc')
                                      
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareSameData_SQLVariant'

END
GO

CREATE PROCEDURE dbo.SQLTest_TablesCompareDifferentData_SQLVariant
AS
BEGIN

   -- EXEC TST.Utils.DropTestTables

   CREATE TABLE #ExpectedResult  (ID1 int PRIMARY KEY NOT NULL, Col1 sql_variant)
   CREATE TABLE #ActualResult    (ID1 int PRIMARY KEY NOT NULL, Col1 sql_variant)
   
   INSERT INTO #ExpectedResult VALUES (1,     0)
   INSERT INTO #ActualResult   VALUES (1,   '1')

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TablesCompareDifferentData_SQLVariant'

   EXEC TST.Assert.LogInfo          'This log should not be executed'
   EXEC TST.Assert.Equals 'This assert should not be executed', 1, 1
END
GO


CREATE PROCEDURE dbo.SQLTest_IgnoredColumnsHaveTheSameName
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 varchar(10))
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 varchar(10))
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_IgnoredColumnsHaveTheSameName', "C1;C1"

   EXEC TST.Assert.LogInfo     'This log should not be executed'

END
GO

CREATE PROCEDURE dbo.SQLTest_IgnoredColumnsIsUnknown
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 varchar(10))
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 varchar(10))
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_IgnoredColumnsIsUnknown', "CX"

   EXEC TST.Assert.LogInfo     'This log should not be executed'

END
GO


CREATE PROCEDURE dbo.SQLTest_IgnoredColumnsHaveDifferentTypes
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 int, C2 int)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 int, C2 varchar)
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_IgnoredColumnsHaveDifferentTypes', "C2"

   EXEC TST.Assert.LogInfo     'This log should not be executed'
END
GO


CREATE PROCEDURE dbo.SQLTest_IgnoredColumnsHaveDifferentLengths
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 int, C2 varchar(10))
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 int, C2 varchar(11))
   
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_IgnoredColumnsHaveDifferentLengths', "C2"

   EXEC TST.Assert.LogInfo     'This log should not be executed'

END
GO


CREATE PROCEDURE dbo.SQLTest_IgnoredColumnsHaveDifferentCollations
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 int, C2 varchar(10) COLLATE SQL_Latin1_General_CP1_CS_AS)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 int, C2 varchar(10) COLLATE SQL_Latin1_General_Cp1_CI_AS)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_IgnoredColumnsHaveDifferentCollations', "C2"

   EXEC TST.Assert.LogInfo     'This log should not be executed'

END
GO


CREATE PROCEDURE dbo.SQLTest_IgnoredColumnIsInPrimaryKey
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID1 int NOT NULL, ID2 int NOT NULL, C1 int, C2 varchar(10), C3 bit)
   ALTER TABLE  #ExpectedResult ADD CONSTRAINT PK_ExpectedResult PRIMARY KEY CLUSTERED (ID1, ID2)
   
   CREATE TABLE #ActualResult  (ID1 int NOT NULL, ID2 int NOT NULL, C1 int, C2 varchar(10), C3 bit)
   ALTER TABLE  #ActualResult ADD CONSTRAINT PK_ActualResult PRIMARY KEY CLUSTERED (ID1, ID2)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_IgnoredColumnIsInPrimaryKey', "ID2"

   EXEC TST.Assert.LogInfo     'This log should not be executed'

END
GO


CREATE PROCEDURE dbo.SQLTest_IgnoredColumnHasInvalidType_SameDataInRegularColumns
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 varchar(10), C2 Timestamp)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 varchar(10), C2 Timestamp)
   
   INSERT INTO #ExpectedResult VALUES (1, 'abc', default)
   INSERT INTO #ExpectedResult VALUES (2, NULL , default)
   INSERT INTO #ActualResult   VALUES (1, 'abc', default)
   INSERT INTO #ActualResult   VALUES (2, NULL , default)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_IgnoredColumnHasInvalidType_SameDataInRegularColumns', "C2"

END
GO

CREATE PROCEDURE dbo.SQLTest_IgnoredColumnHasInvalidType_DiffDataInRegularColumns
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY, C1 varchar(10), C2 Timestamp)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY, C1 varchar(10), C2 Timestamp)
   
   INSERT INTO #ExpectedResult VALUES (1, 'abc', default)
   INSERT INTO #ExpectedResult VALUES (2, NULL , default)
   INSERT INTO #ActualResult   VALUES (1, 'abX', default)
   INSERT INTO #ActualResult   VALUES (2, NULL , default)

   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_IgnoredColumnHasInvalidType_DiffDataInRegularColumns', "C2"

   EXEC TST.Assert.LogInfo     'This log should not be executed'

END
GO

CREATE PROCEDURE dbo.SQLTest_IgnoredColumnOnlyInExpectedResult_SameDataInRegularColumns
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY NOT NULL, C1 varchar(10), C2 DateTime)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY NOT NULL, C1 varchar(10))

   INSERT INTO #ExpectedResult VALUES (1, 'abc', GETDATE())
   INSERT INTO #ExpectedResult VALUES (2, NULL , GETDATE())
   INSERT INTO #ActualResult   VALUES (1, 'abc')
   INSERT INTO #ActualResult   VALUES (2, NULL )
 
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_IgnoredColumnOnlyInExpectedResult_SameDataInRegularColumns', "C2"

END
GO

CREATE PROCEDURE dbo.SQLTest_IgnoredColumnOnlyInExpectedResult_SameDataInRegularColumns_2
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY NOT NULL, C1 varchar(10), C2 DateTime, C3 varchar(10), C4 int)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY NOT NULL, C1 varchar(10), C4 int)

   INSERT INTO #ExpectedResult VALUES (1, 'abc', GETDATE(), 'ignore1', 100)
   INSERT INTO #ExpectedResult VALUES (2, NULL , GETDATE(), 'ignore2', 200)
   INSERT INTO #ActualResult   VALUES (1, 'abc', 100)
   INSERT INTO #ActualResult   VALUES (2, NULL , 200)
 
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_IgnoredColumnOnlyInExpectedResult_SameDataInRegularColumns_2', "C2;C3"

END
GO

CREATE PROCEDURE dbo.SQLTest_IgnoredColumnOnlyInActualResult_SameDataInRegularColumns
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY NOT NULL, C1 varchar(10))
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY NOT NULL, C1 varchar(10), C2 DateTime)

   INSERT INTO #ExpectedResult VALUES (1, 'abc')
   INSERT INTO #ExpectedResult VALUES (2, NULL )
   INSERT INTO #ActualResult   VALUES (1, 'abc', GETDATE())
   INSERT INTO #ActualResult   VALUES (2, NULL , GETDATE())
 
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_IgnoredColumnOnlyInActualResult_SameDataInRegularColumns', "C2"

END
GO

CREATE PROCEDURE dbo.SQLTest_IgnoredColumnOnlyInActualResult_SameDataInRegularColumns_2
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY NOT NULL, C1 varchar(10), C4 int)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY NOT NULL, C1 varchar(10), C2 DateTime, C3 real, C4 int)

   INSERT INTO #ExpectedResult VALUES (1, 'abc', 11)
   INSERT INTO #ExpectedResult VALUES (2, NULL , 12)
   INSERT INTO #ActualResult   VALUES (1, 'abc', GETDATE(), 10.22, 11)
   INSERT INTO #ActualResult   VALUES (2, NULL , GETDATE(), 20.44, 12)
 
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_IgnoredColumnOnlyInActualResult_SameDataInRegularColumns_2', "C2;C3"

END
GO

CREATE PROCEDURE dbo.SQLTest_SameDataExceptForIgnoredColumn
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY NOT NULL, C1 varchar(10), C2 DateTime)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY NOT NULL, C1 varchar(10), C2 DateTime)

   INSERT INTO #ExpectedResult VALUES (1, 'abc', '2001-01-01')
   INSERT INTO #ExpectedResult VALUES (2, NULL , '2001-01-02')
   INSERT INTO #ActualResult   VALUES (1, 'abc', '2002-02-04')
   INSERT INTO #ActualResult   VALUES (2, NULL , '2002-02-05')
 
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_SameDataExceptForIgnoredColumn', "C2"

END
GO

CREATE PROCEDURE dbo.SQLTest_SameDataExceptForIgnoredColumn_2
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY NOT NULL, C1 varchar(10), C2 DateTime, C3 varchar(10), C4 int)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY NOT NULL, C1 varchar(10), C2 DateTime, C3 varchar(10), C4 int)

   INSERT INTO #ExpectedResult VALUES (1, 'abc', '2001-01-01', '123', 100)
   INSERT INTO #ExpectedResult VALUES (2, NULL , '2001-01-02', '124', 200)
   INSERT INTO #ActualResult   VALUES (1, 'abc', '2002-02-04', '223', 100)
   INSERT INTO #ActualResult   VALUES (2, NULL , '2002-02-05', '224', 200)
 
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_SameDataExceptForIgnoredColumn_2', "C2;C3"

END
GO


CREATE PROCEDURE dbo.SQLTest_TwoIgnoredColumns_DifferentDataInRegularColumns
AS
BEGIN

   CREATE TABLE #ExpectedResult  (ID int PRIMARY KEY NOT NULL, C1 varchar(10), C2 DateTime, C3 varchar(10), C4 int)
   CREATE TABLE #ActualResult    (ID int PRIMARY KEY NOT NULL, C1 varchar(10), C2 DateTime, C3 varchar(10), C4 int)

   INSERT INTO #ExpectedResult VALUES (1, 'abc', '2001-01-01', '123', 100)
   INSERT INTO #ExpectedResult VALUES (2, NULL , '2001-01-02', '124', 200)
   INSERT INTO #ActualResult   VALUES (1, 'abc', '2002-02-04', '223', 101)
   INSERT INTO #ActualResult   VALUES (2, NULL , '2002-02-05', '224', 200)
 
   EXEC TST.Assert.TableEquals 'Test Assert in SQLTest_TwoIgnoredColumns_DifferentDataInRegularColumns', "C2;C3"

END
GO


USE tempdb
GO


/*
TODO: 
- A test where data is the same with multiple columns - of all types
*/
