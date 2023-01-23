
---Q1

set @dob="1999-05-28";

with recursive cte_2 as (select @dob "D1",date_format(@dob,"%a") as D2 union all select date_add(D1,interval '1' year),date_format(date_add(D1,interval '1' year),"%a") from cte_2 where cte_2.D1<year(curdate()))
select * from cte_2;



--Q2

----a

select ename,
sal,
rank(sal) over(order by sal desc) rnk, 
dense_rank(sal) over(order by sal desc) drnk
from emp;

---b
select ename,
sal,
lead(sal) over(order by sal desc) lead_sal, 
lag(sal) over(order by sal desc) lag_sal
from emp;

---c

select ename,
sal,
deptno,
max(sal) over(partition by deptno) as dept_max_sal
from emp;

--d

select * from emp;

select empno,ename,job,hiredate from emp 
where hiredate in (select min(hiredate) from emp where job="clerk");

select empno,ename,job,hiredate 
 min(hiredate) over(partition by job) as min_hire from emp where job="clerk";






