-- Active: 1671708805339@@127.0.0.1@3308@ram_db



--date time functions 


--returning current date and time

-----CURDATE()

select CURDATE(); --2022-12-27

select CURRENT_DATE(); --2022-12-27


select now(); --2022-12-27 16:41:12

select sysdate(); --2022-12-27 16:41:13

select current_timestamp(); --2022-12-27 16:41:14




--returning date and time parts 


select DATE(now()); --2022-12-27
select TIME(CURRENT_TIMESTAMP());--16:45:50


select year(now()); --2022

select month(now()); --12

select monthname(now()); --December

select day(now());  --27

select dayname(now()); --Tuesday


--find out employees joined on tuesday 
select * from emp;
select ename,hiredate from emp where dayname(hiredate)="Tuesday";

--find out employees who joined in December
select ename,hiredate from emp where monthname(hiredate)="December";

--find out employees who joined in 1981 and ename not containing "s"

select ename,hiredate from emp where year(hiredate)=1981 and ename NOT LIKE "%s%";


select HOUR(now());--16 

select Minute(now()); --57

select QUARTER(now()); --4
--

--------DATE_FORMAT()
-- %a => 3 letter day  
-- %W =>
-- %b => 3 letter month  
-- %c => month in digit
-- %M => full month  
-- %y => 2 digits year  
-- %Y => 4 digit year 
-- %d => day count in month  
-- %D =>adds th,rd to date
-- %w => day count in week  
-- %j => day count in a year  



-- STR_TO_DATE() --converts date to string  

select str_to_date("10-may-2022","%d-%M-%Y"); --2022-05-10


---find out the employees who joined in leap year  

-----find the year and cocat with "-12-31" and find the day count using %j

use ram_db;
select hiredate,date_format(hiredate,'%D') from emp;

--Findout employees who join 1st thursday;
select date_format(now(),"%w");

select ename,hiredate from emp where date_format(hiredate,"%w")=4 and (date_format(hiredate,"%d") between 1 and 7);

select ename from emp where DATE_FORMAT(CONCAT(year(hiredate),"-12-31"),"%j")=366;


--enmae joined on 17th , thursday,december 1980

select CONCAT(ename," joined on ",date_format(hiredate,"%D")," ,",dayname(hiredate)," ",date_format(hiredate,"%M")," ",year(hiredate)) from emp;



select * from emp ORDER by COMM desc;



--EXTRACT 

select extract(year from now());

select extract(year from hiredate) from emp;

select extract(month from hiredate) from emp;

select extract(day from hiredate) from emp;



------------------------------------------------------


---returning diff between date 

--DATEDIFF(date1,date2)  ---takes 2 arguments only date1 and date2
select datediff(now(),"1999-05-28");  --op in days 

--TIMESTAMPDIFF --takes 3 arguments year ,month, day

select timestampdiff(year,"1999-05-28",now());

select timestampdiff(month,"1999-05-28",now());-- op in months

select timestampdiff(day,"1999-05-28",now()); --op in days



----display how many years months old are you 

set @dob ="2022-12-30";

select timestampdiff(year,@dob,now());




--modifying dates 

-- date_add  

select date_add(curdate(),INTERVAL '1' year);

select date_sub(now(),INTERVAL '2' year);


select date_add(@dob,INTERVAL '2' month);

select date(date_sub(now(),INTERVAL '1' day));


--last_day() 

select last_day(now()); ---2022-12-31


--makedate(year,days)

select makedate(2022,61); --2022-03-02


---CONTROL functions 
/*
if 
case
null if 
ifnull
*/

--IF(A,B,C) --IF A is true returns B else C 

select ename,sal ,IF(sal>3000,"goodsal","lowsal") from emp;


select ename,sal,comm ,if((sal>=comm),"moresal","morecomm") from emp;



/* CASE WHEN <cond1> THEN <val>
   .. 
   ..  
   ELSE <val> 

*/


select ename,sal,job, 
(case when job="clerk" then 1.5*sal 
 when job="salesman" then 2.0*sal
 when job="analyst" then 1.75*sal 
 else sal  
 end) AS bonus from emp
 order by job;


 ---using case functions print 


 set @dt="2023-12-30";

 select @dt,now(),
 CASE 
      WHEN  DATEDIFF(@dt,now())=0 THEN REPEAT("happy birthday ",5)
      WHEN  DATEDIFF(@dt,now())<0 THEN REPEAT("belated birthday ",2) 
      
       
 ELSE "adavnce birthday " END AS mesg;

 select DATEDIFF(@dt,now());



--NULLIF(A,B) ---IF A=B returns null else A 

set @A=100 ,@B=200,@C=100;


select NULLIF(@A,@B); --100  

select nullif(@A,@C); --NULL


--ifnull(A,B)---if A is null returns B  


select ename,sal,comm,sal+comm,ifnull((sal+comm),sal) from emp;