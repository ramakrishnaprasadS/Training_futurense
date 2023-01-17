
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

explain format=tree select * from fruit where id=101;




