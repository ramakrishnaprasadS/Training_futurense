-- Active: 1671708805339@@127.0.0.1@3308@ram_db
/* JOIN --> to select data from multiple tables  

   types of syntaxes:
     1. ORACLE PROPRIETARY SYNTAX
         EQUI
         OUTER
         NON EQUI 
         CARTESIAN  
         SELF  
     2.SQL-99  
         INNER JOIN  
         OUTER JOIN  
         JOIN (DIFFERENT TABLES)  
         CROSS  
         JOIN  (SAME TABLES)  
         NATURAL 
         USING*/

/* RULES 
   1. column names should have the format  (for both syntaxes)
      e.name or emp.name 
      d.name or dept.name   
   2. Type of join to be specified (INNER,OUTER,NATURAL,CROSS...)
   3.join condition uses  on clause
   4.addittional conditions will be done using 
      AND operator
      WHERE clause */


-- INNER JOIN --join condition uses equal operator for join  

select  ename,emp.deptno,dname from emp  
inner join  
dept on emp.deptno=dept.deptno;


select  e.ename,e.deptno,d.dname from emp as e
inner join  
dept as d on e.deptno=d.deptno;

-- display above op only for sales  

select  e.ename,e.deptno,d.dname from emp as e
inner join  
dept as d on e.deptno=d.deptno
where d.dname="sales";

select  e.ename,e.deptno,d.dname from emp as e
inner join  
dept as d on e.deptno=d.deptno and d.dname="sales";

-- findout total salary  in sales and accounting department 

select sum(e.sal),d.dname from emp as e 
inner join  
dept as d 
on e.deptno=d.deptno where d.dname in ("sales","accounting")
group by d.dname;


--findout employees working in chicago as clerk  

select e.ename,d.loc from emp as e 
inner join dept as d 
on e.deptno=d.deptno 
where d.loc="chicago" and e.job="clerk";

--outer join = inner join + missing data  

insert into emp(empno,ename) values("2222",'y');



select e.ename,d.dname from emp as e 
right outer join  
dept as d  
on e.deptno = d.deptno;



select e.ename,d.dname from emp as e 
left outer join  
dept as d  
on e.deptno = d.deptno;



select e.ename,d.dname from emp as e 
right outer join  
dept as d  
on e.deptno = d.deptno
union 
select e.ename,d.dname from emp as e 
left outer join  
dept as d  
on e.deptno = d.deptno;



select e.ename,s.grade ,d.dname
from emp as e 
join salgrade as s 
on e.sal between s.losal and s.hisal 
inner join dept as d 
on e.deptno=d.deptno;

show tables;

show databases;
use hr_db;

show tables;

select * from countries;

select * from locations;

select * from regions;

select * from departments;

select * from employees;

select r.region_name ,c.country_name 
from regions as r  
inner join  
countries as c  
on r.region_id = c.region_id;



select c.country_name,l.city ,d.department_name,concat(e.first_name," ",e.last_name) as ename
from countries as c  
inner join locations as l  
on c.country_id = l.country_id  
inner join departments as d  
on l.location_id = d.location_id 
INNER JOIN employees as e  
on e.department_id = d.department_id;

--display employees name and to whom he reports to

select CONCAT(e.first_name," ",e.last_name) as ename , CONCAT(m.first_name," ",m.last_name) as reports_to
from employees as e  
join  
employees as m  
on e.employee_id = m.manager_id  ;


--display employees taking same salary 

select CONCAT(e.first_name," ",e.last_name) as ename , CONCAT(m.first_name," ",m.last_name) as reports_to,e.salary
from employees as e  
join  
employees as m  
on e.salary = m.salary and e.employee_id != m.employee_id  ;


--using sub query  

select p.ename,p.reports_to,p.sal from 
(select CONCAT(e.first_name," ",e.last_name) as ename , CONCAT(m.first_name," ",m.last_name) as reports_to,e.salary
from employees as e  
join  
employees as m  
on e.salary = m.salary and e.employee_id != m.employee_id) as p
GROUP BY p.ename,p.reports_to;


select CONCAT(first_name," ",last_name) as ename,salary from employees where 
salary in (select salary from employees group by salary having count(employee_id)>1);

show tables;

select month("2022-01-25");
select * from jobs;

select * from employees;

--find jobid which got filled in 2nd half of any year and again filled in the 1st half of next year

select  j.job_id,e.employee_id,j.job_title,e.hire_date  
from employees as e  
INNER JOIN jobs as j 
on e.job_id = j.job_id
where month(e.hire_date) in  (7,8,9,10,11,12) and j.job_id in

(select  job_id  
from employees 
where month(date_add(hire_date,INTERVAL '1' year)) in  (1,2,3,4,5,6));


select  job_id  
from employees 
where month(date_add(hire_date,INTERVAL '1' year)) in  (1,2,3,4,5,6);


use ram_db;

------names of employees who are taking equal salaries

select e1.ename from emp as e1 
INNER JOIN emp as e2 
on e1.sal = e2.sal and e1.empno<>e2.empno; 





select ename,sal from emp as e1
where sal in (select sal from emp as e2 where e1.empno<>e2.empno) ;


--department names of employees who joined on first thursday

select * from emp;
select * from dept;

select dname from dept
where deptno IN (select deptno from emp 
                    where dayname(hiredate)="Thursday" and day(hiredate)<=7);

select d.dname,dayname(e.hiredate), hiredate  from dept as d 
INNER JOIN emp as e 
ON e.deptno = d.deptno
where dayname(hiredate)="Thursday" and day(hiredate)<=7;


CREATE table odd_even 
(
   C1 INT(3),C2 VARCHAR(4) 

);

INSERT INTO odd_even(c1)
values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

