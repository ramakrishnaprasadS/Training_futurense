-- Active: 1671708805339@@127.0.0.1@3308@banking

CREATE DATABASE IF NOT EXISTS today27 ;

show databases;


use today27;

CREATE TABLE samp1
(
   id int(5),
   fname varchar(10),
   age int(5)
);

DROP TABLE samp1;
DELETE FROM samp1;

select * from samp1;

ALTER TABLE samp1 ADD constraint `samp1_PK` PRIMARY KEY(id);
ALTER TABLE samp1 ADD constraint `samp1_age_chk18` check(age>=18);
INSERT INTO samp1(id,fname,age) values
(1,"ram",24),
(2,"john",18),
(4,"hari",23),
(3,"sekhar",23);



-- DATABASE 
   --for storing data DDL,DCL,TC
   /* SELECT (projection) *
    FROM table_name */


use ram_db;

show tables;
ABS
select *
 from emp1;

 select DISTINCT(deptno) from emp1;

 --DISTINCT applied on only on 1st column
 

--# wrong --select DISTINCT(deptno),DISCTINCT(job) from emp;


--based on first column second column having duplicates are displayed only once    

--distinct combos of deptno and job are displayed by below query....
 select DISTINCT(deptno),job from emp;


--in mysql column names are displayed as we give in query by default 
-- to chnage column names 
-- ename "Employee Name"   
-- ename AS "employee Name" 


select ename,sal,sal+10000 AS increment_salary from emp;


select 
ename,
sal,
(0.4*sal) AS hra,
(0.3*sal) AS da,
(0.12*sal) AS pf,
(0.1*sal) AS tax,
(0.4*sal)+(0.3*sal)+(0.12*sal)-(0.1*sal)-(0.4*sal) AS total_sal from emp; 


--SET
-- SET @v1=20;
-- SET @v2=3000 ,@v3=4000; 

SET @value1=1250;

select * from emp where sal=@value1;


--SET @hra=(0.4*sal),
-- @da=(0.3*sal) ;
--(0.12*sal) AS pf,
--(0.1*sal) AS tax,

SET @hra =0.4;
SET @da=0.3;

SET @pf=0.12;

SET @tax=0.1;

select ename,sal,(@hra*sal) AS hra,(@da*sal) AS da, (@hra*sal)+(@da*sal) AS total_sal
from emp;



--ORDER BY ASC,DESC,column_name,alias_name;


select ename,sal from emp ORDER BY ename DESC; --based on column name 

select ename,deptno,job from emp ORDER BY 2,3 desc; --sorted based on column2 and then within them based on column3 

-- My sql does not support sorting based on alias name with "" 

select sal,ename AS empname from emp ORDER BY empname ;---works fine without quotes 

--LIMIT : limits the number of rows to display

select DISTINCT sal,ename,deptno,job from emp ORDER BY sal desc LIMIT 3;


--select DISTINCT sal,ename,deptno,job from emp ORDER BY sal desc LIMIT no_of_rows_to_be_skipped,rows_to_be_displayed;
use ram_db;
select ename from emp;

select ename from emp limit 3,3;

/*sql functions
1.single row functions
   - character func 
   - number functions
   - control functions 
   - date functions

2.multiple row functions
*/ 

--1.a charcter functions
--   CONCAT(col1,"",col2,...)


select CONCAT(ename,"\'s  job is ",job) AS "emp and his job" from emp;


--UPPER and lower functions

select lower(ename) from emp;

select upper("rama krishna"); --works fine in sql 

select lower("RAMA") from dual; --works fine in sql also ..

--SUBSTR (string,start_pos,end_pos)

select SUBSTR("pythonApplication",1); --starting from 1 till end

select SUBSTR("pythonApplication",1,6); --starting from 1 till end pos


--LENGTH 


select ename ,SUBSTR(ename,1,1) "fisrt_char" ,SUBSTR(ename,LENGTH(ename)) AS last_char from emp;

--last char of ename in lower 

select ename, CONCAT(lower(SUBSTR(ename,1,LENGTH(ename)-1)),SUBSTR(ename,-1))  AS new_name from emp;

select CONCAT(lower(RIGHT(ename,length(ename)-1)),LEFT(ename,1)) AS new_name from emp;



--INSTR --position first occurance of specified substring in given string


select INSTR("Javascript","a");

--find ename where last charcter is getting repeated 

