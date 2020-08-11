-- *************************** START OF THE ASSIGNMENT *****************************

drop schema assignment;


-- Creating a Schema named 'Assignment'
Create schema Assignment;


-- Initiating the schema
use assignment;
set SQL_SAFE_UPDATES = 0;  # This ensures that columns are updated without error 

# The given Stock Market tables are imported completely using Import Table Wizard 

/* Creating the tables for each company stock data:
Validating the BASE tables are created with the names as :bajaj, eicher, hero, infosys, tcs, tvs
We are using the MySQL Import Wizard to create table for each stock:
Also we will be taking only two columns date and close price from the CSV data file while importing:*/


---------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. (This has to be done for all 6 stocks)
---------------------------------------------------------------------------------------------------------------------------------------------------

-- Creating Table bajaj1
create table assignment.bajaj1 
select str_to_date(Date, '%d-%M-%Y') as `Date`, round(`Close Price`,2) as 'Close Price',
		round(avg(`Close Price`) over (order by STR_TO_DATE(Date, '%d-%M-%Y') asc rows 19 preceding),2) as `20 Day MA`, #Calculating 20 day moving average
		round(avg(`Close Price`) over (order by STR_TO_DATE(Date, '%d-%M-%Y') asc rows 49 preceding),2) as `50 Day MA`  #Calculating 50 day moving average
from bajaj;

Select * from Bajaj1; 		#Displaying Bajaj1 Table 


-- Creatibg Table Eicher1
create table assignment.eicher1 
select str_to_date(Date, '%d-%M-%Y') as `Date`, round(`Close Price`,2) as 'Close Price',
		round(avg(`Close Price`) over (order by STR_TO_DATE(Date, '%d-%M-%Y') asc rows 19 preceding),2) as `20 Day MA`, #Calculating 20 day moving average
		round(avg(`Close Price`) over (order by STR_TO_DATE(Date, '%d-%M-%Y') asc rows 49 preceding),2) as `50 Day MA`  #Calculating 50 day moving average
from eicher;

Select * from Eicher1; 		#Displaying Eicher1 Table 


-- Creating Table Hero1
create table assignment.hero1 
select str_to_date(Date, '%d-%M-%Y') as `Date`, round(`Close Price`,2) as 'Close Price',
		round(avg(`Close Price`) over (order by STR_TO_DATE(Date, '%d-%M-%Y') asc rows 19 preceding),2) as `20 Day MA`, #Calculating 20 day moving average
		round(avg(`Close Price`) over (order by STR_TO_DATE(Date, '%d-%M-%Y') asc rows 49 preceding),2) as `50 Day MA`  #Calculating 50 day moving average
from hero;

Select * from hero1; 		#Displaying Hero1 Table


-- Creating Table Infosys1
create table assignment.infosys1 
select str_to_date(Date, '%d-%M-%Y') as `Date`, round(`Close Price`,2) as 'Close Price',
		round(avg(`Close Price`) over (order by STR_TO_DATE(Date, '%d-%M-%Y') asc rows 19 preceding),2) as `20 Day MA`, #Calculating 20 day moving average
		round(avg(`Close Price`) over (order by STR_TO_DATE(Date, '%d-%M-%Y') asc rows 49 preceding),2) as `50 Day MA`  #Calculating 50 day moving average
from infosys;

Select * from Infosys1; 	#Displaying Infosys1 Table


-- Creating Table Tcs1
create table assignment.tcs1 
select str_to_date(Date, '%d-%M-%Y') as `Date`, round(`Close Price`,2) as 'Close Price',
		round(avg(`Close Price`) over (order by STR_TO_DATE(Date, '%d-%M-%Y') asc rows 19 preceding),2) as `20 Day MA`, #Calculating 20 day moving average
		round(avg(`Close Price`) over (order by STR_TO_DATE(Date, '%d-%M-%Y') asc rows 49 preceding),2) as `50 Day MA`  #Calculating 50 day moving average
from tcs;

