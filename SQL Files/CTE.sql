

--CTE --Common Table Expressions
--table name is given in prior using 'with' clause


with cte as (select * from employees)
select first_name from employees;

with cte_1 as (select avg(salary) as avsal,department_id from employees group by department_id)
select e.first_name,e.salary,e.department_id,cte_1.avsal from employees e join cte_1
on e.department_id=cte_1.department_id and e.salary>cte_1.avsal;

select * from employees;

select e.first_name ,
count(e.employee_id) over(partition by e.department_id) as e_cnt,
m.first_name as manager
count(m.employee_id) over(partition by m.department_id) as m_cnt,
from employees e inner join employees m
on e.manager_id=m.employee_id;

with recursive cte_2 as (select 1 "n" union all select n+1 from cte_2 where cte_2.n<=30)
select * from cte_2;


with recursive cte_2 as (select curdate() "n" union all select date_add(n,interval '1' day) from cte_2 where cte_2.n<=last_day(curdate()))
select * from cte_2;