select ename, INSTR(ename,SUBSTR(ename,-1)) as pos_of_lastchar from emp
where INSTR(ename,SUBSTR(ename,-1))<length(ename);

--LEFT/RIGHT --displays string from left/right to specified length 

select LEFT("pythonprograming",6);  --python 

select RIGHT("pythonprogramming",6);  --amming 


--TRIM --trims the spaces or character in beginning and at the end of the string

select TRIM("  rama krishna  "); --rama krishna--

select LTRIM("   rama krishna  "); --rama krishna  --

select RTRIM("   rama krishna  ");--   rama krishna--


select TRIM("h" from "helloh"); --ello 


--REPLACE 

select REPLACE("python is a programming language","program","non-program");--python is a non-programming language

--find no. of occurances of "A" in "MARY HAD A LITTLE LAMB"

set @str="MARY HAD A LITTLE LAMB";

select length(@str)-length(REPLACE(@str ,"A","")) AS cnt;

--reporting functions
--LPAD/RPAD --left/right padding with specified character to specified length   



select dname, lpad(dname,15,"*") as lpad, rpad(dname,15,"$") as rpad from dept;


--REPEAT --can repeat the string n number of times--

select repeat("ram ",20);


--REVERSE 

select REVERSE("Python");--nohtyP


------------------------------------------NUMBER functions -------------------

--MOD --gives remainder 

select empno from emp  where MOD(empno,2)=1 ;

--SIGN 
/* A=B 0
   A>B 1
   A<B -1  */


set @v1=10,@v2=30,@v3=10;

select SIGN(@v1-@v2),SIGN(@v1-@v3),SIGN(@v3-@v2);


--select employees who are taking commission more than the salary COMMENT

select * from emp;

select ename,comm,sal from emp where SIGN(comm-sal)=1;

--ABS --absolute value

select ABS(-98); --98


select ASCII("A"); --65

select CHAR(97); --a

select CHAR(97 using ascii); --a   -----works any where


--ROUND

select ROUND(157.258,1); --157.3 

select CEIL(157.258); --158

select ROUND(157.258,-3); --200 --  -1 gives nearest 10s........-2 gives nearest 100s ......-3 gives 0


--TRUNCATE 

select TRUNCATE(157.258,-2); --  100

select TRUNCATE(157.258,-1);  --  150

--CEIL and FLOOR 

select floor(157.258);  --157



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


---Aggregate functions --  count min max avg sum 

-- in mysql we need to set @@sal_mode="only_full_group_by"; to over come the default setting partial group by  


set @@sal_mode="only_full_group_by";


--COUNT(*) --includes null 
--COUNT(column) --does not include null 

--count min max can be used for all data types 

-- sum,avg is used for only number datatypes  


select * from emp;


select count(empno) from emp where job="clerk";

select min(sal),min(hiredate),min(ename) from emp;

select max(sal),max(hiredate),max(ename) from emp;

select sum(sal),avg(sal),sum(sal)/count(empno) from emp;

select deptno,sum(sal) from emp group by deptno;


 select deptno,sum(sal) from emp group by deptno;


 select count(empno) as no_of_emp,year(hiredate) from emp group by year(hiredate);

--no of emp joined in each year each quarter
 select count(empno) as no_of_emp,year(hiredate),quarter(hiredate) from emp group by year(hiredate),quarter(hiredate) order by year(hiredate);

select count(empno) as no_of_emp, date_format(hiredate,"%b") as mnth from emp 
group by mnth ,date_format(hiredate,"%m") order by date_format(hiredate,"%m") ;

---------------------------------------------------------pending
desc emp;
select job,
CASE 
   when job="clerk" then count(ename)
   when job="salesman" then max(sal)
   when job="analyst" then min(sal) 

else 0 end as clmn from emp group by job;  --working

select 
job,
CASE JOB
     when "clerk" then COUNT(empno)
     when "salesman" then max(sal)  
     when "analyst" then min(sal) 
     else min(sal)                           
     END as clmn  
from emp
group by job;

---avergae sal of all departments employing more than 5 people

select count(empno) from emp group by deptno;

select avg(sal) from emp group by deptno having count(empno)>5 ;


--list jobs all employees where max sal is greater than or equal to 3000;

select job,sal from emp where job="manager";
--pending
select job,sal from emp where sal>=3000;

select job from emp group by job having max(sal)>=3000;


select sign(32);


