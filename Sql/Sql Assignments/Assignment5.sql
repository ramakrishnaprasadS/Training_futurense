-- Active: 1671708805339@@127.0.0.1@3308@ram_db

show databases;
show tables;
use hr_db;

select * from employees;
select * from emp;
--1. **Select employees first name, last name, job_id and salary whose first name starts with alphabet S.**

select first_name,last_name,job_id,salary from employees where first_name LIKE "S%";


--2. **Write a query to select employee with the highest salary.**

select  S.first_name, S.salary from
(select e.*,
dense_rank() over(order by salary desc) as drnk 
from employees as e) as S
where S.drnk=1;

--3. **Select employee with the second highest salary**.

select  S.first_name, S.salary from
(select e.*,
dense_rank() over(order by salary desc) as drnk 
from employees as e) as S
where S.drnk=2;

--4. **Fetch employees with 2nd or 3rd highest salary**.
select  S.first_name, S.salary from
(select e.*,
dense_rank() over(order by salary desc) as drnk 
from employees as e) as S
where S.drnk=2 or S.drnk=3;


--5. **Write a query to select employees and their corresponding managers and their salaries**.

select e1.first_name as empl ,
       e1.salary as empl_sal ,
       e2.first_name as manager,
       e2.salary as manager_sal from employees as e1 INNER join employees e2 
       on e1.manager_id = e2.employee_id; 


--6. **Write a query to show count of employees under each manager in descending order**.
select manager_id,count(employee_id) as employee_count 
from employees 
group by manager_id 
order by employee_count desc;

--7. **Find the count of employees in each department**.
select department_id,count(employee_id) as employee_count 
from employees 
group by department_id
order by employee_count desc;

--8. **Get the count of employees hired year wise**.

select year(hire_date) as year,count(employee_id) as no_of_employees_hired
from employees 
group by year(hire_date)
order by year;

select * from employees;

--9. **Find the salary range of employees**.
select max(salary) as max_sal,min(salary) as min_sal from employees;

--10. **Write a query to divide people into three groups based on their salaries**.
use hr_db;
select first_name,
case 
when salary<=10000 then "low_sal" 
when salary>10000 and salary<=20000 then "med_sal"
else "high_sal" end as sal_range
from employees;

--11. **Select the employees whose first_name contains “an”.**

select * from employees where first_name LIKE "%an%";

--12. **Select employee first name and the corresponding phone number in the format (_ _ _)-(_ _ _)-(_ _ _ _)**.

select first_name,
CONCAT(substr(phone_number,1,3),"-",substr(phone_number,5,3),"-",substr(phone_number,9,4)) as phone_num
from employees ;

--13. **Find the employees who joined in August, 1994.**


select * from employees where year(hire_date)=1994 and month(hire_date)=8;

--14. **Write an SQL query to display employees who earn more than the average salary in that company**
select first_name,salary from employees where salary >
(select avg(salary) as avg_sal from employees);

--15. **Find the maximum salary from each department.**
select department_id,max(salary) as max_sal from employees
group by department_id;

--16. **Write a SQL query to display the 5 least earning employees**.
select  S.first_name, S.salary from
(select e.*,
dense_rank() over(order by salary asc) as drnk 
from employees as e) as S
where S.drnk<=5
limit 5;

--17. **Find the employees hired in the 80s**.
select first_name,hire_date from employees where year(hire_date)>1979 and year(hire_date)<1990;

--18. **Display the employees first name and the name in reverse order**.
select first_name,REVERSE(first_name) as rev_name from employees;

--19. **Find the employees who joined the company after 15th of the month.**
select employee_id,first_name,hire_date from employees where day(hire_date)>15;

--20. **Display the managers and the reporting employees who work in different departments**.
select e1.first_name as empl,
e2.first_name as manager,
e1.department_id as emp_dept,
e2.department_id as manager_dept
from employees e1 INNER JOIN employees e2
on e1.manager_id=e2.employee_id
where e1.department_id <> e2.department_id;