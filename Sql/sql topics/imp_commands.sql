

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

--
> SELECT CONSTRAINT_NAME, TABLE_NAME, CONSTRAINT_TYPE 
 -> FROM information_schema.TABLE_CONSTRAINTS 
 -> WHERE TABLE_NAME = 'TEST1'; 

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
%b Number of month 12
%d Number of the day of month 13

%m Three letter abbreviation DEC
%M Month fully spelt out DECEMBER

%j Number of days since Jan 1 347

%a Three-letter abbreviation of day WED
%W Day fully spelt out WEDNESDAY

%D DAY NUMBER WITH th,rd etc 13TH
%y 2 digit year 9
*/

nvl(exp1,0)--->if exp1 is null replace it with 0

nvl2(exp1,exp2,exp3)

coalesce(exp1,exp2,exp3)