/*list the total,min,max,avg salary of all employees job wise for deptno 20
  and display those rows having avg salary greater than 1000*/

select sum(sal),job from emp where deptno=20 group by job;
 select 
job,
sum(sal),
min(sal),
max(sal), 
avg(sal) as avg_sal
 from emp 
 where deptno=20 
 group by job
having avg_sal>1000;


/*list the number of people along with enames having 'S' in their name*/ 
use ram_db;
select ename from emp
where ename like "%S%";


select count(ename) from emp
where ename like "%S%";


/* Display no of people along with the job which contains only one person in that job*/


select job,count(empno) as cnt
from emp 
group by job
having cnt=1;

/* Display job along with minimum salary which has minimum salary greater than or equal to 3000*/

select job,min(sal) as min_sal
from emp  
group by job
having min_sal>=3000;



---SET OPERATORS 

--A={1,2,3,4}
--B={4,5}
--AUB = {1,2,3,4,5}
--A interset B ={4}


-- to select data from similar select statements  

--rules
/* 1.number of columns should be same in all select statements 

   types:
   union
   union all 
   intersection (8.0.31 version mysql)*/

select distinct job from emp where deptno in (10,20);


select job from emp where deptno=10 
union                                    --without duplicates
select job from emp where deptno=20;



select job from emp where deptno=10 
union all                                   --with duplicates
select job from emp where deptno=20;


select job from emp where deptno=10 
INTERSECT 
select job from emp where deptno=20;


select job from emp where deptno=10 
union                                    --without duplicates
select job from emp where deptno=20
UNION
select job from emp where deptno=30; 


select ename,null as job from emp 
union 
select null,dname from dept;  --column heading comes from first select statement


/*find out total salary for each job as well as total salary*/

select job,sum(sal) as total from emp  
group by job
union 
select null ,sum(sal) from emp;

--ROLLUP
select job,sum(sal) from emp GROUP BY job with rollup;


--rollup gives summary value for first column only 
select sum(sal),deptno,job 
from emp 
group by deptno,job with rollup;



select sum(sal),deptno,job 
from emp 
group by deptno,job with rollup
union  
select sum(sal),deptno,job 
from emp 
group by job,deptno with rollup;

/*  ORDER BY 

   -it should be used after all select statements 
   -but it works only for first select statement*/

select ename from emp 
union 
select dname from dept
order by dname;           --does'nt work as order by works for firts select STATEMENT


select ename from emp 
union 
select dname from dept
order by ename;         --works fine  

/* JOIN --> to select data from multiple tables  

   types of syntaxes:
     1. ORACLE PROPRIETARY SYNTAX
         EQUI
         OUTER
         NON EQUI 
         CARTESIAN  
         SELF  
     2.SQL-99  
         INNER JOIN  
         OUTER JOIN  
         JOIN (DIFFERENT TABLES)  
         CROSS  
         JOIN  (SAME TABLES)  
         NATURAL 
         USING*/

/* RULES 
   1. column names should have the format  (for both syntaxes)
      e.name or emp.name 
      d.name or dept.name   
   2. Type of join to be specified (INNER,OUTER,NATURAL,CROSS...)
   3.join condition uses  on clause
   4.addittional conditions will be done using 
      AND operator
      WHERE clause */


-- INNER JOIN --join condition uses equal operator for join  

select  ename,emp.deptno,dname from emp  
inner join  
dept on emp.deptno=dept.deptno;


select  e.ename,e.deptno,d.dname from emp as e
inner join  
dept as d on e.deptno=d.deptno;

-- display above op only for sales  

select  e.ename,e.deptno,d.dname from emp as e
inner join  
dept as d on e.deptno=d.deptno
where d.dname="sales";

select  e.ename,e.deptno,d.dname from emp as e
inner join  
dept as d on e.deptno=d.deptno and d.dname="sales";

-- findout total salary  in sales and accounting department 

select sum(e.sal),d.dname from emp as e 
inner join  
dept as d 
on e.deptno=d.deptno where d.dname in ("sales","accounting")
group by d.dname;


--findout employees working in chicago as clerk  

select e.ename,d.loc from emp as e 
inner join dept as d 
on e.deptno=d.deptno 
where d.loc="chicago" and e.job="clerk";

--outer join = inner join + missing data  

insert into emp(empno,ename) values("2222",'y');



select e.ename,d.dname from emp as e 
right outer join  
dept as d  
on e.deptno = d.deptno;



