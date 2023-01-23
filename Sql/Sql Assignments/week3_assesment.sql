-- Active: 1671708805339@@127.0.0.1@3308@hr_db

show DATABASES;
--1 

SELECT CONCAT(EmpFname," ",EmpLname) as FullName FROM Employeeinfo
WHERE (Fname LIKE "S%") and (DOB BETWEEN date("02-05-1970") and date("31-12-1975"));


--2


select count(EmpId) as DeptEmpCount from Employeeinfo 
group by Department
having count(EmpId)<2 
order by DeptEmpCount DESC;

--3

select CONCAT(i.EmpFname," ",i.EmpLname) as FullName ,p.EmpPosition
from employeeinfo as i INNER JOIN EmployeePosition as p ON i.empid = p.empid
where p.EmpPosition="Manager";

select substr("lmnope",1,1);