update odd_even set c2= case  
when  MOD(c1,2)=0 then "even"  
else "odd"
end;

select * from odd_even;



-------------------------------------

use hr_db;

select * from regions;

select * from countries;

---NATURAL JOIN --tables are joined naturally on common column having only one column
----               -join condition should not be specified
---                -aliases are not required  


select region_name,country_name from regions NATURAL JOIN countries;

use ram_db;

select ename,dname from  emp NATURAL JOIN dept;


--USING ---based on specific column we can join 

select first_name,department_name from  employees NATURAL JOIN departments using (department_id);

show tables;


--- subqueries   

    ---select inside select 
    ---evaluating unknown through known   

--Rules:
/* 1.subquery executes first 
   2.result will be used by outer query and then gets executed
   3.subquery should be enclosed in brackets  
*/


--- find out the employees who joined after lisa (first_name)

select * from employees;

select * from departments;

select first_name ,hire_date from employees where hire_date >(

select hire_date from employees where first_name ="Lisa");


---find out department_name in which steven king is working 

select department_name from departments where department_id  (
select department_id from employees 
where CONCAT(first_name ," ",last_name)="steven king") ;


select d.department_name from departments as d INNER JOIN  employees as e 
ON d.deparment_id = e.department_id 
where CONCAT(e.first_name ," ",e.last_name)="steven king" ; --pending  


--find out the employees reporting to Neena Kochhar  


select concat(first_name," ",last_name) from employees where manager_id IN(
select employee_id from employees where CONCAT(first_name," ",last_name)="neena kochhar");


select concat(first_name," ",last_name) from employees as e1 INNER JOIN  
employees as e2 ON e1.manager_id;


show tables;

--find out grade of Lex De Haan using subquery  

select * from job_grades;

select * from employees;


select grade_level from job_grades where 

(select salary from employees where CONCAT(first_name," ",last_name) = "Lex De Haan")

between lowest_sal and high_sal ;


-- find out the  employees working in the same deparment as Hermann Baer . exclude Herman Baer 

select CONCAT(e1.first_name," ",e1.last_name ) from employees as e1 where department_id =
(select department_id from employees  as e2 where CONCAT(e2.first_name," ",e2.last_name)="Hermann Baer"); --pending


--- subqueries are of 5 types  
/*    1.single row --return 1 row   =,<>,<,>
      2.multiple row  --returns more than 1 row   IN ,NOT IN ,ANY, ALL 
      3.multiple column --
      4.nested  
      5.correlated*/


--find out the employees who are working in tha same deparment as valli,lex  

select first_name from employees  where department_id IN
(select department_id from employees  where first_name IN ("valli","lex"));


-- find out the department names in which no employees are working 

select * from departments;

select * from employees;

select department_id  from departments group by department_id having count(employee_id) ; --pending 


--find out department_name  where no SA_REP working  

select department_name from departments where department_id IN(
select department_id from employees where job_id NOT IN ("SA_REP"));  --correct 26 row --pending


select department_name from departments where department_id IN(
select department_id from employees where job_id NOT IN ("SA_REP") and department_id IS NOT NULL);


-- Find out the employees who joined on '1999-06-21' ,'1997-08-20';

select first_name,hire_date from employees where hire_date in ('1999-06-21' ,'1997-08-20');


---find out the employees who joined on the same date as lura and susan  


select hire_date from employees where first_name in ("lura","susan");


--- ANY ALL 

select first_name ,hire_date from employees where 
hire_date in (select hire_date from employees where first_name in ("Laura","Susan"));


select first_name ,hire_date from employees where 
hire_date > ANY (select hire_date from employees where first_name in ("Laura","Susan"));


select first_name ,hire_date from employees where 
hire_date > ALL (select hire_date from employees where first_name in ("Laura","Susan"));


-- find out the employees who are taking maximum salries in each job_id 

select first_name,job_id,salary from employees where (job_id,salary) IN 
(select job_id,max(salary) from employees group by job_id) ;


--find out the job_id which is having maximum number of employees 

 select job_id from 
(select job_id,count(employee_id) from employees group by job_id) as M 
where   ;  ---pending  


select count(job_id),job_id from employees group by job_id  
having count(job_id) IN (select max(a.cnt) from (select count(job_id) as cnt from employees group by job_id) as a);



select concat(first_name," ",last_name) "fullname",job_id  
from employees 
where job_id  in (select job_id from employees 
                  group by job_id
                  having count(job_id) in (select max(a.cnt) from 
                                                                 (select count(job_id) cnt from employees
                                                                 group by job_id) a));


---correlated subquery 

--find out people who are taking salary more than the respective departments salary 

select first_name,salary,department_id from employees e
where salary > (select avg(salary) from employees where department_id = e.department_id )
order by 3;


select e.first_name,e.salary,e.department_id,a.avsal 
from employees e inner join (select department_id,avg(salary) avsal
                              from employees 
                              where department_id is not NULL
                              group by department_id) a  
on e.department_id = a.department_id 
and e.salary > a.avsal 
order by 3;

select group_concat(first_name),department_id 
from employees 
where department_id=60 
group by department_id;


---Correlated update


use hr_db;

CREATE TABLE emp_new
as select employee_id,first_name,department_id,job_id from employees;
alter table emp_new add dept_name varchar(20);


select * from emp_new;

update emp_new e set dept_name=(select department_name from departments where department_id=e.department_id);


--correlated delete


delete from emp_new e where job_id in (select job_id from employees where employee_id=e.employee_id and employee_id=109);


select count(*) from emp_new;


---TRUNCATE
/*
DDL
where clause cant be used
no rollback
truncate retains structure   --only removes data

*/

--DROP ---removes structure also

---DELETE
/*
where
dml
rollback using
start transaction
only records are removed
*/





