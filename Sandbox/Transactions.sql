--===================================================================
-- FILE: Transactions.sql
-- Used to test scenarios around errors in triggers.
-- ==================================================================

USE tempdb
GO

-- =======================================================================
-- Creates the TSTCheckTriggers Database. If already exists then drops it first.
-- =======================================================================
IF EXISTS (SELECT [name] FROM sys.databases WHERE [name] = 'TSTCheckTriggers')
BEGIN
   DROP DATABASE TSTCheckTriggers
END

CREATE DATABASE TSTCheckTriggers
GO

USE TSTCheckTriggers
GO


CREATE TABLE dbo.Dummy(
   EntryId        int identity primary key,
   EntryName      varchar(50) not null
)
GO

CREATE TRIGGER dbo.TestTrigger on dbo.Dummy FOR INSERT
AS
 RAISERROR('TRIGGER_ERROR', 16, 1)
GO

CREATE PROCEDURE dbo.SQLTEST_Dummy
AS
 EXEC TST.Assert.RegisterExpectedError 'Test 1', 'TRIGGER_ERROR';
 INSERT INTO dbo.Dummy VALUES('a')
GO

/*
EXEC TST.Runner.RunTest @TestDatabaseName='TSTCheckTriggers', @TestName='SQLTEST_Dummy', @Verbose=1
*/
