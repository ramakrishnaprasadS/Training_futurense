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
 