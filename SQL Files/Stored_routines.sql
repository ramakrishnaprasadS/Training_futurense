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

--show procedure status;  -->gives all procedures in that database

--stored procedures are asssociated with the respective databases


--calling stored PROCEDURE

CALL getFirsttwocountries();


--with arguments

-----IN

DELIMITER //

select * from countries;

CREATE PROCEDURE getOfficebyCountry(IN countryName VARCHAR(255))
BEGIN 
    select * from countries where country_id=countryName;
END//


DELIMITER ;

DROP PROCEDURE getOfficebyCountry;

CALL getOfficebyCountry("UK");

----OUT

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
SET @myCounter = 1;
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







