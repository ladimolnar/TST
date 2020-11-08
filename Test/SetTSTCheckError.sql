--===================================================================
-- FILE: SetTSTCheckError.sql
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
IF EXISTS (SELECT [name] FROM sys.databases WHERE [name] = 'TSTCheckError')
BEGIN
   DROP DATABASE TSTCheckError
END

CREATE DATABASE TSTCheckError
GO

USE TSTCheckError
GO

-- =======================================================================
-- Stored procedures that will be called by TST test procedures
-- =======================================================================

-- ==================================================================
-- PROCEDURE: RaiseAnError 
-- This is a stored procedure that is created to exemplify 
-- the concept of expected error.
-- If @Raise is 1 it will raise an error.
-- ==================================================================
CREATE PROCEDURE RaiseAnError 
   @Raise bit
AS
BEGIN
   IF (@Raise = 1)
   BEGIN
      RAISERROR('Test error', 16, 1)
   END
END
GO

-- ==================================================================
-- PROCEDURE: RaiseAnError2 
-- This is a stored procedure that is created to exemplify 
-- the concept of expected error.
-- If @Raise is 1 it will raise an error.
-- ==================================================================
CREATE PROCEDURE RaiseAnError2
   @Raise bit
AS
BEGIN
   IF (@Raise = 1)
   BEGIN
      RAISERROR('START long message long message long message [X-Z] ABC long message long message long message long message END', 16, 1)
   END
END
GO

-- =======================================================================
-- The TST test stored procedures
-- =======================================================================

CREATE PROCEDURE dbo.SQLTest_UnexpectedError
AS
BEGIN
   EXEC dbo.RaiseAnError @Raise = 1
END
GO

CREATE PROCEDURE dbo.SQLTest_ExpectedErrorNotRaised
AS
BEGIN

   EXEC TST.Assert.RegisterExpectedError 
      @ContextMessage         = 'This is supposed to raise an error',
      @ExpectedErrorMessage   = 'Test error'
   
   EXEC TST.Assert.Pass 'Test Pass in SQLTest_ExpectedErrorNotRaised'

END
GO

CREATE PROCEDURE dbo.SQLTest_ExpectedErrorMessage
AS
BEGIN

   EXEC TST.Assert.RegisterExpectedError 
      @ContextMessage         = 'RaiseAnError is supposed to raise an error',
      @ExpectedErrorMessage   = 'Test error'

   EXEC dbo.RaiseAnError @Raise = 1

END
GO

CREATE PROCEDURE dbo.SQLTest_ExpectedErrorLikeMessage
AS
BEGIN

   EXEC TST.Assert.RegisterExpectedError
      @ContextMessage               = 'RaiseAnError2 is supposed to raise an error',
      @ExpectedErrorLikeMessage     = '%ABC%'

   EXEC dbo.RaiseAnError2 @Raise = 1

END
GO

CREATE PROCEDURE dbo.SQLTest_ExpectedErrorLikeMessageAndEscape
AS
BEGIN

   EXEC TST.Assert.RegisterExpectedError
      @ContextMessage               = 'RaiseAnError2 is supposed to raise an error',
      @ExpectedErrorLikeMessage     = '%^[X-Z^] ABC%',
      @LikeEscapeCharacter          = '^'

   EXEC dbo.RaiseAnError2 @Raise = 1

END
GO

CREATE PROCEDURE dbo.SQLTest_ExpectedErrorLikeMessageAndEscapeFailed_1
AS
BEGIN

   -- This will fail because the escape character is missing from the @ExpectedErrorLikeMessage
   EXEC TST.Assert.RegisterExpectedError
      @ContextMessage               = 'RaiseAnError2 is supposed to raise an error',
      @ExpectedErrorLikeMessage     = '%[X-Z] ABC%'

   EXEC dbo.RaiseAnError2 @Raise = 1

END
GO

CREATE PROCEDURE dbo.SQLTest_ExpectedErrorLikeMessageAndEscapeFailed_2
AS
BEGIN

   -- This will fail because the escape character is not the right one
   EXEC TST.Assert.RegisterExpectedError
      @ContextMessage               = 'RaiseAnError2 is supposed to raise an error',
      @ExpectedErrorLikeMessage     = '%^[X-Z^] ABC%',
      @LikeEscapeCharacter          = '!'

   EXEC dbo.RaiseAnError2 @Raise = 1

END
GO


CREATE PROCEDURE dbo.SQLTest_ExpectedErrorLikeMessageFailed
AS
BEGIN

   EXEC TST.Assert.RegisterExpectedError
      @ContextMessage               = 'RaiseAnError2 is supposed to raise an error',
      @ExpectedErrorLikeMessage     = '%Wrong Message%'

   EXEC dbo.RaiseAnError2 @Raise = 1

END
GO

CREATE PROCEDURE dbo.SQLTest_ExpectedErrorProcedure
AS
BEGIN

   EXEC TST.Assert.RegisterExpectedError 
      @ContextMessage               = 'RaiseAnError is supposed to raise an error',
      @ExpectedErrorProcedure       = 'RaiseAnError'

   EXEC dbo.RaiseAnError @Raise = 1

END
GO

CREATE PROCEDURE dbo.SQLTest_ExpectedErrorNumber
AS
BEGIN

   EXEC TST.Assert.RegisterExpectedError 
      @ContextMessage         = 'RaiseAnError is supposed to raise an error',
      @ExpectedErrorNumber    = 50000

   EXEC dbo.RaiseAnError @Raise = 1

