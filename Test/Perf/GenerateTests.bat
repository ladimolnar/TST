@ECHO OFF
IF "%useverbose%"=="1" ECHO ON

SET GT_SQLFilePath="TSTPerf.SQL"

ECHO. >%GT_SQLFilePath%
CALL :SubGenerateDBAndInitialProcs %GT_ProcCount%

FOR /L %%a IN (1,1,1000) DO CALL :SubGenerateTestProc %%a

ECHO USE tempdb >>%GT_SQLFilePath%
ECHO GO >>%GT_SQLFilePath%

GOTO :EOF

:SubGenerateTestProc 

SET GT_ProcCount=%1

ECHO CREATE PROCEDURE SQLTest_P%GT_ProcCount% >>%GT_SQLFilePath%
ECHO AS >>%GT_SQLFilePath%
ECHO BEGIN >>%GT_SQLFilePath%
ECHO. >>%GT_SQLFilePath%
ECHO   DECLARE @ActualValue int >>%GT_SQLFilePath%
ECHO   DECLARE @ExpectedValue int >>%GT_SQLFilePath%
ECHO. >>%GT_SQLFilePath%
ECHO   SET @ActualValue=dbo.TFN_DoubleInt(%GT_ProcCount%) >>%GT_SQLFilePath%
ECHO   SET @ExpectedValue=2 * %GT_ProcCount% >>%GT_SQLFilePath%
ECHO   EXEC TST.Assert.Equals 'SQLTest_P%GT_ProcCount%', @ExpectedValue, @ActualValue >>%GT_SQLFilePath%
ECHO. >>%GT_SQLFilePath%
ECHO END >>%GT_SQLFilePath%
ECHO GO >>%GT_SQLFilePath%
ECHO. >>%GT_SQLFilePath%
ECHO. >>%GT_SQLFilePath%

GOTO :EOF


:SubGenerateDBAndInitialProcs

ECHO USE tempdb >>%GT_SQLFilePath%
ECHO GO >>%GT_SQLFilePath%
ECHO. >>%GT_SQLFilePath%
ECHO IF EXISTS (SELECT [name] FROM sys.databases WHERE [name] = 'TST_TimingTest') >>%GT_SQLFilePath%
ECHO BEGIN >>%GT_SQLFilePath%
ECHO    DROP DATABASE TST_TimingTest >>%GT_SQLFilePath%
ECHO END >>%GT_SQLFilePath%
ECHO. >>%GT_SQLFilePath%
ECHO CREATE DATABASE TST_TimingTest >>%GT_SQLFilePath%
ECHO GO >>%GT_SQLFilePath%
ECHO. >>%GT_SQLFilePath%
ECHO USE TST_TimingTest >>%GT_SQLFilePath%
ECHO GO >>%GT_SQLFilePath%
ECHO. >>%GT_SQLFilePath%
ECHO CREATE FUNCTION dbo.TFN_DoubleInt (@Value int) RETURNS varchar(8) >>%GT_SQLFilePath%
ECHO AS >>%GT_SQLFilePath%
ECHO BEGIN >>%GT_SQLFilePath%
ECHO    RETURN 2 * @Value >>%GT_SQLFilePath%
ECHO END >>%GT_SQLFilePath%
ECHO GO >>%GT_SQLFilePath%
ECHO. >>%GT_SQLFilePath%

GOTO :EOF
