

----Programming in sql

---procedures
   ---functions
      ---triggers

--set 
  --select

--delimiters can be used are $$  //  
--do not use \  

--1.redefine delimiter
--2.use(;) in the procedure body
--3.redefine delimiter


---do not use ddl,dcl in procedure body
--in trigger select,commit and rollback should not be used

------------------------------------------PROCEDUERES--------------------

--specific actions like select,update,insert,delete can be performed
--support modular programming
--precompiled

/* syntax

CREATE PROCEDURE <procedure_name> (paramaters based on requirement with comma separator)

BEGIN
     statements;
END $$

*/
/*
calling procedure

*/


use hr_db;

DELIMITER;

DELIMITER //

CREATE PROCEDURE pr1()
BEGIN
    select ("first procedure");
END //

DELIMITER ;
CALL pr1();

/*
rules for declaring variables
1. should be declared after begin statement 
2.each variable should be declared separately

note: do not use column names for variables/parameters
*/

DELIMITER //

CREATE PROCEDURE pr2(p1 INT,p2 INT)
BEGIN
    declare vprod numeric(11,2);
    set vprod=p1*p2;
    select concat("product of ",p1," and ",p2," is " ,vprod) as display;
END //


DROP PROCEDURE pr2;

DELIMITER ;

CALL pr2(7,5);


---create a procedure to pass employee_id as a parameter and print salary for him
select * from employees;
DELIMITER //

CREATE PROCEDURE emp_sal(emp_id INT)
BEGIN 
    select employee_id,salary from employees where employee_id=emp_id;
END //

DELIMITER ;

CALL emp_sal(101);


---------

---create a procedure to pass employee_id as a parameter and print first_name,lastname,departmentname for him
select * from employees;
select * from departments;
DELIMITER //

CREATE PROCEDURE emp_details(emp_id INT)
BEGIN 
    select e.employee_id,e.first_name,e.last_name,d.department_name from employees e  JOIN departments d
    using(department_id) where e.employee_id=emp_id;
END //

DELIMITER ;

CALL emp_details(101);

----create a procedure to insert more rows in stages using a loop  and if elseif else


---Atrributes in programming language
/*
sequence -- order in which code should flow
selection --choice making process
             if elseif else
iteration  
            while
            simple
            repeat

*/

---WHILE --does activity as long as condition is true

/* syntax

CREATE PROCEDURE sp_name()
BEGIN
DECLARE  ;

WHILE <condition> DO 
        statement1;
        statement2;
END WHILE;

*/


----selection (conditional statements)
/*
--IF 
syntax

IF <condition> THEN statement1;
END IF;

-----------
IF <condition> THEN 
                statement1;
ELSE 
       statement2;

---------
IF <condition> THEN 
                statement1;
ELSEIF <condition> THEN 
                statement1;
ELSE 
       statement2;


*/

CREATE TABLE  odd_even(slno INT primary key,descn varchar(4) check(descn in ('odd','even')));

DELIMITER //

CREATE PROCEDURE find_even_odd(p1 INT,P2 INT)
BEGIN 
    DECLARE v1 VARCHAR(4);
    WHILE p1<p2 DO 
        set p1=p1+1;
        IF mod(p1,2)=0 THEN set v1="even";
        ELSE 
            set v1="odd";
        END IF;
        INSERT INTO odd_even values(p1,v1);
    END WHILE;
END //

DELIMITER ;


call find_even_odd(0,101);
select * from odd_even;

delete  from odd_even;


--create procedure to pass your birthdate as parameter , print day of birth starting from birthdate to current date

create table date_of_birth(ever_yrdt date,everyyr_day VARCHAR(10));

DELIMITER //

CREATE PROCEDURE find_day_of_birth(dob date)
BEGIN 
    DECLARE op_date date;
    DECLARE op_dayname VARCHAR(10);
    set op_date=dob;
    WHILE year(op_date) < year(curdate()) DO
        set op_date=date_add(op_date,INTERVAL 1 year);
        set op_dayname=dayname(op_date);
        INSERT INTO date_of_birth values (op_date,op_dayname);
    END WHILE;
END //

DELIMITER ;

DROP PROCEDURE find_day_of_birth;

CALL find_day_of_birth("1999-05-28");

select * from date_of_birth;

DELETE from date_of_birth;


select specific_name,routine_type from information_schema.routines where routine_schema="hr_db";

---SIGNAL ---using this we can display a message  for handling errors

/* syntax

inside the procedure

if v1 is null then 
SIGNAL SQLSTATE '45000' SET MSG_TEXT="**INVALID EMPNO**";
end if;

*/


DELIMITER //

CREATE PROCEDURE emp_sal_signal(emp_id INT)
BEGIN 
    DECLARE v1 numeric(11,2);
    select salary INTO v1 from employees where employee_id=emp_id;
    if v1 is null then 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT="**INVALID EMPNO**";
    end if;
END //

DELIMITER ;

CALL emp_sal_signal(1001);

/*
parameter modes

IN
OUT
INOUT

*/
SELECT * from employees;
USE HR_db;
DELIMITER //

CREATE PROCEDURE pro1_in_out(IN p1 INT,OUT p2 VARCHAR(20))
BEGIN 
    select first_name into p2 from employees where employee_id=p1;
END //


DELIMITER ;

CALL pro1_in_out(111,@p2);

select @p2;


----INOUT

DELIMITER //

CREATE PROCEDURE pro2_inout(INOUT pname VARCHAR(50))
BEGIN 
    set pname = lpad(pname,40,'*');
END //


DELIMITER ;

set @name="ram";


CALL pro2_inout(@name);

select @name;

























