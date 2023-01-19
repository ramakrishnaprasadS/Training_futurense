-- Active: 1671708805339@@127.0.0.1@3308@ram_db


--cursor --it is used to handle the result row by row inside programming(procedures,func,triggers)
/*
--steps
declare
open
fetch
close

syntax

declare <cursor_name> CURSOR FOR <select satement>

*/

DELIMITER //

CREATE PROCEDURE pro_cursor(pno int)
BEGIN 
    declare cnt int default 0;
    declare v1 numeric(11,2);
    declare v2 varchar(20);
    declare cur1 cursor for select sal,ename from emp where deptno=pno;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET cnt = 1;
    open cur1;
        cur1label: loop
                fetch cur1 into v1,v2;
                if cnt=1 the leave cur1label;
                end if;
                select concat("sal=",v1,",","ename=",v2);

        end loop;
    close cur1;
end //

DELIMITER ;

call pro_cur(20);










