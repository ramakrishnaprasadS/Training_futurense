-- Active: 1671708805339@@127.0.0.1@3308@ram_db

create table person
(
    sino int(5),
    name varchar(20),
    place varchar(20),
    dob date
);

INSERT INTO person values
(1002,"HITESH","DELHI","2000-05-01"),
(1001,"RITESH","MUMBAI","1998-07-12"),
(1005,"BALAN","KOCHI","1999-11-05");

--a
select tablespace_name,file_name,total_extents from information_schema.files 
where tablespace_name like 'ram_db/person%';


--b

select * from person where sino=1001;

--c

explain select * from person where sino=1001;
explain format=tree select * from person where sino=1001;

-- Filter: (person.sino = 1001)  (cost=0.55 rows=1)     -> Table scan on person  (cost=0.55 rows=3)

--d

create index sino_idx on person(sino);

explain format=tree select * from person where sino=1001;

-- Index lookup on person using sino_idx (sino=1001)  (cost=0.35 rows=1)


--e

ALTER TABLE person ADD constraint pk_idx primary key(sino);

explain format=tree select * from person where sino=1001;

--Rows fetched before execution  (cost=0.00..0.00 rows=1)

--f
/*
observations:

-when there is no index in the table, table scan is being performed on the table
 where the cost is more.
-when idex is created on sino which is a column in where clause of the query,
 the cost is reduced as index lookup happened.
-when the column in where clause is made primary ,the cost is very minimum compared
 to remaining cases.

*/

--------------------------------------------Q2


use hr_db;
show tables;
select * from countries;
select * from regions;
select * from locations;

---------------------------------------------a

select 
l.city,
r.region_name,
c.country_name,
l.location_id from countries c inner join locations l on c.country_id = l.country_id
inner join regions r on r.region_id = c.region_id
where c.country_name IN ("BRAZIL","INDIA");


----------------------------------------b

explain format= tree
select 
l.city,
r.region_name,
c.country_name,
l.location_id from countries c inner join locations l on c.country_id = l.country_id
inner join regions r on r.region_id = c.region_id
where c.country_name IN ("BRAZIL","INDIA");

/*Nested loop inner join  (cost=7.38 rows=8)
    -> Nested loop inner join  (cost=4.50 rows=5)
        -> Filter: (c.country_name in ('BRAZIL','INDIA'))  (cost=2.75 rows=5)
            -> Table scan on c  (cost=2.75 rows=25)
        -> Single-row index lookup on r using PRIMARY (region_id=c.region_id)  (cost=0.27 rows=1)
    -> Index lookup on l using country_id (country_id=c.country_id)  (cost=0.44 rows=2)

*/

explain format= tree
select 
l.city,
r.region_name,
c.country_name,
l.location_id from countries c inner join locations l on c.country_id = l.country_id
inner join regions r on r.region_id = c.region_id
where c.country_name = "BRAZIL" or c.country_name="INDIA";

/*
 Nested loop inner join  (cost=7.14 rows=8)
    -> Nested loop inner join  (cost=4.41 rows=5)
        -> Filter: ((c.country_name = 'BRAZIL') or (c.country_name = 'INDIA'))  (cost=2.75 rows=5)
            -> Table scan on c  (cost=2.75 rows=25)
        -> Single-row index lookup on r using PRIMARY (region_id=c.region_id)  (cost=0.27 rows=1)
    -> Index lookup on l using country_id (country_id=c.country_id)  (cost=0.45 rows=2)
*/


create index cntname_idx on countries(country_name);

explain format= tree
select 
l.city,
r.region_name,
c.country_name,
l.location_id from countries c inner join locations l on c.country_id = l.country_id
inner join regions r on r.region_id = c.region_id
where c.country_name = "BRAZIL" or c.country_name="INDIA";

/*
Nested loop inner join  (cost=3.26 rows=3)
    -> Nested loop inner join  (cost=2.11 rows=2)
        -> Index range scan on c using cntname_idx over (country_name = 'BRAZIL') OR (country_name = 'INDIA'), with index condition: ((c.country_name = 'BRAZIL') or (c.country_name = 'INDIA'))  (cost=1.41 rows=2)
        -> Single-row index lookup on r using PRIMARY (region_id=c.region_id)  (cost=0.30 rows=1)
    -> Index lookup on l using country_id (country_id=c.country_id)  (cost=0.49 rows=2)
*/

--by using "=" operator in where clause and creating index on country_name the query is optimized
--and cost is reduced from 7.38 to 3.26


----------------------------------------------c

select * from employees;

CREATE TABLE range_part1(empno int,
                        ename varchar(20),
                        salary int)
PARTITION BY RANGE(salary)
(
  PARTITION P_10000 VALUES LESS THAN (10000),
  PARTITION P_20000 VALUES LESS THAN (20000),
  PARTITION P_30000 VALUES LESS THAN (30000),
  PARTITION P_40000 VALUES LESS THAN (40000),
  PARTITION P_50000 VALUES LESS THAN (50000),
  PARTITION P_60000 VALUES LESS THAN (60000),
  PARTITION P_70000 VALUES LESS THAN (70000)

);
INSERT INTO range_part1 SELECT employee_id,first_name,salary from employees;

--------------------------------------------d

explain select ename from range_part1 where salary between 12000 and 17000;

--P_20000 is the partition being used for the above query


------------------------------------------e
explain format=tree select ename from range_part1 where salary between 12000 and 17000;

/*
Filter: (range_part1.salary between 12000 and 17000)  (cost=2.05 rows=2)
    -> Table scan on range_part1  (cost=2.05 rows=18)
*/

-----------------------------------------f

explain format=tree select first_name from employees where salary between 12000 and 17000;

/*
Filter: (employees.salary between 12000 and 17000)  (cost=10.95 rows=12)
    -> Table scan on employees  (cost=10.95 rows=107)
*/


----------------------------------------g

----on running same query on employees table and the partion table table created on it,
--- quering on partition table is optimized and incurred less cost.