Select * from Tcs1; 		#Displaying Tcs1 Table


-- Creating Table Tvs1
create table assignment.tvs1 
select str_to_date(Date, '%d-%M-%Y') as `Date`, round(`Close Price`,2) as 'Close Price',
		round(avg(`Close Price`) over (order by STR_TO_DATE(Date, '%d-%M-%Y') asc rows 19 preceding),2) as `20 Day MA`, #Calculating 20 day moving average
		round(avg(`Close Price`) over (order by STR_TO_DATE(Date, '%d-%M-%Y') asc rows 49 preceding),2) as `50 Day MA`  #Calculating 50 day moving average
from tvs;

Select * from Tvs1; 		#Displaying Tvs1 Table


---------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Create a master table containing the date and close price of all the six stocks. (Column header for the price is the name of the stock)
---------------------------------------------------------------------------------------------------------------------------------------------------

-- Creating Master Table
create table assignment.MASTER_TABLE
select b.date as Date, 
b.`Close Price` as Bajaj, 
t.`Close Price` as TCS, 
v.`Close Price` as TVS,
i.`Close Price` as Infosys, 
e.`Close Price` as Eicher,
h.`Close Price` as Hero
from bajaj1 as b
    inner join eicher1 as e on b.Date = e.Date             #Using Inner join on 'Date' to create master table
    inner join hero1 as h on e.Date  = h.Date
    inner join infosys1 as i on h.Date = i.Date
    inner join tcs1 as t on i.Date = t.Date
    inner join tvs1 as v on t.Date = v.Date;
    
select * from Master_Table; 		#Displaying Master Table
    

 ---------------------------------------------------------------------------------------------------------------------------------------------------
/* As per the assignment instruction "Please note that for the days where it is not possible to calculate the
required Moving Averages, it is better to ignore these rows rather than trying to deal with NULL by filling it 
with average value as that would make no practical sense."

So we will be updating the `20 Day MA` with NULL for less than 20 days and `50 Day MA` with NULL for less than 50 days 
as it does not make any sense to keep the moving average for these untill required number of days are reached. */

-- Turning OFF SQL Safe Update option, so UPDATE can be done without  key in the where clause:
 SET SQL_SAFE_UPDATES = 1;

#************************TABLE UPDATE USING STORED PROCEDURE *********************
drop procedure if exists UPDATE_TABLE;

delimiter |

CREATE PROCEDURE UPDATE_TABLE(in tbname varchar(20) )
BEGIN
 SET @update20day = CONCAT("UPDATE ", concat(tbname,'1'), " set `20 Day MA` = NULL limit 19 " );
 SET @update50day = CONCAT("UPDATE ", concat(tbname,'1'), " set `50 Day MA` = NULL limit 49 " );
 prepare u from @update20day;
 execute u;
 deallocate prepare u;
 prepare up from @update50day;
 execute up;
 deallocate prepare up;

END|
delimiter ;
-- **********************************************************************************

-- **********************************************************************************
-- Calling the procedure and passing the table names to update NULL for moving average:
call UPDATE_TABLE('bajaj');
call UPDATE_TABLE('eicher');
call UPDATE_TABLE('hero');
call UPDATE_TABLE('infosys');
call UPDATE_TABLE('tcs');
call UPDATE_TABLE('tvs');

select * from bajaj1;   


---------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Use the table created in Part(1) to generate buy and sell signal. Store this in another table named 'bajaj2'. Perform this operation for all stocks.
---------------------------------------------------------------------------------------------------------------------------------------------------

/* The table consists of Date, Close Price and Signal. 
Signal was derived using moving averages calculated in previous steps.
Signal is generated only when there is a crossing point 
i.e. 20 days MA crosses the 50 days MA otherwise signal is HOLD.
To identify crossing points, previous row data along with current row is considered.*/


