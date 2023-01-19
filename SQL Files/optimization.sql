-- Active: 1671708805339@@127.0.0.1@3308@ram_db

show tables;

---  data dictionary -->  information_schema.files
/*
important directories in mysql
- datadir
- basedir

rows inside datapages
datapages inside extents
extents inside datafiles
datafiles inside tablespaces

tablespaces > datafiles > extents > datapages > rows
*/

use hr_db;
create table check_tab(c1 int);

select tablespace_name,file_name,total_extents from information_schema.files 
where tablespace_name like 'ram_db/check_exten%';

use ram_db;

create table check_extent as select * from emp;

select * from check_extent;

ALTER TABLE check_extent  modify  empno int AUTO_INCREMENT primary key;

desc check_extent;

select * from check_extent;

DROP TABLE check_extent;

insert into check_extent select * from emp; ---not working

insert into check_extent(ename,job,mgr,hiredate,sal,comm,deptno)
select ename,job,mgr,hiredate,sal,comm,deptno from check_extent
WHERE ename<>'king';

SELECT COUNT(*) FROM check_extent;

select * from emp;

TRUNCATE check_extent;

---other table types
  --partition tables
  --temporary tables

----------partition tables
        ---list partition

CREATE TABLE LIST_JOB(EMPNO INT,ENAME VARCHAR(20),JOB VARCHAR(20))
PARTITION BY LIST COLUMNS (JOB)
(
    PARTITION P_CLERK VALUES IN ('CLERK'),
    PARTITION P_SALES VALUES IN ('SALESMAN'),
    PARTITION P_ANAL VALUES IN ('ANALYST'),
    PARTITION P_MAN VALUES IN ('MANAGER'),
    PARTITION P_PRES VALUES IN ('PRESIDENT'));

INSERT INTO LIST_JOB SELECT EMPNO,ENAME,JOB FROM check_extent;

DROP TABLE LIST_JOB;

explain select * from emp;

explain select * from list_job;

explain select count(*) from list_job;

explain select count(*) from list_job where job="clerk";

explain select count(*) from check_extent where job="clerk";
select count(*) from check_extent where job="clerk";

explain select count(*) from list_job where job="clerk";
select count(*) from list_job where job="clerk";

explain select * from emp where deptno=10;
explain select * from dept where dname="sales";
explain select * from regions where region_id=1;

explain select * from departments where location_id=1700;

explain select ename,sal from emp where sal in (select min(sal) from emp);

explain select * from emp where job="clerk"
union
select * from emp where job="salesman";

explain select ename from emp 
union
select dname from dept;

explain select ename,dname from emp 
natural join
dept;

CREATE TABLE Fruit
(
    ID INT(5),
    NAME varchar(20),
    price int(5)
);

INSERT INTO Fruit values
(103,"Guava",80),
(101,"Mango",150),
(105,"Apple",200);

select * from fruit;

explain format=tree select * from fruit where id=101;

explain format=tree select * from list_job where job="president";

explain format=tree select * from check_extent where job="president";

show index from ram_db.emp;

select distinct table_name,column_name,index_name 
from information_schema.statistics 
where table_schema="ram_db" and table_name="emp";

use ram_db;
CREATE index id_idx on fruit(id);

--can write using alter also

explain format=tree select * from fruit where id=101;


use hr_db;
show tables;

/*
structure of table
desc
show columns
show create table


*/

/*

select
----------------
parsing
  -optimising
    -executing
      -fetching
*/

/*


index scan
table scan
lookup
*/
use ram_db;
show tables;

show indexes from emp;

explain select ename from emp where job="clerk";

explain format=tree select ename from emp where job="clerk";

explain select * from dept where dname="sales";

explain format=tree select * from dept where dname="sales";

CREATE index dname_idx on dept(dname);

--ALTER TABLE dept DROP index dname_idx;

--find out employees working in deptno 20

desc emp;

explain select ename from emp where deptno=20 and job="clerk";
explain format=tree select ename from emp where deptno=20 and job="clerk";

--table scan
  --(forcing index)
    --use index
      --force index
        --ignore index

explain format=tree select * from emp force index(FK_DEPTNO) where deptno=20 and job="clerk";

--- invisible index ---

ALTER TABLE emp alter index fk_deptno invisible;

explain format=tree select * from check_extent;

explain format=tree select ename from check_extent where deptno=20 and job="clerk";

explain  select * from check_extent;

--visible

ALTER TABLE emp alter index fk_deptno visible;


--to check whether index is visible or not

show indexes from emp;

select index_name,is_visible from information_schema.statistics where table_schema="ram_db" and table_name="emp";



---composite index 

select * from emp;

create index job_deptno_idx on emp(job,deptno);
ALTER TABLE emp alter index job_deptno_idx visible;

explain select ename from emp where deptno=20 and job="clerk";
explain format=tree select ename from emp where deptno=20 and job="clerk";



explain format=tree select * from fruit where id=101;

explain  select * from fruit where id=101;

desc fruit;

alter table fruit add constraint PK_fruit primary key(id);



-------------------Range partitioning---

--most companies use this type of partitioning



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

select min(sal),max(sal) from RANGE_PART partition (P_1000);

explain select ename from range_part where sal between 2000 and 3000;

explain select ename from range_part where sal<1000;

select distinct year(hiredate) from emp;
CREATE TABLE RANGE_PART_hiredate(emp_no int,
                        ename varchar(20),
                        hiredate date)
PARTITION BY RANGE(year(hiredate))
(
  PARTITION P_1980 VALUES LESS THAN (1981),
  PARTITION P_1981 VALUES LESS THAN (1982),
  PARTITION P_1982 VALUES LESS THAN (1983),
  PARTITION P_1987 VALUES LESS THAN (1988)
  
);
INSERT INTO RANGE_PART_hiredate SELECT empno,ename,hiredate from check_extent;
desc RANGE_PART_hiredate;

DROP TABLE RANGE_PART_hiredate;


explain select emp_no,year(hiredate) from RANGE_PART_hiredate where year(hiredate) between 1981 and 1982;

select min(year(hiredate)),max(year(hiredate)) from RANGE_PART_hiredate partition (P_1987);

EXPLAIN SELECT * FROM RANGE_PART_hiredate
WHERE hiredate BETWEEN DATE_FORMAT("1984-00-00", "%Y-%m-%d") AND DATE_FORMAT("1987-00-00", "%Y-%m-%d");
desc RANGE_PART_hiredate;



------------hash partition -------

create table hash_emp
(
  empno int primary key,
  ename varchar(20),
  sal float(11,2))
  partition by hash(empno)
  partitions 4;

desc check_extent;



INSERT INTO hash_emp  select empno,ename,sal from check_extent;

select partition_name,partition_ordinal_position, table_rows from information_schema.partitions where table_name="hash_emp";

select * from hash_emp partition(p0) limit 10;



---------------------temporary tables-----------
---data is available only for a session duration

CREATE temporary table temp_1(sal float);

INSERT INTO temp_1 select sal from emp;

select * from temp_1;

show tables;

DROP TABLE check_extent;
DROP TABLE hash_emp;

DROP TABLE RANGE_PART_hiredate;

DROP TABLE range_part;





