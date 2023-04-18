/*
Project Name: Call Center
Data Set: https://www.mediafire.com/file/em7bnwhmf31o73u/01_Call-Center-Dataset.xlsx/file?dkey=xyvbhmulasf&r=621
*/

create database Call_Center;
use Call_Center;
select * from Call_Data;


-- Procedure For Percent Answered_call
Create procedure  Answered_call
as
begin
-- Total Call
Declare @Total_Call as  DECIMAL ;
Set @Total_Call = (
select Count([Answered (Y/N)]) from Call_Data);

-- Number  Answered call
Declare @Total_Answered_Call as  DECIMAL ;
set @Total_Answered_Call = (
select Count([Answered (Y/N)]) as 'Total Answered' from Call_Data
where [Answered (Y/N)] = 'Yes');

-- Number Not Answered call
Declare @Total_Not_Answered_Call as  DECIMAL;
Set @Total_Not_Answered_Call = (
select Count([Answered (Y/N)]) as 'Total Not Answered'  from Call_Data
where [Answered (Y/N)] = 'No');

select @Total_Answered_Call as 'Total Answered Call', @Total_Not_Answered_Call as 'Total Not Answered Call' , ((@Total_Answered_Call/@Total_Call) *100) as 'Percent Total Answered Call' , 
((@Total_Not_Answered_Call/@Total_Call) *100) as'Percent Total Not Answered Call' ;
end

drop procedure  Answered_call;


-- Execute Procedure to Retrieve Percent Answered Call
exec  Answered_call;


-- Topic
select Topic , count(Topic) as 'Number Of Call Per Topic'  from Call_Data
group by Topic
order by 2 desc;


-- Avg Speed Of Answer
select ROUND(AVG([Speed of answer in seconds]),2) as 'Avrge Speed Of Answer In Seconds' from Call_Data;


-- Number Of Call Time (AM , PM)
select [Call Time] , count([Call Time]) from Call_Data
group by [Call Time]
order by 2 desc;


select Resolved , count(Resolved) from Call_Data
group by Resolved; 



Create Procedure Avg_Resolved
as 
begin
declare @total_Problem decimal;
declare @Resolve decimal;
declare @Not_Resolve decimal;
declare @exp1 decimal;
declare @exp2 decimal;
set @total_Problem = (select CONVERT(decimal,count(Resolved)) from Call_Data);

set @Resolve = (
select  CONVERT(decimal,count(Resolved))  from Call_Data
where  Resolved = 'Yes'
group by Resolved);

set @Not_Resolve = (
select   CONVERT(decimal,count(Resolved))  from Call_Data
where  Resolved = 'No'
group by Resolved);

select ROUND(((@Resolve / @total_Problem)*100),2 ) ,  ROUND(((@Not_Resolve / @total_Problem)*100),2 ) 
end

drop Procedure Avg_Resolved

exec Avg_Resolved;

select count(Resolved) from Call_Data 

--'Percent Total Resolve Problems'  as 'Percent Total Not Resolve Problems' 


-- [Satisfaction Rating]
select [Satisfaction rating] , count([Satisfaction rating]) from Call_Data 
group by [Satisfaction rating]
order by 1;


select * from Call_Data;

-- Number Of Call Per Day
select [Day Name] ,  COUNT([Day Name]) as Count_Days from Call_Data
group by [Day Name]
order by 1 asc ;

select  [Month Name] ,  COUNT([Month Name]) as Count_Month from Call_Data
group by [Month Name]
order by 1 asc ;


-- -- Number Of Calls Per Time Day
select  [Call Time] , COUNT([Call Time]) as Count_Time from Call_Data
group by [Call Time]
order by 1 asc ;

-- if condition 
declare @count int;
set @count = (select COUNT([Call Time]) as Count_Time from Call_Data)
if  @count >= 5000
begin 
	select  [Call Time] , COUNT([Call Time]) as Count_Time from Call_Data
	group by [Call Time]
	order by 1 asc ;
        PRINT 'Great! Number Of Calls Per Time Day is greater than 5000';
end


else 

	begin
		  PRINT 'Number Of Calls Per Time Day  did not reach 5000';
	end


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
select  [Call Id] , Topic , Resolved from Call_Data;

-- Where Condtion (search condition to filter rows)
select  [Call Id] , Topic , Resolved from Call_Data
where Resolved = 'Yes';

-- update (To modify existing data in a table)
update Call_Data
set Resolved = 'No'
where [Call Id] = 'ID0898';

-- Alter ( remove one or more columns from existing table)
alter table Call_Data
drop column F17 , F18 ;

ALTER TABLE Call_Data
ALTER COLUMN date date;


-- order by (The only way for you to guarantee that the rows in the result set are sorted)
select  [Call Id] , Topic , Resolved from Call_Data
where Resolved = 'Yes'
order by 2;

-- group by (clause allows you to arrange the rows of a query in groups.)
select   Resolved ,COUNT(Resolved) from Call_Data
where Resolved = 'Yes'
group by Resolved
order by 2;

-- distinct (get only distinct values in a specified column of a table)
select distinct(Topic) from Call_Data;


-- Top (N) (allows you to limit the number of rows or percentage of rows returned in a query result set.)
select top 5 * from Call_Data;

-- Operation  (And / OR)
select  [Call Id] , Topic , Resolved from Call_Data
where Resolved = 'Yes' and Topic Like  'A%' or Topic Like '%d'
order by 2;


-- SubQuery (uses the values of the outer query.)
select  [Call Id] , Topic , Resolved from Call_Data
where Resolved  =
(Select Resolved from Call_Data
where [Call Id] = 'ID0930')
order by 2;


-- Methods 
/*
Cast( var as data_type)
Convert(data_type , var)
Trim -> «“«·Â «·„”«›«  «·“«∆œÂ 
*/


Select UPPER(Agent) , LOWER([Month Name]) ,CONCAT([Month Name],'-',[Day Name]) from Call_Data;