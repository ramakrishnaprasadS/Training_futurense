

mysql -u root -p       -->go to mysql server bin and then give this command to connect to mysql


show databases;
select database();
use database_name;
show tables;
show columns from dept;
desc dept;
create table hm1 as select * from dept;
create table hm3(slno int,name varchar(20));
 insert into hm3 values(1,'rahul');---default order
  insert into hm3(name,slno) values('rishab',2);--chnaged order
insert into hm3 values(3,null);--inserting nulls
set @v1=5; 
set @v2='giri'; 
insert into hm3 values(@v1,@v2);--using set variable
insert into hm3 values(6,'hari'),(7,'nikhil'),(8,'nakul'); ---inserting into multiple rows
insert into hm3 select empno,ename from emp where deptno=10; ---copying from rows of other table
update hm3 set name='atul' where slno=3; --updating specified rows
delete from hm3 where slno=7782; ---delete specific rows
create table 
vote(age int check (age>=18), ---check constraint
name varchar(10));

CASE value WHEN [compare_value] THEN result [WHEN [compare_value] THEN 
result ...] [ELSE result] END

CASE WHEN [condition] THEN result [WHEN [condition] THEN result ...] [ELSE result] 
END


--IF(expr1,expr2,expr3)
select ename,sal,if(sal>3000,'high','low') as comments from emp;

--IFNULL(expr1,expr2)
select ename,sal,comm,sal+comm,ifnull((sal+comm),sal) "ifnull" from 
emp;

--NULLIF(expr1,expr2)
--Returns NULL if expr1 = expr2 is true, otherwise returns expr1. 
SELECT ename,sal,length(sal),length(ename), -
NULLIF(LENGTH(ENAME), LENGTH(SAL)) "nullif"
  from emp;

--NON-EQUI JOIN
SELECT E.ENAME,S.GRADE
FROM EMP E
JOIN SALGRADE S
ON E.SAL 
BETWEEN S.LOSAL AND S.HISAL

--multiple column subquery
SELECT ename,sal
FROM emp
WHERE sal > ALL(SELECT sal
                FROM emp
                WHERE ename
                in(‘TURNER’,’MILLER,’ADAMS’))

---correlated subquerey
--We wanted to find employees who are taking maximum salary in each deptno
SELECT ename,sal,deptno
FROM emp e
WHERE sal > (SELECT avg(sal)
                        FROM emp m
                        WHERE e.deptno=m.deptno
                        GROUP BY deptno)

----alter

--auto increment
create table auto2(c1 int auto_increment primary key, 
 -> c2 char);
alter table auto2 auto_increment=100;


/*
ALTER TABLE 
  Add clause 
  – Add new columns(before/after)
  – Add constraints
  Modify/change
  – Change null to not null
  – Column names
  - Column definition
  Drop clause
  – Drop Columns
  – Drop Constraints
  RENAME clause
  – Rename Table
*/


ALTER TABLE test_1 
ALTER C_5 SET DEFAULT '2022-08-05'; 

alter table test1 add constraint chk_test1 check(c3 in('P','F'));

SELECT CONSTRAINT_NAME, TABLE_NAME, CONSTRAINT_TYPE 
FROM information_schema.TABLE_CONSTRAINTS 
WHERE TABLE_NAME = 'TEST1'; 

set foreign_key_checks=0;


use ram_db;
show tables;

create table test1
(
col1 int unique,
col2 int 
);
insert into test1 values
(9,2),
(17,4),
(null,3),
(null,4);

select * from test1;
select distinct(col1),col2 from test1;

select sqrt(625),power(7,3),ascii('a'),char(65 using ascii);


select trim(' RICHARDS ') "trim",
 trim('x' from 'xxxAAAxxxBBBxxx');
 select ceil(91.1),floor(91.9),round(100.218,2), 
truncate(100.218,2);

select dayname(sysdate()),monthname(sysdate()),year(sysdate())
timestampdiff(month,'2020-08-12',curdate())


/*
%Y 4 digit year 1995
%m Number of month 12
%d Number of the day of month 13

%b Three letter abbreviation DEC
%M Month fully spelt out DECEMBER

%j Number of days since Jan 1 347

%a Three-letter abbreviation of day WED
%W Day fully spelt out WEDNESDAY

%D DAY NUMBER WITH th,rd etc 13TH
%y 2 digit year 9
*/

select str_to_date("10-may-2022","%d-%M-%Y"); --2022-05-10
select str_to_date("05/28/2022","%m/%d/%Y");

SELECT DATE_FORMAT("2017-06-15", "%W %M %e %Y"); -- Thursday June 15 2017



nvl(exp1,0)--->if exp1 is null replace it with 0

nvl2(exp1,exp2,exp3)

coalesce(exp1,exp2,exp3)



--------------------------------------------------------------

--finding the firstname from fullname
select substr(fullname,1,locate(" ",fullname)-1) from emp1;

--total occurances of 'n' in the fullname 
SELECT FullName, 
LENGTH(FullName) - LENGTH(REPLACE(FullName, 'n', ''))
FROM EmployeeDetails;

--updating fullname by removing leading and trailing spaces
UPDATE EmployeeDetails 
SET FullName = LTRIM(RTRIM(FullName));

--Write an SQL query to fetch all employee records from the EmployeeDetails table who have a salary record in the EmployeeSalary table.

select * from EmployeeDetails where empid exists in (select empid from EmployeeSalary );

 select date_add(curdate(),interval '1' day) "add 1 day", 
date_add(curdate(),interval '1' month) "add 1 month",
date_add(curdate(),interval '1' year) "add 1 year";

