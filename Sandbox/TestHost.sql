

-- USE TST

DROP TABLE T1
GO

CREATE TABLE T1 (
   T1_ID                int primary key,
   T1_datetime          datetime,
   T1_smalldatetime     smalldatetime,
   T1_time              time,
   T1_date              date,
   T1_datetime2         datetime2,
   T1_datetimeoffset    datetimeoffset,
)
GO


ALTER PROCEDURE PopulateTable
AS
BEGIN

   DELETE FROM T1

   INSERT INTO T1 (T1_ID, T1_datetime, T1_smalldatetime, T1_time, T1_date, T1_datetime2, T1_datetimeoffset ) VALUES (1, '2001-01-01 10:11:12.500', '2002-01-01', '00:01:02.100', '2003-01-01 20:11:12.500', '2004-01-01 20:21:12.500', '2005-01-01 21:22:12.500')
   INSERT INTO T1 (T1_ID, T1_datetime, T1_smalldatetime, T1_time, T1_date, T1_datetime2, T1_datetimeoffset ) VALUES (2, '2001-01-01 10:11:12.500', '2002-01-01', '00:01:02.100', '2003-01-01 20:11:12.500', '2004-01-01 20:21:12.500', '2005-01-01 21:22:12.500')
   INSERT INTO T1 (T1_ID, T1_datetime, T1_smalldatetime, T1_time, T1_date, T1_datetime2, T1_datetimeoffset ) VALUES (3, '2001-01-01 10:11:12.500', '2002-01-01', '00:01:02.100', '2003-01-01 20:11:12.500', '2004-01-01 20:21:12.500', '2005-99-99 21:22:12.500')
   
END
GO

ALTER PROCEDURE SQLTEST_PopulateTable
AS
BEGIN
      -- Create the temporary tables #ActualResult and #ExpectedResult
   CREATE TABLE #ExpectedResult (
      T1_ID                int primary key,
      T1_datetime          datetime,
      T1_smalldatetime     smalldatetime,
      T1_time              time,
      T1_date              date,
      T1_datetime2         datetime2,
      T1_datetimeoffset    datetimeoffset,
   )
   CREATE TABLE #ActualResult (
      T1_ID                int primary key,
      T1_datetime          datetime,
      T1_smalldatetime     smalldatetime,
      T1_time              time,
      T1_date              date,
      T1_datetime2         datetime2,
      T1_datetimeoffset    datetimeoffset,
   )

   EXEC PopulateTable

   INSERT INTO #ExpectedResult (T1_ID, T1_datetime, T1_smalldatetime, T1_time, T1_date, T1_datetime2, T1_datetimeoffset ) VALUES (1, '2001-01-01 10:11:12.500', '2002-01-01', '00:01:02.100', '2003-01-01 20:11:12.500', '2004-01-01 20:21:12.500', '2005-01-01 21:22:12.500')
   INSERT INTO #ExpectedResult (T1_ID, T1_datetime, T1_smalldatetime, T1_time, T1_date, T1_datetime2, T1_datetimeoffset ) VALUES (2, '2001-01-01 10:11:12.500', '2002-01-01', '00:01:02.100', '2003-01-01 20:11:12.500', '2004-01-01 20:21:12.500', '2005-01-01 21:22:12.500')
   INSERT INTO #ExpectedResult (T1_ID, T1_datetime, T1_smalldatetime, T1_time, T1_date, T1_datetime2, T1_datetimeoffset ) VALUES (3, '2001-01-01 10:11:12.500', '2002-01-01', '00:01:02.100', '2003-01-01 20:11:12.500', '2004-01-01 20:21:12.500', '2005-01-01 21:22:12.500')

   -- Store the actual data in #ActualResult
   INSERT INTO #ActualResult
   SELECT * FROM T1

   -- Assert.TableEquals compares the schema and content of tables 
   -- #ExpectedResult and #ActualResult.
   EXEC TST.Assert.TableEquals 'Testing T1 table'
  
END



/*

EXEC PopulateTable

select 
   T1_datetime, 
   T1_smalldatetime,
   CAST(T1_time      as nvarchar(20) ) AS T1_time,
   CAST(T1_date      as nvarchar(20) ) AS T1_date,
   CAST(T1_datetime2 as nvarchar(20) ) AS T1_datetime2,
   CAST(T1_datetimeoffset as nvarchar(20) ) AS T1_datetimeoffset
from T1


   INSERT INTO T1 (T1_datetime, T1_smalldatetime, T1_time, T1_date, T1_datetime2, T1_datetimeoffset ) 
   VALUES ('2001-01-01 10:11:12.500', '2002-01-01', '00:01:02.100', '2003-01-01 20:11:12.500', '2004-01-01 20:21:12.500', '2005-01-01 21:22:12.500')




*/