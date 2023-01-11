-- Active: 1671708805339@@127.0.0.1@3308@hr_db

use hr_db;

--TCL
--commit
--rollback

/*
syntax
START TRANSACTION;
DML
COMMIT/ROLLBACK;


*/

--Any transations using strat transaction ,subsequent ddl,dcl transactions will commit the previous transactions.


show tables;

select * from employees;


update employees set first_name="Steven" where employee_id=100;



