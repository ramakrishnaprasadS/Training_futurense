
use hr_db;
show tables;

/*


*/

CREATE view v1 as select employee_id ,first_name,last_name,salary,job_id from employees where department_id = 60;

GRANT select on hr_db.v1 to 'dev1'@'localhost';

/*---simple views --- on single table
permits dmls

*/
--complex views -- on multiple tables
/*

*/

--dmls on views are prohibhited for (group by,union,group functins,distinct) 
CREATE view v2 as select sum(salary) "totsal",department_id from employees where department_id is not null 
group by department_id;

select * from v2;

start transaction;

delete from v2 where department_id=10;----not possible as it contains group by


CREATE view v3 as select distinct(department_id),job_id  from employees;

select * from v3;


delete from v3;    ----not possible as it contains distinct

----COMPLEX VIEW

CREATE View v4 as select region_name,country_name from regions natural join countries;


select * from v4;

delete from v4; ----not possible as it is complex query

show DATABASES;
use world;

show tables;

--view with check option

use hr_db;
select * from employees;
CREATE view v5 as select * from employees where department_id=90 with check option;

update v5 set department_id=75;

update v5 set commission_pct=0.2;

select * from v5;









