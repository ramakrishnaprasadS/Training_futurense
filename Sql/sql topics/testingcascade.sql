
CREATE DATABASE test;
USE test;
SHOW TABLES;

CREATE TABLE Student (
    sno INT PRIMARY KEY,
    sname VARCHAR(20),
    age INT

);
DROP TABLE student;

DELETE FROM Student;
INSERT INTO Student(sno, sname,age) 
 VALUES(1,'Ankit',17),
       (2,'Ramya',18),
       (3,'Ram',16);

INSERT INTO Student(sno, sname,age) 
 VALUES(1,'Ramya',18),
       (3,'Ram',16);

SELECT *
FROM Student;

CREATE TABLE Course (
    cno INT PRIMARY KEY,
    cname VARCHAR(20)
);

DROP TABLE course; 
INSERT INTO Course(cno, cname) 
 VALUES(101,'c'),
       (102,'c++'),
       (103,'DBMS');

SELECT *
FROM Course;

ON DELETE CASCADE, RESTRICT, NO ACTION, SET NULL, DEFAULT;

DROP TABLE enroll;
CREATE TABLE Enroll (
    sno INT,
    cno INT DEFAULT 1,
    jdate date,
    PRIMARY KEY(sno,cno),
    FOREIGN KEY(sno) REFERENCES Student(sno)  ON DELETE CASCADE ON UPDATE RESTRICT,
    FOREIGN KEY(cno) REFERENCES Course(cno)
);

INSERT INTO Enroll(sno,cno,jdate) 
 VALUES(1, 101, '2021-4-2'),
       (1, 102, '2021-5-2'),
       (2, 103, '2021-5-3');

UPDATE `Student` SET sno=4 WHERE sno=2;

DELETE FROM `Student` WHERE sno=5;

select * from enroll;

--Practise Test 
SELECT phone_number
FROM Customers
WHERE address NOT LIKE '%liverpool%' AND first_name LIKE '____' AND 
last_name LIKE '______' AND phone_number NOT LIKE '%3'; 