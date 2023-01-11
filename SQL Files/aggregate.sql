-- Active: 1671708805339@@127.0.0.1@3308@ram_db

---Aggregate functions --  count min max avg sum 

-- in mysql we need to set @@sal_mode="only_full_group_by"; to over come the default setting partial group by  


set @@sal_mode="only_full_group_by";


--COUNT(*) --includes null 
--COUNT(column) --does not include null 

--count min max can be used for all data types 

-- sum,avg is used for only number datatypes  


select * from emp;


select count(empno) from emp where job="clerk";

select min(sal),min(hiredate),min(ename) from emp;

select max(sal),max(hiredate),max(ename) from emp;

select sum(sal),avg(sal),sum(sal)/count(empno) from emp;

select deptno,sum(sal) from emp group by deptno;


 select deptno,sum(sal) from emp group by deptno;


 select count(empno) as no_of_emp,year(hiredate) from emp group by year(hiredate);

--no of emp joined in each year each quarter
 select count(empno) as no_of_emp,year(hiredate),quarter(hiredate) from emp group by year(hiredate),quarter(hiredate) order by year(hiredate);

select count(empno) as no_of_emp, date_format(hiredate,"%b") as mnth from emp 
group by mnth ,date_format(hiredate,"%m") order by date_format(hiredate,"%m") ;

---------------------------------------------------------pending
desc emp;
select job,
CASE 
   when job="clerk" then count(ename)
   when job="salesman" then max(sal)
   when job="analyst" then min(sal) 

else 0 end as clmn from emp group by job;  --working

select 
job,
CASE JOB
     when "clerk" then COUNT(empno)
     when "salesman" then max(sal)  
     when "analyst" then min(sal) 
     else min(sal)                           
     END as clmn  
from emp
group by job;

---avergae sal of all departments employing more than 5 people

select count(empno) from emp group by deptno;

select avg(sal) from emp group by deptno having count(empno)>5 ;


--list jobs all employees where max sal is greater than or equal to 3000;

select job,sal from emp where job="manager";
--pending
select job,sal from emp where sal>=3000;

select job from emp group by job having max(sal)>=3000;


select sign(32);


/*list the total,min,max,avg salary of all employees job wise for deptno 20
  and display those rows having avg salary greater than 1000*/

select sum(sal),job from emp where deptno=20 group by job;
 select 
job,
sum(sal),
min(sal),
max(sal), 
avg(sal) as avg_sal
 from emp 
 where deptno=20 
 group by job
having avg_sal>1000;


/*list the number of people along with enames having 'S' in their name*/ 
use ram_db;
select ename from emp
where ename like "%S%";


select count(ename) from emp
where ename like "%S%";


/* Display no of people along with the job which contains only one person in that job*/


select job,count(empno) as cnt
from emp 
group by job
having cnt=1;

/* Display job along with minimum salary which has minimum salary greater than or equal to 3000*/

select job,min(sal) as min_sal
from emp  
group by job
having min_sal>=3000;

select round(132.3);

select ceil(132.3);