-- Active: 1671708805339@@127.0.0.1@3308@hr_db


use hr_db;
show tables;

--1

CREATE TABLE DEPT 
(
    id INT(4),
    name VARCHAR(25)
);

ALTER TABLE DEPT add constraint `PK_dept` PRIMARY KEY(id);


ALTER TABLE DEPT MODIFY id  INT(4) AUTO_INCREMENT;

DROP table dept;

select * from dept;

INSERT INTO dept(id,name) values (1001,"hari");

INSERT INTO dept (name) values ("Ram"),("Ravi"),("phani"),("siva"); 

ALTER TABLE DEPT ADD column location varchar(15);

ALTER table dept drop column location;

UPDATE DEPT set location = case id when 1001 then "Banglore"
                                when 1002 then "chennai"
                                when 1003 then "hyderabad"
                                when 1004 then "delhi"
                                end;

ALTER TABLE dept RENAME column location to place;

ALTER TABLE DEPT RENAME itpl_tab;

CREATE TABLE default_tab(id INT,c2 numeric(11,2) default 10.5);

desc default_tab;


ALTER table default_tab alter c2 set default 11.25;

ALTER table default_tab modify c2 set default 13.25;


create table pri_tab1(c1 int primary key,
                      c2 char(1));
create table for_tab1(c1 int,
                      c3 date,
                      foreign key(c1) references pri_tab1(c1));

INSERT INTO pri_tab1(c1,c2) values(1001,'s');

INSERT INTO for_tab1(c1,c3) values(1001,"2021-05-27");

select * from pri;


                                


