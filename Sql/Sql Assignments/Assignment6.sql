-- Active: 1671708805339@@127.0.0.1@3308@hr_db

use world;

show tables;

select * from countries;
select * from departments;
select * from jobs;
select * from employees;
select * from job_history;
select * from locations;
select * from regions;

--1. **Write a query to list the number of jobs available in the employees table.**
select count(distinct job_id) as jobs_count from employees;

--2. **Write a query to get the total salaries payable to employees.**
select sum(salary) as total_payable from employees;

--3. **Write a query to get the minimum salary from the employees table.**
select min(salary) as min_salary from employees;

--4. **Write a query to get the maximum salary of an employee working as a Programmer.**
select  max(e.salary) as max_sal from employees e INNER JOIN jobs j using(job_id) where j.job_title="Programmer";

--5. **Write a query to get the average salary and number of employees working in department 90.**
select department_id,avg(salary) as avg_sal,count(employee_id) as cnt from employees where department_id=90;

--6. **Write a query to get the highest, lowest, sum, and average salary of all employees**
select 
max(salary) as max_sal,
min(salary) as min_sal,
sum(salary) as total_sal,
avg(salary) as avg_sal from employees;

--7. **Write a query to get the number of employees with the same job.**
select job_id,count(*) as cnt from employees group by job_id with rollup having count(employee_id)>1; 
--8. **Write a query to get the difference between the highest and lowest salaries.**
select max(salary)-min(salary) as salary_range from employees;

--9. **Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.**
select manager_id,min(salary) as min_sal from employees group by manager_id ;

--10. **Write a query to get the department ID and the total salary payable in each department.**
select department_id,sum(salary) as total_sal_payable from employees group by department_id;

--11. **Write a query to get the average salary for each job ID excluding programmer.**
select job_id,avg(salary) as avg_sal from employees where job_id not in (select job_id from jobs where job_title="Programmer") group by job_id;
--12. **Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only.**
select job_id,
sum(salary) as total_sal,
max(salary) as max_sal,
min(salary) as min_sal,
avg(salary) as avg_sal from employees 
where department_id=90
group by job_id;
--13. **Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.**
select job_id,max(salary) as max_sal from employees group by job_id having max(salary)>4000;
--14. **Write a query to get the average salary for all departments employing more than 10 employees.**
select department_id,count(employee_id) as cnt,avg(salary) as avg_sal from employees group by department_id having count(employee_id)>10;