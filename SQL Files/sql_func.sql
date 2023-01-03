-- Active: 1671708805339@@127.0.0.1@3308@ram_db

/*sql functions
1.single row functions
   - character func 
   - number functions
   - control functions 
   - date functions

2.multiple row functions
*/ 

--1.a charcter functions
--   CONCAT(col1,"",col2,...)


select CONCAT(ename,"\'s  job is ",job) AS "emp and his job" from emp;


--UPPER and lower functions

select lower(ename) from emp;

select upper("rama krishna"); --works fine in sql 

select lower("RAMA") from dual; --works fine in sql also ..

--SUBSTR (string,start_pos,end_pos)

select SUBSTR("pythonApplication",1); --starting from 1 till end

select SUBSTR("pythonApplication",1,6); --starting from 1 till end pos


--LENGTH 


select ename ,SUBSTR(ename,1,1) "fisrt_char" ,SUBSTR(ename,LENGTH(ename)) AS last_char from emp;

--last char of ename in lower 

select ename, CONCAT(lower(SUBSTR(ename,1,LENGTH(ename)-1)),SUBSTR(ename,-1))  AS new_name from emp;

select CONCAT(lower(RIGHT(ename,length(ename)-1)),LEFT(ename,1)) AS new_name from emp;



--INSTR --position first occurance of specified substring in given string


select INSTR("Javascript","a");

--find ename where last charcter is getting repeated 

select ename, INSTR(ename,SUBSTR(ename,-1)) as pos_of_lastchar from emp
where INSTR(ename,SUBSTR(ename,-1))<length(ename);

--LEFT/RIGHT --displays string from left/right to specified length 

select LEFT("pythonprograming",6);  --python 

select RIGHT("pythonprogramming",6);  --amming 


--TRIM --trims the spaces or character in beginning and at the end of the string

select TRIM("  rama krishna  "); --rama krishna--

select LTRIM("   rama krishna  "); --rama krishna  --

select RTRIM("   rama krishna  ");--   rama krishna--


select TRIM("h" from "helloh"); --ello 


--REPLACE 

select REPLACE("python is a programming language","program","non-program");--python is a non-programming language

--find no. of occurances of "A" in "MARY HAD A LITTLE LAMB"

set @str="MARY HAD A LITTLE LAMB";

select length(@str)-length(REPLACE(@str ,"A","")) AS cnt;

--reporting functions
--LPAD/RPAD --left/right padding with specified character to specified length   



select dname, lpad(dname,15,"*") as lpad, rpad(dname,15,"$") as rpad from dept;


--REPEAT --can repeat the string n number of times--

select repeat("ram ",20);


--REVERSE 

select REVERSE("Python");--nohtyP


------------------------------------------NUMBER functions -------------------

--MOD --gives remainder 

select empno from emp  where MOD(empno,2)=1 ;

--SIGN 
/* A=B 0
   A>B 1
   A<B -1  */


set @v1=10,@v2=30,@v3=10;

select SIGN(@v1-@v2),SIGN(@v1-@v3),SIGN(@v3-@v2);


--select employees who are taking commission more than the salary COMMENT

select * from emp;

select ename,comm,sal from emp where SIGN(comm-sal)=1;

--ABS --absolute value

select ABS(-98); --98


select ASCII("A"); --65

select CHAR(97); --a

select CHAR(97 using ascii); --a   -----works any where


--ROUND

select ROUND(157.258,1); --157.3 

select CEIL(157.258); --158

select ROUND(157.258,-3); --200 --  -1 gives nearest 10s........-2 gives nearest 100s ......-3 gives 0


--TRUNCATE 

select TRUNCATE(157.258,-2); --  100

select TRUNCATE(157.258,-1);  --  150

--CEIL and FLOOR 

select floor(157.258);  --157