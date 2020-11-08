
DECLARE @TestSessionId        int
DECLARE @TestSessionPassed    bit 

/*
INSERT INTO TST.Data.TSTVariables(DatabaseName, VariableName, VariableValue) VALUES (NULL, 'SqlTestPrefix', 'ST_')
delete from TST.Data.TSTVariables
select * from TST.Data.TSTVariables

INSERT INTO TSTCheckCustomPrefix.dbo.TestParameters (PrefixDatabaseName, CustomPrefix) VALUES (NULL, 'OtherPrefix_')
INSERT INTO TSTCheckCustomPrefix.dbo.TestParameters (PrefixDatabaseName, CustomPrefix) VALUES ('TSTCheckCustomPrefix', 'ST_')

INSERT INTO TSTCheckCustomPrefix.dbo.TestParameters (PrefixDatabaseName, CustomPrefix) VALUES (NULL, 'ST_')
INSERT INTO TSTCheckCustomPrefix.dbo.TestParameters (PrefixDatabaseName, CustomPrefix) VALUES ('OtherDatabase', 'OtherPrefix_')

select * from TST.Data.TSTParameters
*/

INSERT INTO TSTCheckIgnore.dbo.TestParameters (ParameterValue) VALUES ('T')

EXEC TST.Runner.RunTest
   @TestDatabaseName    = 'TSTCheckIgnore'      ,
   @TestName            = 'SQLTest_Test1'       ,
   @ResultsFormat       = 'None'                ,
   @CleanTemporaryData  = 0                     ,
   @TestSessionId       = @TestSessionId OUT    ,
   @TestSessionPassed   = @TestSessionPassed OUT


select @TestSessionPassed as TestSessionPassed   

select * from TST.Data.Suite
select * from TST.Data.Test
select * from TST.Data.TestLog
select * from TST.Data.SystemErrorLog

EXEC TST.Internal.CleanSessionData @TestSessionId

/*
DECLARE @TestSessionId        int

EXEC TST.Runner.RunTest 
   @TestDatabaseName='TSTCheckMaster', 
   @TestName='SQLTest_IsTableEmpty#NoActualTableCreated',
   --@CleanTemporaryData  = 0                        ,
   @Verbose=1


USE tempdb
GO
-- select * FROM TST.Data.TEst
*/
/*

An error occured during the execution of the test procedure '[TSTCheckTestSession2].[TestSchema1].[SQLTest_SESSION_SETUP]'. Error: 102, 
Incorrect syntax near 'TSTCheckTestSession2'. Procedure: N/A. Line: 1

select * from TST.Data.Suite
select * from TST.Data.Test
select * from TST.Data.TestLog
select * from TST.Data.SystemErrorLog

*/
-- select * from TST.Data.SystemErrorLog
/*
   DECLARE @TestSessionId        int
   DECLARE @TestSessionPassed    bit 

   EXEC TST.Runner.RunTest
      @TestDatabaseName    = 'TSTCheckError'          ,
      @TestName            = 'SQLTest_SetupCallsExpectedError#Test',
      @ResultsFormat       = 'None'                   ,
      @CleanTemporaryData  = 0                        ,
      @TestSessionId       = @TestSessionId OUT       ,
      @TestSessionPassed   = @TestSessionPassed OUT
   select * from TST.Data.TestLog
   -- EXEC TST.Assert.Equals 'The test session must have failed', 0, @TestSessionPassed
*/
/*
EXEC TST.Runner.RunTest 
   @TestDatabaseName='TSTCheckMaster', 
   @TestName='SQLTest_ExpectedErrors#SetupCallsExpectedError',
   @Verbose=1


-- select * from TST.Data.Test
*/

/* 
EXEC TST.Runner.RunAll @TestDatabaseName = 'Test'


*/