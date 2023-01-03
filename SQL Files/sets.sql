-- Active: 1671708805339@@127.0.0.1@3308@ram_db


---SET OPERATORS 

--A={1,2,3,4}
--B={4,5}
--AUB = {1,2,3,4,5}
--A interset B ={4}


-- to select data from similar select statements  

--rules
/* 1.number of columns should be same in all select statements 

   types:
   union
   union all 
   intersection (8.0.31 version mysql)*/

select distinct job from emp where deptno in (10,20);


select job from emp where deptno=10 
union                                    --without duplicates
select job from emp where deptno=20;



select job from emp where deptno=10 
union all                                   --with duplicates
select job from emp where deptno=20;


select job from emp where deptno=10 
INTERSECT 
select job from emp where deptno=20;


select job from emp where deptno=10 
union                                    --without duplicates
select job from emp where deptno=20
UNION
select job from emp where deptno=30; 


select ename,null as job from emp 
union 
select null,dname from dept;  --column heading comes from first select statement


/*find out total salary for each job as well as total salary*/

select job,sum(sal) as total from emp  
group by job
union 
select null ,sum(sal) from emp;

--ROLLUP
select job,sum(sal) from emp GROUP BY job with rollup;


--rollup gives summary value for first column only 
select sum(sal),deptno,job 
from emp 
group by deptno,job with rollup;



select sum(sal),deptno,job 
from emp 
group by deptno,job with rollup
union  
select sum(sal),deptno,job 
from emp 
group by job,deptno with rollup;

/*  ORDER BY 

   -it should be used after all select statements 
   -but it works only for first select statement*/

select ename from emp 
union 
select dname from dept
order by dname;           --does'nt work as order by works for firts select STATEMENT


select ename from emp 
union 
select dname from dept
order by ename;         --works fine  