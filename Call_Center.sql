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

set @total_Problem = (select CONVERT(decimal,count(Resolved)) from Call_Data
group by Resolved);

set @Resolve = (
select  CONVERT(decimal,count(Resolved))  from Call_Data
where  Resolved = 'Yes'
group by Resolved);

set @Not_Resolve = (
select   CONVERT(decimal,count(Resolved))  from Call_Data
where  Resolved = 'No'
group by Resolved);

select (@Resolve / @total_Problem) *100 as 'Percent Total Resolve Problems' ,
(@Not_Resolve / @total_Problem) *100 as 'Percent Total Not Resolve Problems' 
end

drop Procedure Avg_Resolved

exec Avg_Resolved;
