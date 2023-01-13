-- Active: 1671708805339@@127.0.0.1@3308@ram_db


CREATE DATABASE case_study1_db;
use case_study1_db;

CREATE TABLE BOOK 
   (	BOOKID int(15)   PRIMARY KEY auto_increment, 
	BPUB varchar(20), 
	BAUTH varchar(20), 
	BTITLE varchar(25), 
	BSUB varchar(25)
   ) ;


  CREATE TABLE MEMBER 
   (	MID int(4)   PRIMARY KEY auto_increment, 
	MNAME varchar(20), 
	MPHONE numeric(10,0),
        JOINDATE DATE
   ) ;



  CREATE TABLE BCOPY 
   (	C_ID int(4), 
	BOOKID int(15), 
	STATUS varchar(20) CHECK (status in('available','rented','reserved')),
        PRIMARY KEY (C_ID,BOOKID)
   ); 



  CREATE TABLE BRES 
   (	MID int(4) , 
	BOOKID int(15) REFERENCES BOOK, 
	RESDATE DATE,PRIMARY KEY (MID, BOOKID, RESDATE),
        foreign key(mid) references member(mid)
   ) ;




  CREATE TABLE BLOAN 
   (	BOOKID int(4), 
	LDATE DATE, 
	FINE numeric(11,2), 
	MID int(4), 
	EXP_DATE DATE DEFAULT (curdate()+2), 
	ACT_DATE DATE, 
	C_ID int(4),
  FOREIGN KEY (C_ID, BOOKID)
	  REFERENCES BCOPY (C_ID, BOOKID),
 foreign key(mid) references member(mid)
   ) ;


show tables;


Insert into BOOK (BPUB,BAUTH,BTITLE,BSUB) 
values ('IDG Books','Carol','Oracle Bible','Database');
Insert into BOOK (BPUB,BAUTH,BTITLE,BSUB) 
values ('TMH','James','Information Systems','I.Science');
Insert into BOOK (BPUB,BAUTH,BTITLE,BSUB) 
values ('SPD','Shah','Java EB 5','Java');
Insert into BOOK (BPUB,BAUTH,BTITLE,BSUB) 
values ('BPB','Deshpande','P.T.Olap','Database');


Insert into MEMBER (MNAME,MPHONE,JOINDATE) 
values ('rahul',9343438641,(curdate()-3));
Insert into MEMBER (MNAME,MPHONE,joindate)
 values ('raj',9880138898,(curdate()-2));
Insert into MEMBER (MNAME,MPHONE,joindate) 
values ('mahesh',9900780859,curdate());



Insert into BCOPY (C_ID,BOOKID,STATUS) values (1,1,'available');
Insert into BCOPY (C_ID,BOOKID,STATUS) values (2,1,'available');
Insert into BCOPY (C_ID,BOOKID,STATUS) values (1,2,'available');
Insert into BCOPY (C_ID,BOOKID,STATUS) values (2,2,'available');
Insert into BCOPY (C_ID,BOOKID,STATUS) values (1,3,'available');
Insert into BCOPY (C_ID,BOOKID,STATUS) values (1,4,'available');


select * from bcopy;
select * from bloan;
select * from book;
select * from bres;
select * from member;

DELETE FROM bcopy;
DELETE FROM bloan;
DELETE FROM book;
DELETE FROM bres;
DELETE FROM member;


desc member;
desc book;

--procedure to add new member to member table
DELIMITER //

CREATE PROCEDURE add_member(m_name varchar(20),m_phone DECIMAL(10,0))
BEGIN 
    INSERT INTO member(mname,mphone,joindate) values(m_name,m_phone,curdate());
END //

DELIMITER ;

DROP PROCEDURE add_member;

call add_member("Rama",9666112617);
call add_member("Parv",9888112617);


---procedure to add new book to book table and the same time copy of it in bcopy table

DELIMITER //

CREATE TRIGGER add_book_copy
after insert on book
for each row
BEGIN 
   INSERT INTO bcopy(C_ID,BOOKID,STATUS) values(1,new.bookid,"available");
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE add_book(B_PUB varchar(20),B_AUTH varchar(20),B_TITLE varchar(25),B_SUB varchar(25))
BEGIN 
    INSERT INTO book(BPUB,BAUTH,BTITLE,BSUB) values(B_PUB,B_AUTH,B_TITLE,B_SUB);
END //

DELIMITER ;

select * from book;

select * from bcopy;

call add_book("classmate","ram","sqllite","db");
call add_book("Ajantha","hari","java","programming");


DROP PROCEDURE add_book;


--function for renting

select * from bloan;
select * from member;
select * from bcopy;
select * from bres;

DELIMITER //

CREATE FUNCTION new_rental(bid INT,memberid INT)
RETURNS DATE DETERMINISTIC
BEGIN
   
   DECLARE book_status varchar(20);
   DECLARE cid INT;
   select STATUS,C_ID INTO book_status,cid from bcopy where bookid=bid and status="available" limit 1;
   if (cid is not null)
      then
      update bcopy set status="rented" where bookid=bid and C_ID=cid;
      INSERT INTO bloan(ldate,bookid,mid,exp_date,c_id) values(curdate(),bid,memberid,date_add(curdate(),INTERVAL '3' day),cid);
      
      return date_add(curdate(),INTERVAL '3' day);
   else 
      call reserve_book(memberid,bid);
      return null;
   end if;
   
END //

DELIMITER ;
DROP FUNCTION new_rental;
select new_rental(1,5);
select * from bcopy;
select * from member;
select * from bloan;
select * from bres;

desc bloan;

select TIMESTAMPDIFF(day,"2023-01-10",curdate())*5;

---return book

DELIMITER //

CREATE PROCEDURE return_book(IN bid INT(15),IN cid INT(5))
BEGIN
   DECLARE memberid INT;
   DECLARE expdate date;
   select mid,exp_date into memberid,expdate from bloan where bookid=bid and c_id=cid;
   if bid in (select bookid from bres) then update bcopy set status="reserved" where c_id=cid and bookid=bid;
   else update bcopy set status="available" where c_id=cid and bookid=bid;
   end if;
   if curdate()<=expdate then update bloan set act_date=curdate() where bookid=bid and c_id=cid;
   else 
      update bloan set act_date=curdate() where bookid=bid and c_id=cid;
      update bloan set fine=TIMESTAMPDIFF(day,exp_date,curdate())*5 where bookid=bid and c_id=cid;
   end if;
END //


DELIMITER;

DROP PROCEDURE return_book;

call return_book(1,2);

select new_rental(1,5); --since reserved not allowing to rent
call return_book(1,1);
select new_rental(1,5);






---reserve book

DELIMITER //

CREATE PROCEDURE reserve_book(IN memberid INT(15),IN bid INT(5))
BEGIN
   INSERT INTO BRES(MID,BOOKID,RESDATE) values(memberid,bid,curdate());
END //

DELIMITER;





DROP PROCEDURE reserve_book;

   



