-- Active: 1671708805339@@127.0.0.1@3308@hr_db

CREATE DATABASE hrbackup;
use hr_db;

show databases;

show databases;

use hrbackup;

show tables;
/*

C:\Windows\System32>cd C:\Program Files\MySQL\MySQL Server 8.0\bin

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -u  root -p hr_db > new_hrdb.sql
Enter password: *********
mysqldump: Got error: 2003: Can't connect to MySQL server on 'localhost:3306' (10061) when trying to connect

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -u  root --pot=3308 -p hr_db > new_hrdb.sql
mysqldump: [ERROR] unknown variable 'pot=3308'.

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -u  root --port=3308 -p hr_db > new_hrdb.sql
Enter password: *********

----if we want to includes routines ....mysqldump -u  root --port=3308 --routines -p hr_db > new_hrdb.sql

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u  root --port=3308 -p hrbackup < new_hrdb.sql
Enter password: *********
ERROR 1049 (42000): Unknown database 'hrbackup'



C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u  root --port=3308 -p hrbackup < new_hrdb.sql
Enter password: *********
*/