select e.ename,d.dname from emp as e 
left outer join  
dept as d  
on e.deptno = d.deptno;



select e.ename,d.dname from emp as e 
right outer join  
dept as d  
on e.deptno = d.deptno
union 
select e.ename,d.dname from emp as e 
left outer join  
dept as d  
on e.deptno = d.deptno;



select e.ename,s.grade ,d.dname
from emp as e 
join salgrade as s 
on e.sal between s.losal and s.hisal 
inner join dept as d 
on e.deptno=d.deptno;

show tables;

show databases;
use hr_db;

show tables;

select * from countries;

select * from locations;

select * from regions;

select * from departments;

select * from employees;

select r.region_name ,c.country_name 
from regions as r  
inner join  
countries as c  
on r.region_id = c.region_id;



select c.country_name,l.city ,d.department_name,concat(e.first_name," ",e.last_name) as ename
from countries as c  
inner join locations as l  
on c.country_id = l.country_id  
inner join departments as d  
on l.location_id = d.location_id 
INNER JOIN employees as e  
on e.department_id = d.department_id;

--display employees name and to whom he reports to

select CONCAT(e.first_name," ",e.last_name) as ename , CONCAT(m.first_name," ",m.last_name) as reports_to
from employees as e  
join  
employees as m  
on e.employee_id = m.manager_id  ;


--display employees taking same salary 

select CONCAT(e.first_name," ",e.last_name) as ename , CONCAT(m.first_name," ",m.last_name) as reports_to,e.salary
from employees as e  
join  
employees as m  
on e.salary = m.salary and e.employee_id != m.employee_id  ;


--using sub query  

select p.ename,p.reports_to,p.sal from 
(select CONCAT(e.first_name," ",e.last_name) as ename , CONCAT(m.first_name," ",m.last_name) as reports_to,e.salary
from employees as e  
join  
employees as m  
on e.salary = m.salary and e.employee_id != m.employee_id) as p
GROUP BY p.ename,p.reports_to;


select CONCAT(first_name," ",last_name) as ename,salary from employees where 
salary in (select salary from employees group by salary having count(employee_id)>1);

show tables;

select month("2022-01-25");
select * from jobs;

select * from employees;

--find jobid which got filled in 2nd half of any year and again filled in the 1st half of next year

select  j.job_id,e.employee_id,j.job_title,e.hire_date  
from employees as e  
INNER JOIN jobs as j 
on e.job_id = j.job_id
where month(e.hire_date) in  (7,8,9,10,11,12) and j.job_id in

(select  job_id  
from employees 
where month(date_add(hire_date,INTERVAL '1' year)) in  (1,2,3,4,5,6));


select  job_id  
from employees 
where month(date_add(hire_date,INTERVAL '1' year)) in  (1,2,3,4,5,6);


use ram_db;

------names of employees who are taking equal salaries

select e1.ename from emp as e1 
INNER JOIN emp as e2 
on e1.sal = e2.sal and e1.empno<>e2.empno; 





select ename,sal from emp as e1
where sal in (select sal from emp as e2 where e1.empno<>e2.empno) ;


--department names of employees who joined on first thursday

select * from emp;
select * from dept;

select dname from dept
where deptno IN (select deptno from emp 
              where dayname(hiredate)="Thursday" and day(hiredate)<=7;)

select d.dname,dayname(e.hiredate), hiredate  from dept as d 
INNER JOIN emp as e 
ON e.deptno = d.deptno
where dayname(hiredate)="Thursday" and day(hiredate)<=7;


CREATE table odd_even 
(
   C1 INT(3),C2 VARCHAR(4) 

);

INSERT INTO odd_even(c1)
values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

update odd_even set c2= case  
when  MOD(c1,2)=0 then "even"  
else "odd"
end;

select * from odd_even;



-------------------------------------

use hr_db;

select * from regions;

select * from countries;

---NATURAL JOIN --tables are joined naturally on common column having only one column
----               -join condition should not be specified
---                -aliases are not required  


select region_name,country_name from regions NATURAL JOIN countries;

use ram_db;

select ename,dname from  emp NATURAL JOIN dept;


--USING ---based on specific column we can join 

select first_name,department_name from  employees NATURAL JOIN departments using (department_id);

show tables;


--- subqueries   

    ---select inside select 
    ---evaluating unknown through known   

--Rules:
/* 1.subquery executes first 
   2.result will be used by outer query and then gets executed
   3.subquery should be enclosed in brackets  
*/


