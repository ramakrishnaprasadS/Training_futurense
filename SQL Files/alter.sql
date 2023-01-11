-- Active: 1671708805339@@127.0.0.1@3308@ram_db
show databases;

--Q1
use ram_db;
show tables;

USE ram_DB;

CREATE TABLE countries
(
country_id INT(3),
country_name VARCHAR(15),
region_id VARCHAR(5)

);

ALTER TABLE countries ADD CONSTRAINT `PK_countryid` PRIMARY KEY(`country_id`);

ALTER TABLE countries ADD CONSTRAINT `UQ_countryid_regionid` UNIQUE(country_id,region_id);

DESC countries;


--Q2

CREATE TABLE jobs
(
job_id VARCHAR(5) NOT NULL,
job_title VARCHAR(22) DEFAULT NULL,
min_salary DECIMAL(6,0) DEFAULT 8000,
max_salary DECIMAL(5,2) DEFAULT NULL

);

DESC jobs;



ALTER TABLE jobs ADD CONSTRAINT `PK_jobs_jobid` PRIMARY KEY(job_id);


---Q3

CREATE TABLE job_history
(
employee_id INT(5) NOT NULL,
start_date DATETIME,
end_date DATETIME,
job_id VARCHAR(5),
department_id DECIMAL(4,0)

);

DESC job_history;

ALTER TABLE job_history ADD CONSTRAINT `PK_jobhistory_employeeid` PRIMARY KEY(employee_id);

ALTER TABLE job_history ADD CONSTRAINT `UQ_jobhistory_employeeid` UNIQUE(employee_id);

ALTER TABLE job_history DROP CONSTRAINT `FQ_jobs_jobhistory_jobid`;
ALTER TABLE job_history ADD CONSTRAINT `FQ_jobs_jobhistory_jobid` FOREIGN KEY(job_id) REFERENCES jobs(job_id) ON DELETE RESTRICT;


--Q4 

CREATE TABLE employees 
(
employee_id VARCHAR(6) NOT NULL,
first_name VARCHAR(22) NOT NULL,
last_name VARCHAR(22) DEFAULT NULL,
email VARCHAR(25) NOT NULL,
phone_number VARCHAR(13) DEFAULT NULL,
hire_date datetime NOT NULL,
job_id VARCHAR(5) NOT NULL,
salary DECIMAL(5,2) DEFAULT NULL,
commision DECIMAL(2,2) DEFAULT NULL,
department_id DECIMAL(4,0) DEFAULT NULL,
manager_id DECIMAL(6,0) DEFAULT NULL

);
DESC employees;

DESC departments;

CREATE TABLE departments
(
    department_id DECIMAL(4,0) NOT NULL DEFAULT 0, 
    department_name VARCHAR(50) DEFAULT NULL, 
    manager_id DECIMAL(6,0) DEFAULT 0,
    location_id DECIMAL(4,0) 

 );

 DROP TABLE departments;

 ALTER TABLE departments ADD CONSTRAINT `PK_departmentid_manager_id` PRIMARY KEY(department_id,manager_id);

ALTER TABLE employees ADD CONSTRAINT  `PQ_employees_employeeid` PRIMARY KEY(employee_id);

ALTER TABLE employees ADD CONSTRAINT `FK_departmentid_manager_id` FOREIGN KEY(department_id,manager_id) REFERENCES departments(department_id,manager_id);


--ALTER ADD cloumns,constrainsts(except not null)  

---adding a column using alter // by default at end

use hr_db;
show tables;

select * from emp_new;

alter table emp_new add c7 numeric(11,2) first;

alter table emp_new add c2 numeric(11,2) after employee_id;

show create table employees;

alter table emp_new add primary key(employee_id);


alter table emp_new  add constraint `chk_newEmp` check(first_name in ('lex','Neena'));

alter table emp_new add constraint 'FK_empNew' FOREIGN KEY(employee_id) REFERENCES employees(employee_id);

/*
modify
null to not null
chnage datatype
change size
chnage default

*/

alter table emp_new  modify first_name NOT NULL;


alter table emp_new  modify c7 timestamp not null;


alter table emp_new modify first_name varchar(30);


---RENAME column,tables

alter table emp_new RENAME column c7 to c1;

show tables;

alter table employee_stats RENAME to emp_stats;


--DROP columns,constraints

alter table emp_new DROP column c1;

alter table emp_new drop contraint `pk_empid`;


CREATE TABLE auto_1(c1 int primary key auto_increment,c2 date);

INSERT INTO auto_1(c2) values(curdate()),("2021-05-21"),("2022-01-12");

select * from auto_1;

INSERT INTO auto_1(c2) values(now());

select last_insert_id() from auto_1;






--Q5 


CREATE TABLE jobs
(
    job_id VARCHAR(10)  NOT NULL PRIMARY KEY,
    job_title VARCHAR(35) DEFAULT NULL,
    min_salary DECIMAL(6,0) DEFAULT NULL,
    max_salary DECIMAL(6,0) DEFAULT NUll
);

DESC jobs;

DESC employees;

ALTER TABLE employees ADD CONSTRAINT `FK_jobs_employees_jobid` FOREIGN KEY(job_id) REFERENCES jobs(job_id);

--Q6 

ALTER TABLE employees DROP  CONSTRAINT `FK_jobs_employees_jobid`;

ALTER TABLE employees ADD CONSTRAINT `FK_jobs_employees_jobid` FOREIGN KEY(job_id) REFERENCES jobs(job_id) ON DELETE CASCADE;

--Q7 

ALTER TABLE employees ADD CONSTRAINT `FK_jobs_employees_jobid_setnull` FOREIGN KEY(job_id) REFERENCES jobs(job_id) ON UPDATE ON DELETE CASCADE;

--syntax to apply ON DELETE and ON UPDATE for on same  foreign key?
--resolved--can't we have a chance to update the foreign key changes in child with changes in parent?--yes we can with ON UPDATE CASCADE

--ALTER TABLE employees ADD CONSTRAINT `FK_jobs_employees_jobid_deletesetnull` FOREIGN KEY(job_id) REFERENCES jobs(job_id) ON DELETE SET NULL;

--Q8 

--FOREIGN KEY syntax without ON DELETE CASCADE alone will restrict the deletions and updations in parent ...whether any specific reason to use these clauses.



-- INDEX syntax ---  CREATE INDEX index_name ON table_name(column_name);



 