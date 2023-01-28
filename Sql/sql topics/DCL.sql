-- Active: 1671708805339@@127.0.0.1@3308@hr_db


use hr_db;

/*

DCL (DATA CONTROL LANGUAGE)

GRANT 
REVOKE



previlages -- permissions to interact with database  

*/

--CREATING USER 

CREATE USER 'user1'@'localhost' IDENTIFIED BY 'password';

--C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u user1 -p --port=3308

show databases;

select user from mysql.user;

 GRANT ALL PRIVILEGES ON hr_db.job_grades to 'user1'@'localhost';

GRANT CREATE TABLE ON hr_db to 'user1'@'localhost';

GRANT USAGE ON *.* TO 'user1'@'localhost;

-----------------------------------------------------------------------

- Craete User
CREATE USER 'test'@'localhost' IDENTIFIED BY 'test';

SELECT USER FROM mysql.user;
SELECT DATABASE();

GRANT ALL PRIVILEGES ON hr.job_grades TO 'test'@'localhost';

SHOW GRANTS FOR test@localhost;

REVOKE ALL PRIVILEGES ON
hr.job_grades FROM test@localhost;

GRANT CREATE ON hr.* TO test@localhost;

GRANT INSERT ON hr.* to test@localhost;

GRANT SELECT ON hr.* TO test@localhost;

-- to see all GRANTS
SHOW GRANTS FOR test@localhost;


--To revoke all GRANTS
REVOKE ALL ON hr.* FROM test@localhost;





