-- Active: 1671708805339@@127.0.0.1@3308@ram_db

use hr_db;

show tables;

-- DELIMETER  symbol   -->syntax to change delimeter

DELIMITER //

CREATE PROCEDURE getFirsttwocountries()
BEGIN 
    SELECT * from countries LIMIT 1;
    SELECT * from countries LIMIT 1,1;
END //

DELIMITER ;

DROP PROCEDURE getFirsttwocountries;

SHOW PROCEDURE STATUS LIKE "getFirsttwocountries";

use ram_db;
show procedure status;

--show procedure status;  -->gives all procedures in that database

--stored procedures are asssociated with the respective databases


--calling stored PROCEDURE

CALL getFirsttwocountries();


--with arguments

-----IN

DELIMITER //
use hr_db;

select * from countries;

select length(country_name)/2 from countries;



select substr(country_name,round(length(country_name)/2),1) as code from countries;
select  CONCAT(substr(country_name,1,1),substr(country_name,length(country_name)/3,1),substr(country_name,length(country_name)/2,1)) as code from country;
create table cntr
(
    country_code char(5) PRIMARY KEY,
    country_name varchar(50)
);

create PROCEDURE getcountry_codes()
BEGIN 
    insert into cntr(country_code,country_name) select CONCAT(substr(country_name,1,1),substr(country_name,length(country_name)/3,1),substr(country_name,length(country_name)/2,1)),country_name from countries;

END//

CREATE PROCEDURE getOfficebyCountry(IN countryName VARCHAR(255))
BEGIN 
    select * from countries where country_id=countryName;
END//


DELIMITER ;

use flightsdb;
show tables;
select * from country;

DROP PROCEDURE getOfficebyCountry;

CALL getOfficebyCountry("UK");

----OUT

show procedure status where db="ram_db";

show tables from hr_db;

DELIMITER //
CREATE PROCEDURE getOrderCountByStatus(
        IN orderStatus VARCHAR(255),
        OUT total INT
)
BEGIN
        SELECT COUNT(orderNumber) INTO total 
        FROM orders 
        WHERE status = orderStatus;
END //
DELIMITER ;
CALL getOrderCountByStatus('Shipped', @total);
SELECT @total;
CALL getOrderCountByStatus('Cancelled', @total_cancelled);
SELECT @total_cancelled;
CALL getOrderCountByStatus('in process', @total_in_process);
SELECT @total_in_process AS orders_in_progress;


---INOUT

DELIMITER //
CREATE PROCEDURE setCounter(
        INOUT counter INT,
        IN step INT
)
BEGIN
        SET counter = counter + step;
END //
DELIMITER ;
SET @myCounter = 2;
CALL setCounter(@myCounter, 2);
CALL setCounter(@myCounter, 3);
CALL setCounter(@myCounter, 4);
SELECT @myCounter;




--stored functions 
use org;

DELIMITER //

