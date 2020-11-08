# T.S.T. a T-SQL Test Tool

**NO LONGER MAINTAINED**  
T.S.T. was originally created on CodePlex. Since CodePlex was retired, T.S.T. was moved to Github. 
At present it is NO LONGER MAINTAINED but feel free to fork and maintain your own version.

## Welcome to T.S.T.

TST is a tool that simplifies writing and running automated tests for code written in T-SQL. 
At the core of the TST tool is the TST database. 
The tool itself is written in T-SQL and provides an API similar to those provided by other Unit Testing frameworks familiar to programmers in C# or Java. 


## Feature Highlights
- Support for validating views as well as stored procedures and functions that return a table.
- A reliable implementation of Assert.Equals / Assert.NotEquals procedures. They detect when a comparison should not be made due to incompatibility of the data types. Additional procedures like Assert.NumericEquals, Assert.NumericNotEquals, Assert.FloatEquals, Assert.FloatNotEquals are provided.
- Can run concurrent test sessions against the same or different databases.
- Can generate XML results.
- Automatic rollback of the database changes done during each test.
- TST will detect when its own rollback mechanism becomes ineffective in some scenarios that involve testing code that uses transactions. The TST rollback can be disabled at the test, suite or global level.
- No need to register the test stored procedures; they are picked up automatically by the TST test runners.
- Can be run from the command prompt or directly by calling one of the test runner stored procedures.
- The TST infrastructure is isolated in a separate database.
- Easy to install and integrate with other test frameworks.
- Does not have any dependencies besides SQL Server.
- Very small learning curve for someone already familiar with T-SQL.

**Complete documentation including a Quick Start section:**

- PDF format: [TST.pdf](DOC/TST.pdf)
- HTML format: [TST.mht](DOC/TST.mht)
- Word 2010 file: [TST.docx](DOC/TST.docx)

**7 minutes video demo:** http://www.youtube.com/watch?v=bLtK20bl7G4

## The TST API

- Assert.LogInfo
- Assert.Pass
- Assert.Fail
- Assert.Equals
- Assert.NotEquals
- Assert.NumericEquals
- Assert.NumericNotEquals
- Assert.FloatEquals
- Assert.FloatNotEquals
- Assert.NVarCharMaxEquals
- Assert.NVarCharMaxNotEquals
- Assert.IsLike
- Assert.IsNotLike
- Assert.IsNull
- Assert.IsNotNull
- Assert.TableEquals
- Assert.IsTableEmpty
- Assert.IsTableNotEmpty
- Assert.RegisterExpectedError
- Assert.Ignore
- Runner.RunAll
- Runner.RunSuite
- Runner.RunTest
- Utils.SetConfiguration

