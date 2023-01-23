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




