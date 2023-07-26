/*
Project Name: Call Center
Data Set: https://www.mediafire.com/file/em7bnwhmf31o73u/01_Call-Center-Dataset.xlsx/file?dkey=xyvbhmulasf&r=621
*/
CREATE DATABASE Call_Center;

USE Call_Center;

SELECT *
FROM Call_Data;

-- Procedure For Percent Answered_call
CREATE PROCEDURE Answered_call
AS
BEGIN
	-- Total Call
	DECLARE @Total_Call AS DECIMAL;

	SET @Total_Call = (
			SELECT Count([Answered (Y/N)])
			FROM Call_Data
			);

	-- Number  Answered call
	DECLARE @Total_Answered_Call AS DECIMAL;

	SET @Total_Answered_Call = (
			SELECT Count([Answered (Y/N)]) AS 'Total Answered'
			FROM Call_Data
			WHERE [Answered (Y/N)] = 'Yes'
			);

	-- Number Not Answered call
	DECLARE @Total_Not_Answered_Call AS DECIMAL;

	SET @Total_Not_Answered_Call = (
			SELECT Count([Answered (Y/N)]) AS 'Total Not Answered'
			FROM Call_Data
			WHERE [Answered (Y/N)] = 'No'
			);

	SELECT @Total_Answered_Call AS 'Total Answered Call'
		,@Total_Not_Answered_Call AS 'Total Not Answered Call'
		,((@Total_Answered_Call / @Total_Call) * 100) AS 'Percent Total Answered Call'
		,((@Total_Not_Answered_Call / @Total_Call) * 100) AS 'Percent Total Not Answered Call';
END

DROP PROCEDURE Answered_call;

-- Execute Procedure to Retrieve Percent Answered Call
EXEC Answered_call;

-- Topic
SELECT Topic
	,count(Topic) AS 'Number Of Call Per Topic'
FROM Call_Data
GROUP BY Topic
ORDER BY 2 DESC;

-- Avg Speed Of Answer
SELECT ROUND(AVG([Speed of answer in seconds]), 2) AS 'Avrge Speed Of Answer In Seconds'
FROM Call_Data;

-- Number Of Call Time (AM , PM)
SELECT [Call Time]
	,count([Call Time])
FROM Call_Data
GROUP BY [Call Time]
ORDER BY 2 DESC;

SELECT Resolved
	,count(Resolved)
FROM Call_Data
GROUP BY Resolved;

CREATE PROCEDURE Avg_Resolved
AS
BEGIN
	DECLARE @total_Problem DECIMAL;
	DECLARE @Resolve DECIMAL;
	DECLARE @Not_Resolve DECIMAL;
	DECLARE @exp1 DECIMAL;
	DECLARE @exp2 DECIMAL;

	SET @total_Problem = (
			SELECT CONVERT(DECIMAL, count(Resolved))
			FROM Call_Data
			);
	SET @Resolve = (
			SELECT CONVERT(DECIMAL, count(Resolved))
			FROM Call_Data
			WHERE Resolved = 'Yes'
			GROUP BY Resolved
			);
	SET @Not_Resolve = (
			SELECT CONVERT(DECIMAL, count(Resolved))
			FROM Call_Data
			WHERE Resolved = 'No'
			GROUP BY Resolved
			);

	SELECT ROUND(((@Resolve / @total_Problem) * 100), 2)
		,ROUND(((@Not_Resolve / @total_Problem) * 100), 2)
END

DROP PROCEDURE Avg_Resolved

EXEC Avg_Resolved;

SELECT count(Resolved)
FROM Call_Data

--'Percent Total Resolve Problems'  as 'Percent Total Not Resolve Problems' 
-- [Satisfaction Rating]
SELECT [Satisfaction rating]
	,count([Satisfaction rating])
FROM Call_Data
GROUP BY [Satisfaction rating]
ORDER BY 1;

SELECT *
FROM Call_Data;

-- Number Of Call Per Day
SELECT [Day Name]
	,COUNT([Day Name]) AS Count_Days
FROM Call_Data
GROUP BY [Day Name]
ORDER BY 1 ASC;

SELECT [Month Name]
	,COUNT([Month Name]) AS Count_Month
FROM Call_Data
GROUP BY [Month Name]
ORDER BY 1 ASC;

-- -- Number Of Calls Per Time Day
SELECT [Call Time]
	,COUNT([Call Time]) AS Count_Time
FROM Call_Data
GROUP BY [Call Time]
ORDER BY 1 ASC;

-- if condition 
DECLARE @count INT;

SET @count = (
		SELECT COUNT([Call Time]) AS Count_Time
		FROM Call_Data
		)

IF @count >= 5000
BEGIN
	SELECT [Call Time]
		,COUNT([Call Time]) AS Count_Time
	FROM Call_Data
	GROUP BY [Call Time]
	ORDER BY 1 ASC;

	PRINT 'Great! Number Of Calls Per Time Day is greater than 5000';
END
ELSE
BEGIN
	PRINT 'Number Of Calls Per Time Day  did not reach 5000';
END

------------------------------------------------
/* Beginners (Basics) */
--1 select 
--2 update 
--3 delete 
--4 where
--5 order by
--6 group by
--7 distinct 
--8 Top 
--9 SubQuery
--10 operation (> , < , = , >= , <= , <> , And , OR , Betweet  and , in , Alias)
--11 Methods (Upper , Lower , Concat , Trim )
--12 alter
-- Select (To Retrieve Data From Tabel)
SELECT [Call Id]
	,Topic
	,Resolved
FROM Call_Data;

-- Where Condtion (search condition to filter rows)
SELECT [Call Id]
	,Topic
	,Resolved
FROM Call_Data
WHERE Resolved = 'Yes';

-- update (To modify existing data in a table)
UPDATE Call_Data
SET Resolved = 'No'
WHERE [Call Id] = 'ID0898';

-- Alter ( remove one or more columns from existing table)
ALTER TABLE Call_Data

DROP COLUMN F17
	,F18;

ALTER TABLE Call_Data

ALTER COLUMN DATE DATE;

-- order by (The only way for you to guarantee that the rows in the result set are sorted)
SELECT [Call Id]
	,Topic
	,Resolved
FROM Call_Data
WHERE Resolved = 'Yes'
ORDER BY 2;

-- group by (clause allows you to arrange the rows of a query in groups.)
SELECT Resolved
	,COUNT(Resolved)
FROM Call_Data
WHERE Resolved = 'Yes'
GROUP BY Resolved
ORDER BY 2;

-- distinct (get only distinct values in a specified column of a table)
SELECT DISTINCT (Topic)
FROM Call_Data;

-- Top (N) (allows you to limit the number of rows or percentage of rows returned in a query result set.)
SELECT TOP 5 *
FROM Call_Data;

-- Operation  (And / OR)
SELECT [Call Id]
	,Topic
	,Resolved
FROM Call_Data
WHERE Resolved = 'Yes'
	AND Topic LIKE 'A%'
	OR Topic LIKE '%d'
ORDER BY 2;

-- SubQuery (uses the values of the outer query.)
SELECT [Call Id]
	,Topic
	,Resolved
FROM Call_Data
WHERE Resolved = (
		SELECT Resolved
		FROM Call_Data
		WHERE [Call Id] = 'ID0930'
		)
ORDER BY 2;

-- Methods 
/*
Cast( var as data_type)
Convert(data_type , var)
Trim -> «“«·Â «·„”«›«  «·“«∆œÂ 
*/
SELECT UPPER(Agent)
	,LOWER([Month Name])
	,CONCAT (
		[Month Name]
		,'-'
		,[Day Name]
		)
FROM Call_Data;