END
GO

CREATE PROCEDURE dbo.SQLTest_ExpectedError
AS
BEGIN

   EXEC TST.Assert.RegisterExpectedError 
      @ContextMessage               = 'RaiseAnError is supposed to raise an error',
      @ExpectedErrorMessage         = 'Test error',
      @ExpectedErrorProcedure       = 'RaiseAnError',
      @ExpectedErrorNumber          = 50000

   EXEC dbo.RaiseAnError @Raise = 1

END
GO

CREATE PROCEDURE dbo.SQLTest_ErrorDifferentThanTheExpectedOne
AS
BEGIN

   EXEC TST.Assert.RegisterExpectedError 
      @ContextMessage               = 'RaiseAnError is supposed to raise an error',
      @ExpectedErrorMessage         = 'Test error abc'

   EXEC dbo.RaiseAnError @Raise = 1

END
GO

CREATE PROCEDURE dbo.SQLTest_ExpectedErrorNullContext
AS
BEGIN

   EXEC TST.Assert.RegisterExpectedError 
      @ContextMessage               = NULL,
      @ExpectedErrorMessage         = 'Test error',
      @ExpectedErrorProcedure       = 'RaiseAnError',
      @ExpectedErrorNumber          = 50000

   EXEC dbo.RaiseAnError @Raise = 1

END
GO

CREATE PROCEDURE dbo.SQLTest_RegisterExpectedErrorInvalidCall_1
AS
BEGIN

   EXEC TST.Assert.LogInfo  'This is SQLTest_RegisterExpectedErrorInvalidCall_1'

   -- This will trigger an error. @ExpectedErrorMessage and @ExpectedErrorLikeMessage cannot both be specified.
   EXEC TST.Assert.RegisterExpectedError
      @ContextMessage               = NULL,
      @ExpectedErrorMessage         = 'Test error',
      @ExpectedErrorLikeMessage     = '%error%'

   EXEC dbo.RaiseAnError @Raise = 1

END
GO

CREATE PROCEDURE dbo.SQLTest_RegisterExpectedErrorInvalidCall_2
AS
BEGIN

   EXEC TST.Assert.LogInfo  'This is SQLTest_RegisterExpectedErrorInvalidCall_2'

   -- This will trigger an error. @LikeEscapeCharacter can only be specified when @ExpectedErrorLikeMessage is also specified.
   EXEC TST.Assert.RegisterExpectedError
      @ContextMessage               = NULL,
      @ExpectedErrorMessage         = 'Test error',
      @LikeEscapeCharacter          = '!'

   EXEC dbo.RaiseAnError @Raise = 1

END
GO

-- =======================================================================
-- START Suite SQLTest_SETUP_SetupCallsExpectedError
-- =======================================================================

CREATE PROCEDURE SQLTest_SETUP_SetupCallsExpectedError
AS
BEGIN
   EXEC TST.Assert.LogInfo  'This is SQLTest_SETUP_SetupCallsExpectedError'

   EXEC TST.Assert.RegisterExpectedError 
      @ContextMessage               = 'This call will trigger an error',
      @ExpectedErrorMessage         = 'Test error',
      @ExpectedErrorProcedure       = 'RaiseAnError',
      @ExpectedErrorNumber          = 50000
      
   EXEC TST.Assert.LogInfo  'This log should not be executed'

END
GO

CREATE PROCEDURE SQLTest_SetupCallsExpectedError#Test
AS
BEGIN
   EXEC TST.Assert.LogInfo  'This log should not be executed'
END
GO

CREATE PROCEDURE SQLTest_TEARDOWN_SetupCallsExpectedError
AS
BEGIN
   EXEC TST.Assert.LogInfo  'This is SQLTest_TEARDOWN_SetupCallsExpectedError'
END
GO

-- =======================================================================
-- END Suite SQLTest_SETUP_SetupCallsExpectedError
-- =======================================================================

-- =======================================================================
-- START Suite SQLTest_SETUP_TeardownCallsExpectedError
-- =======================================================================

CREATE PROCEDURE SQLTest_SETUP_TeardownCallsExpectedError
AS
BEGIN
   EXEC TST.Assert.LogInfo  'This is SQLTest_SETUP_TeardownCallsExpectedError'
END
GO

CREATE PROCEDURE SQLTest_TeardownCallsExpectedError#Test
AS
BEGIN
   EXEC TST.Assert.LogInfo  'This is SQLTest_TeardownCallsExpectedError#Test'
END
GO

CREATE PROCEDURE SQLTest_TEARDOWN_TeardownCallsExpectedError
AS
BEGIN
   EXEC TST.Assert.LogInfo  'This is SQLTest_TEARDOWN_TeardownCallsExpectedError'

   EXEC TST.Assert.RegisterExpectedError 
      @ContextMessage               = 'This call will trigger an error',
      @ExpectedErrorMessage         = 'Test error',
      @ExpectedErrorProcedure       = 'RaiseAnError',
      @ExpectedErrorNumber          = 50000

   EXEC TST.Assert.LogInfo  'This log should not be executed'

END
GO

-- =======================================================================
-- END Suite SQLTest_SETUP_SetupCallsExpectedError
-- =======================================================================

USE tempdb
GO

