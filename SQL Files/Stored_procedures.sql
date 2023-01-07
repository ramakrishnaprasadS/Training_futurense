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

SHOW PROCEDURE STATUS LIKE "getFirsttwocountries";

--show procedure status;  -->gives all procedures in that database

--stored procedures are asssociated with the respective databases


--calling stored PROCEDURE

CALL getFirsttwocountries();


--with arguments

DELIMITER //

CREATE PROCEDURE getOfficebyCountry(IN countryName VARCHAR(255))
BEGIN 
    select * from countries where country=countryName;
END


DELIMITER ;

CALL getOfficebyCountry("UK");



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





--TRIGGERS  
-- cannot perform  dml in same table
--associated with DML operations
-- AFTER INSERT 
-- BEFORE | AFTER UPDATE
-- BEFORE DELETE 


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



