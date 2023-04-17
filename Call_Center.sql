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

