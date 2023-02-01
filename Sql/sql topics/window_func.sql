
---diff b/w windows and analytical functions?
/*

OLAP --online analytical processing
--window functions
    -over()

oltp - online transaction processing

*/

use hr_db;
show tables;
select * from employees;

select count(*) over() as cnt ,employee_id from employees;
select avg(salary) over() as avg ,employee_id from employees;

select avg(salary) over() as avg ,
count(*) over() as cnt,
employee_id from employees;


select s1.first_name,s1.salary, ( Select Sum(salary) From employees S2
                        Where S2.employee_id<= S1.employee_id
                      )  running_sal
      From employees S1
      ;
use hr_db;
select first_name,salary,                     ---cummulative sum
sum(salary) over(order by salary desc) as running_salary 
from employees;



select first_name,salary,
row_number() over() as row_num      -------row number
from employees;

select first_name,salary,
row_number() over(order by salary desc) as row_num
from employees;

select first_name,salary,
rank() over(order by salary desc) as rnk      ---rank
from employees;

---when there is a tie rank leaves a gap


select first_name,salary,
dense_rank() over(order by salary desc) as drnk      ---dense_rank
from employees;

---when there is a tie rank leaves no gap


---comparing functions--to compare value of the current row wrt previous/next row
--LAG --compares with previous row
--LEAD --compares with next row

select first_name,salary,
LAG(salary) over() as lag_sal from employees;   ---gives salary of previous employee

select first_name,salary,
LAG(salary,2) over() as lag_sal from employees;   ---gives salary of 2nd previous employee

select first_name,salary,
LEAD(salary) over() as lead_sal from employees;  --gives salary of next employee

select first_name,salary,
LEAD(salary,3) over() as lead_sal from employees;  --gives salary of 3rd next employee

select first_name,hire_date,
LAG(hire_date) over() as prev_hiredate from employees;   ---gives hiredate of previous employee

select first_name,hire_date,
LEAD(hire_date) over() as next_hiredate from employees;  --gives hiredate of next employee

select * from employees;

select first_name,commission_pct,
LEAD(commission_pct) over() as lead_comm from employees;

use hr_db;

---FIRST_VALUE 
select first_name,salary,
FIRST_VALUE(salary) over(order by salary desc) '1st' from employees;

select first_name,hire_date,
FIRST_VALUE(hire_date) over(order by hire_date) '1st' from employees;

--Nth VALUE
select first_name,salary,
Nth_VALUE(salary,2) over(order by salary desc) '1st' from employees;  --gives the second value of the ordered list fo slaries


---LAST_VALUE
--range  between unbounded preceeding and unbounded following
--rows   between unbounded preceding and current row
---      between current and unbounded following

select first_name,salary,
last_value(salary) over(range between unbounded preceding and unbounded following) as lst_val from employees
;

select first_name,salary,
last_value(salary) over(range between unbounded preceding and unbounded following) as lst_val from employees
order by salary desc;


---
select * from employees;

select first_name,salary,department_id,
sum(salary) over(partition by department_id) as tot
from employees;  


--NTILE

select NTILE(6) over(order by department_id) as n_tile, ----entire records divided into 3  groups
first_name,department_id from employees;



use ram_db;
;
select * from emp;

DELETE from emp where ename like "y";
select * from employees;


--find the number of days difference between 1st analyst and 2nd analyst


--

-----------------------------








