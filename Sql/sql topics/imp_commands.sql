

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