select timestampdiff(month,'2020-08-12',curdate());
select timestampdiff(year,'2020-08-12',curdate());
select timestampdiff(day,'2020-08-12',curdate());
select dayname(sysdate()),monthname(sysdate()),year(sysdate());

---checking the count of employees in operations department

select count(e.ename) from dept d left outer join emp1 e on e.deptno=d.deptno where d.dname="operations";


--non equi join
SELECT E.ENAME,S.GRADE FROM EMP E JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

---displayinf enames along with their manager names
 select e1.ename,e2.ename from emp1 e1 left join emp1 e2 on e1.mgr=e2.empno;

 ---selecting the employees who are having maximum salary in their department

 select ename,sal,deptno from emp1 where (sal,deptno) in (select max(sal),deptno from emp1 group by deptno);

 ---finding the employees who are taking salary more than their respective department's average salary

 select ename,sal from emp1 e1 where sal>(select avg(sal) from emp1 e2 where deptno=e1.deptno);

--Window functions
RANK(col_name) OVER(PARTITION BY Year ORDER BY col_name RANGE BETWEEN RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Total_Sales  
 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW  
               N PRECEEDING   AND CURRENT ROW
               UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
               N PRECEEDING AND N FOLLOWING


Aggregate Functions
    COUNT(col_name), SUM, AVG, MIN, MAX, and many more.

Ranking Functions
    RANK(), DENSE_RANK(), PERCENT_RANK(), ROW_NUMBER(), CUME_DIST(), etc.

Analytical Functions
    NTILE, LEAD, LAG, NTH, FIRST_VALUE, LAST_VALUE, etc.


select first_name,salary,                     ---cummulative sum
sum(salary) over(order by salary desc ) as running_salary 
from employees;

select sal,sum(sal) over(order by sal asc rows between 1 preceding and 1 following) from emp2;

select first_name,salary,
LAG(salary) over() as lag_sal from employees;   ---gives salary of previous employee

select first_name,salary,
LAG(salary,2) over() as lag_sal from employees;   ---gives salary of 2nd previous employee

select first_name,salary,
LEAD(salary) over() as lead_sal from employees;  --gives salary of next employee

select first_name,salary,
LEAD(salary,3) over() as lead_sal from employees;  --gives salary of 3rd next employee

select first_name,hire_date,
FIRST_VALUE(hire_date) over(order by hire_date) '1st' from employees;

--Nth VALUE
select first_name,salary,
Nth_VALUE(salary,2) over(order by salary desc) '1st' from employees;  --gives the second value of the ordered list fo slaries

---------------------partition tables

CREATE TABLE LIST_JOB(EMPNO INT,ENAME VARCHAR(20),JOB VARCHAR(20))
PARTITION BY LIST COLUMNS (JOB)
(
    PARTITION P_CLERK VALUES IN ('CLERK'),
    PARTITION P_SALES VALUES IN ('SALESMAN'),
    PARTITION P_ANAL VALUES IN ('ANALYST'),
    PARTITION P_MAN VALUES IN ('MANAGER'),
    PARTITION P_PRES VALUES IN ('PRESIDENT')
    );

INSERT INTO LIST_JOB SELECT EMPNO,ENAME,JOB FROM check_extent;
explain select count(*) from list_job where job="clerk";

------------------------------------------
CREATE TABLE RANGE_PART(emp_no int,
                        ename varchar(20),
                        sal int)
PARTITION BY RANGE(sal)
(
  PARTITION P_1000 VALUES LESS THAN (1000),
  PARTITION P_2000 VALUES LESS THAN (2000),
  PARTITION P_3000 VALUES LESS THAN (3000),
  PARTITION P_4000 VALUES LESS THAN (4000),
  PARTITION P_5000 VALUES LESS THAN (5000),
  PARTITION P_6000 VALUES LESS THAN (6000)
);

INSERT INTO RANGE_PART SELECT empno,ename,sal from check_extent;
select min(sal),max(sal) from RANGE_PART partition (P_2000);

-----------------------------------
create table hash_emp
(
  empno int primary key,
  ename varchar(20),
  sal float(11,2) )

  partition by hash(empno)
  partitions 4;

INSERT INTO hash_emp  select empno,ename,sal from check_extent;
select partition_name,partition_ordinal_position, table_rows from information_schema.partitions where table_name="hash_emp";
select * from hash_emp partition(p0) limit 10;

--------------------
create table comp_range_hash
(
  empno int,
  ename varchar(20),
  sal int,
  job varchar(20)
)
PARTITION BY range(sal)
subpartition by hash(empno)
subpartitions 2
(
  partition P_1k values less than (1000),
  partition P_2k values less than (2000),
  partition P_3k values less than (3000),
  partition P_4k values less than (4000),
  partition P_MAX values less than MAXVALUE
);

insert into comp_range_hash select empno,ename,sal,job from check_extent;
select * from comp_range_hash partition(p_2k);

-------------

tablespaces > datafiles > extents > datapages > rows
--
explain
explain format=tree
--

index scan
table scan
lookup

--
show indexes from emp;
create index id_idx on emp(id);--normal index
create index job_deptno_idx on emp(job,deptno);--composite index
explain format=tree select * from emp force index(FK_DEPTNO) where deptno=20 and job="clerk"; --forcing indexing
select index_name,is_visible from information_schema.statistics where table_schema="ram_db" and table_name="emp"; --checking index status

ALTER TABLE emp alter index fk_deptno visible; --making index visible
ALTER TABLE emp alter index fk_deptno invisible; --making index invisible

--------------
with 
cte1 as (query1),
cte2 as (query2)
select ...;

-----------


