-- Creating Table bajaj2
Create Table Bajaj2
Select Date, `Close Price`,
Case
	when `20 Day MA` > `50 Day MA` and LAG(`20 Day MA`,1) over W <= LAG(`50 Day MA`,1) over W then 'BUY'
    when `20 Day MA` < `50 Day MA` and LAG(`20 Day MA`,1) over W >= LAG(`50 Day MA`,1) over W then 'SELL'
    else 'HOLD'
end as `Signal`
from Bajaj1
Window W as (order by Date);

select * from bajaj2; 		#Displaying Bajaj2 table


-- Creating Table EICHER2
Create Table eicher2
Select Date, `Close Price`,
Case
	when `20 Day MA` > `50 Day MA` and LAG(`20 Day MA`,1) over W <= LAG(`50 Day MA`,1) over W then 'BUY'
    when `20 Day MA` < `50 Day MA` and LAG(`20 Day MA`,1) over W >= LAG(`50 Day MA`,1) over W then 'SELL'
    else 'HOLD'
end as `Signal`
from eicher1
Window W as (order by Date);

Select * from Eicher2; 		#Displaying Eicher2 table


-- Creating Table HERO2
Create Table hero2
Select Date, `Close Price`,
Case
	when `20 Day MA` > `50 Day MA` and LAG(`20 Day MA`,1) over W <= LAG(`50 Day MA`,1) over W then 'BUY'
    when `20 Day MA` < `50 Day MA` and LAG(`20 Day MA`,1) over W >= LAG(`50 Day MA`,1) over W then 'SELL'
    else 'HOLD'
end as `Signal`
from hero1
Window W AS (order by Date);

Select * from hero2; 		#Displaying hero2 table


-- Creating Table INFOSYS2
Create Table infosys2
Select Date, `Close Price`,
Case
	when `20 Day MA` > `50 Day MA` and LAG(`20 Day MA`,1) over W <= LAG(`50 Day MA`,1) over W then 'BUY'
    when `20 Day MA` < `50 Day MA` and LAG(`20 Day MA`,1) over W >= LAG(`50 Day MA`,1) over W then 'SELL'
    else 'HOLD'
end as `Signal`
from infosys1
Window W AS (order by Date);

Select * from infosys2; 	#Displaying infosys2 table


-- Creating Table TCS2
Create Table tcs2
Select Date, `Close Price`,
Case
	when `20 Day MA` > `50 Day MA` and LAG(`20 Day MA`,1) over W <= LAG(`50 Day MA`,1) over W then 'BUY'
    when `20 Day MA` < `50 Day MA` and LAG(`20 Day MA`,1) over W >= LAG(`50 Day MA`,1) over W then 'SELL'
    else 'HOLD'
end as `Signal`
from tcs1
Window W AS (order by Date);

Select * from tcs2; 		#Displaying tcs2 table


-- Creating Table TVS2
Create Table tvs2
Select Date, `Close Price`,
Case
	when `20 Day MA` > `50 Day MA` and LAG(`20 Day MA`,1) over W <= LAG(`50 Day MA`,1) over W then 'BUY'
    when `20 Day MA` < `50 Day MA` and LAG(`20 Day MA`,1) over W >= LAG(`50 Day MA`,1) over W then 'SELL'
    else 'HOLD'
end as `Signal`
from tvs1
Window W AS (order by Date);

Select * from tvs2; 		#Displaying tvs2 table 


---------------------------------------------------------------------------------------------------------------------------------------------------
-- 4. Create a User defined function, that takes the date as input and returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock.
---------------------------------------------------------------------------------------------------------------------------------------------------

/*Following function searches the input date in the table 
and returns the respective BUY, SELL or HOLD Signal*/

-- Function definition
delimiter //
Create Function bajaj_signal(`input_date` text) returns VARCHAR(10) 
    deterministic
Begin
return (select `Signal` from bajaj2  where `date`=`input_date`);
 End //
 
 delimiter ;
 
 -- ***********Calling the function to determine sample signal for a date***********
select bajaj_signal(str_to_date('18-05-2015','%d-%m-%Y')) as 'STOCK SIGNAL';

-- *************************** END OF THE ASSIGNMENT *****************************