CREATE FUNCTION computeTax (salary INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
    BEGIN

        DECLARE taxComputed DECIMAL(10,2);

        IF salary <= 75000 THEN
            SET taxComputed = salary * 10 / 100;
        ELSEIF salary > 75000 AND salary <= 150000 THEN
            SET taxComputed = salary * 20 / 100;
        ELSEIF salary > 150000 THEN
            SET taxComputed = salary * 30 / 100;
        END IF;
            
        RETURN taxComputed;

    END //


DELIMITER ;

SELECT worker.*, computeTax(SALARY) AS computedTax FROM worker; 



---TASK #10 #13


--task #10

use classicModels;
show tables;

--Create a stored procedure named getEmployees() to display the following employee and their office info: name, city, state, and country.
select * from employees;
select * from offices;


DELIMITER //

CREATE PROCEDURE getEmployees()
BEGIN 
    select e.firstName,o.city,o.state,o.country from employees e
    INNER JOIN offices o using(officeCode);
END //



DELIMITER ;
DROP PROCEDURE getEmployees;

CALL getEmployees();


--Create a stored procedure named getPayments() that prints the following customer and payment info:customerName, checkNumber, paymentDate, and amount.

select * from customers;

select * from payments;

DELIMITER //

CREATE PROCEDURE getPayments()
BEGIN 
    select c.customerName,p.checkNumber,p.paymentDate,p.amount from 
    customers c INNER JOIN payments p;
END //

DELIMITER ;

CALL getPayments();


--task #13

/*Write a stored function called computeTax that calculates income tax based on the salary for every worker in the Worker table as follows:

10% - salary <= 75000
20% - 75000 < salary <= 150000
30% - salary > 150000
Write a query that displays all the details of a worker including their computedTax.

*/
use org;
show tables;

select * from worker;

DELIMITER //

CREATE FUNCTION computeTax(salary INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN 
    DECLARE computedTax DECIMAL(10,2);

    IF salary<=75000 THEN SET computedTax=0.1*salary;
    ELSEIF (salary>75000 AND salary<=150000) THEN SET computedTax=0.2*salary;
    ELSE SET computedTax=0.3*salary;
    END IF;
    RETURN computedTax;
END//



DELIMITER ;
DROP FUNCTION computeTax;

select *,computeTax(salary) AS Tax from worker;


/*Define a stored procedure that takes a salary as input 
and returns the calculated income tax amount for the input salary. 
Print the computed tax for an input salary from a calling program. 
(Hint - Use the computeTax stored function inside the stored procedure)*/

DELIMITER //

/*CREATE PROCEDURE getIncomeTax(IN salary INT(10))
BEGIN
    select computeTax(salary);
END //*/

CREATE PROCEDURE getIncomeTax(IN salary INT(10),OUT IncomeTax DECIMAL(10,2))
BEGIN
    SET IncomeTax=computeTax(salary);
END //

DELIMITER ;



DROP PROCEDURE getIncomeTax;

CALL getIncomeTax(90000);

CALL getIncomeTax(9000,@IncomeTax);

select @IncomeTax AS innnn;

DELIMITER ;

--TRIGGERS  
-- cannot perform  dml in same table
--associated with DML operations
-- AFTER INSERT 
-- BEFORE | AFTER UPDATE
-- BEFORE DELETE 


USE org;

DELIMITER //

CREATE TRIGGER after_worker_insert
    AFTER INSERT
    ON worker
    FOR EACH ROW
BEGIN
        INSERT INTO title
            VALUES (
                NEW.worker_id, "New Joinee", NOW()
            );
END //

DELIMITER ;

INSERT INTO worker
    VALUES (
        1145, 'rk', 's', 1657, NOW(), 'Engineer'
    );




select * from worker;

select * from title;



SHOW TRIGGERS;

DROP TRIGGER IF EXISTS after_worker_insert;



---LOOPS --are are used only in stored routines 
--repeat --exit controlled
--while --entry contolled
--for   --depends on way we write


--while

DELIMITER //

CREATE PROCEDURE whileLoopDemo()
BEGIN
        DECLARE x INT;
        DECLARE str VARCHAR(255);

        SET x = 0;
        SET str = '';

        WHILE x <= 5 DO
                SET x = x + 1;
                IF (x mod 2 = 0) THEN
                        SET str = CONCAT(str, x, ', ');                        
                END IF;
        END WHILE;

        SELECT str;
END //

DELIMITER ;

CALL whileLoopDemo();

DROP PROCEDURE whileLoopDemo;

--REPEAT

DELIMITER //

CREATE PROCEDURE repeatLoopDemo()
BEGIN
        DECLARE x INT;
        DECLARE str VARCHAR(255);

        SET x = 0;
        SET str = '';

        REPEAT
                SET x = x + 1;
                IF (x mod 2 <> 0) THEN
                        SET str = CONCAT(str, x, ', ');                        
                END IF;
        UNTIL x > 5
        END REPEAT;

        SELECT str;
END //

DELIMITER ;

CALL repeatLoopDemo();

DROP PROCEDURE repeatLoopDemo;

---FOR

DELIMITER //

CREATE PROCEDURE forLoopDemo()
BEGIN
        DECLARE x INT;
        DECLARE str VARCHAR(255);

        SET x = 0;
        SET str = '';

        loop_label: LOOP
                IF x > 5 THEN
                        LEAVE loop_label;
                END IF;
                SET x = x + 1;
                IF (x mod 2 = 0) THEN
                        ITERATE loop_label;
                ELSE
                        SET str = CONCAT(str, x, ', ');
                END IF;
        END LOOP;
        SELECT str;
END //

DELIMITER ;

CALL forLoopDemo();

DROP PROCEDURE forLoopDemo;


use hr_db;

show tables;

select * from employees;
desc employees;


CREATE TABLE employee_stats
(emp_cnt INT(6) DEFAULT 0);
select count(*) from employees;

INSERT INTO employee_stats(emp_cnt) VALUES(108);

DROP TABLE employee_stats;

DELIMITER ;

DELIMITER //

CREATE TRIGGER before_employee_insert
    BEFORE INSERT
    ON employees
    FOR EACH ROW
BEGIN
        UPDATE  employee_stats SET emp_cnt=emp_cnt+1;
END //

DELIMITER ;

INSERT INTO employees VALUES (257,'shahsank','Krishna','ram@gmail.com','2542236522','2014-5-5','SA_REP',60000,0.2,100,50);

select * from employees;

select * from employee_stats;



/*
procedure

-may or maynot return value
-does not contain return statement
-cant be used directly woith sql statements


functions

-must and should return single value
-return statement is a must
-can be used with sql statements directly

syntax

CREATE FUNCTION <functionname> ()
RETURNS data_type DETEREMINISTIC
BEGIN 
    DECLARE ....
    statements..
    .
    .
    RETURN 
END

*/

/*--Create a function to pass employee_id as parameter  to return bonus for
    sh_clerk 1.5*salary,sa_rep 1.75*salary, mk_man 2.0*salary others salary
*/
use hr_db;
DELIMITER //

CREATE FUNCTION fun_hr1(p1 INT)
RETURNS numeric(11,2) DETERMINISTIC
BEGIN 
    DECLARE v1 numeric(11,2);
    DECLARE v2 numeric(11,2);
    DECLARE v3 varchar(20);
    select job_id,salary into v3,v1 from employees where employee_id = p1;
    if v3="sh_clerk" then set v2=1.5*v1;
    elseif v3="sa_rep" then set v2=1.75*v1;
    elseif v3="mk_man" then set v2=2.0*v1;
    else set v2=v1;
    end if;
    return v2;
END //

DELIMITER ;

select employee_id,hire_date,job_id,fun_hr1(employee_id) as bonus from employees;


---find whether the employee is hired in leap year or NOT

--date_format(concat(year(curdate()),"-12-31"),"%j");

DELIMITER //

CREATE FUNCTION fun_hr_leap(p1 INT)
RETURNS varchar(20) DETERMINISTIC
BEGIN 
    DECLARE v1 date;
    DECLARE v3 varchar(20);
    select hire_date into v1 from employees where employee_id = p1;
    if date_format(concat(year(v1),"-12-31"),"%j")=366 then set v3="leap year";
    else set v3="non-leap year";
    end if;
    return v3;
END //

DELIMITER ;

select employee_id,hire_date,fun_hr_leap(employee_id) as leap_or_not from employees;


---employees will get a joining bonus who joined       --------trigger
/*
on or before 15 of a month will be paid joining bonus on the last friday after 1 year

2022-01-15      2023-01-26  last friday

2022-01-18      2023-02-26  last friday
*/


select employee_id,first_name from employees where hire_date in (select min(hire_date) from employees)
;

--TRIGGER  --whenever event occurs triggers fires
/*
INSERT 
UPDATE
DELETE

---TRIGGER TIMINGS
    -before
    -after

--row level triggers
    -new  --INSERT,UPDATE
    -old   --DELETE,UPDATE

syntax

CREATE TRIGGER <TRIGGER NAME>
before/after <event_name> ON <table_name>
FOR EACH ROW
BEGIN 
    statements
END

*/

--create a trigger to insert into retired table whenever delete happens on employees table
create table retired as select first_name from employees;

create table emp1 as select * from employees;

DELIMITER //

CREATE TRIGGER trig_hr_del1
before delete on emp1
for each row
begin
    insert into retired values(old.first_name);
end //

DELIMITER ;

DELETE from emp1 where hire_date in (select min(hire_date) from employees);

select * from retired;

select * from emp1;


create table date_table(slno int primary key, date1 date check(date1<=curdate())); --doesn't work

create table date_table(slno int primary key, date1 date );

DELIMITER //

CREATE TRIGGER trig_check 
before insert on date_table 
for each row
BEGIN
    if new.date1 > curdate() then 
    signal sqlstate '45000' set message_text="**date1<=curdate()**";
    end if;
END //

DELIMITER ;

insert into date_table values(1,'2023-01-31');

---create a trigger to restrict the decrement of salary------------task--------


DELIMITER //

CREATE TRIGGER trig_redu
before update on emp1
for each ROW
begin 
    if new.salary<old.salary then 
    signal sqlstate '45000' set message_text="**beware! I want hike**";
    end if;
end//

DELIMITER;

--create a trigger to update balance in account table whenever wd(withdrawl),dep(deposit), happens

create table account
(
    accno int primary key,
    name varchar(20),
    balance numeric(11,2)
);

INSERT INTO account values(12345,"hari",10000);

create table trans
(
    accno int,
    wd numeric(11,2),
    dep numeric(11,2),
    foreign key(accno) references account(accno)
);

DELIMITER //

CREATE TRIGGER update_balance
after insert on trans
for each row
BEGIN 
    if new.dep is not null then 
        update account set balance = balance+new.dep where accno=new.accno;
    else
        update account set balance = balance-new.wd where accno=new.accno;
    end if;
end //

DELIMITER ;

INSERT INTO trans(accno,dep) values(1717,100000000);
INSERT INTO account values(1717,"Rama Krishna S",0);

select * from account;
