--- find out the employees who joined after lisa (first_name)

select * from employees;

select * from departments;

select first_name ,hire_date from employees where hire_date >(

select hire_date from employees where first_name ="Lisa");


---find out department_name in which steven king is working 

select department_name from departments where department_id IN (
select department_id from employees 
where CONCAT(first_name ," ",last_name)="steven king") ;


select d.department_name from departments as d INNER JOIN  employees as e 
ON d.deparment_id = e.department_id 
where CONCAT(e.first_name ," ",e.last_name)="steven king" ; --pending  


--find out the employees reporting to Neena Kochhar  


select concat(first_name," ",last_name) from employees where manager_id IN(
select employee_id from employees where CONCAT(first_name," ",last_name)="neena kochhar");


select concat(first_name," ",last_name) from employees as e1 INNER JOIN  
employees as e2 ON e1.manager_id;


show tables;

--find out grade of Lex De Haan using subquery  

select * from job_grades;

select * from employees;


select grade_level from job_grades where 

(select salary from employees where CONCAT(first_name," ",last_name) = "Lex De Haan")

between lowest_sal and high_sal ;


-- find out the  employees working in the same deparment as Hermann Baer . exclude Herman Baer 

select CONCAT(e1.first_name," ",e1.last_name ) from employees as e1 where department_id =
(select department_id from employees  as e2 where CONCAT(e2.first_name," ",e2.last_name)="Hermann Baer"); --pending


--- subqueries are of 5 types  
/*    1.single row --return 1 row   =,<>,<,>
      2.multiple row  --returns more than 1 row   IN ,NOT IN ,ANY, ALL 
      3.multiple column --
      4.nested  
      5.correlated*/


--find out the employees who are working in tha same deparment as valli,lex  

select first_name from employees  where department_id IN
(select department_id from employees  where first_name IN ("valli","lex"));


-- find out the department names in which no employees are working 

select * from departments;

select * from employees;

select department_id  from departments group by department_id having count(employee_id) ; --pending 


--find out department_name  where no SA_REP working  

select department_name from departments where department_id IN(
select department_id from employees where job_id NOT IN ("SA_REP"));  --correct 26 row --pending


select department_name from departments where department_id IN(
select department_id from employees where job_id NOT IN ("SA_REP") and department_id IS NOT NULL);


-- Find out the employees who joined on '1999-06-21' ,'1997-08-20';

select first_name,hire_date from employees where hire_date in ('1999-06-21' ,'1997-08-20');


---find out the employees who joined on the same date as lura and susan  


select hire_date from employees where first_name in ("lura","susan");


--- ANY ALL 

select first_name ,hire_date from employees where 
hire_date in (select hire_date from employees where first_name in ("Laura","Susan"));


select first_name ,hire_date from employees where 
hire_date > ANY (select hire_date from employees where first_name in ("Laura","Susan"));


select first_name ,hire_date from employees where 
hire_date > ALL (select hire_date from employees where first_name in ("Laura","Susan"));


-- find out the employees who are taking maximum salries in each job_id 

select first_name,job_id,salary from employees where (job_id,salary) IN 
(select job_id,max(salary) from employees group by job_id) ;


--find out the job_id which is having maximum number of employees 

 select job_id from 
(select job_id,count(employee_id) from employees group by job_id) as M 
where   ;  ---pending  


select count(job_id),job_id from employees group by job_id  
having count(job_id) IN (select max(a.cnt) from (select count(job_id) as cnt from employees group by job_id) as a);



select concat(first_name," ",last_name) "fullname",job_id  
from employees 
where job_id  in (select job_id from employees 
                  group by job_id
                  having count(job_id) in (select max(a.cnt) from 
                                                                 (select count(job_id) cnt from employees
                                                                 group by job_id) a));


---correlated subquery 

--find out people who are taking salary more than the respective departments salary 

select first_name,salary,department_id from employees e
where salary > (select avg(salary) from employees where department_id = e.department_id )
order by 3;


select e.first_name,e.salary,e.department_id,a.avsal 
from employees e inner join (select department_id,avg(salary) avsal
                              from employees 
                              where department_id is not NULL
                              group by department_id) a  
on e.department_id = a.department_id 
and e.salary > a.avsal 
order by 3;

select group_concat(first_name),department_id 
from employees 
where department_id=60 
group by department_id;