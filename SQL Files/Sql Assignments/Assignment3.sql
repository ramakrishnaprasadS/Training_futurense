-- Active: 1671708805339@@127.0.0.1@3308@ram_db

/* DDL Table creation Exercise */

CREATE TABLE Patient 
(
    PID INTEGER(7) PRIMARY KEY,
    P_Name VARCHAR(30) NOT NULL
);

CREATE TABLE Treatment
(
    TID INTEGER(7) PRIMARY KEY,
    T_Name VARCHAR(30) NOT NULL
);


CREATE TABLE Patient_Treatment
(
    PID_PT INTEGER(7),
    TID_PT INTEGER(7) ,  
    Date DATETIME NOT NULL,
    FOREIGN KEY(PID_PT) REFERENCES Patient(PID),
    FOREIGN KEY(TID_PT) REFERENCES Treatment(TID),
    PRIMARY KEY(PID_PT,TID_PT)
);

desc patient_treatment;

 -----------   /* DDL Alter & Drop Exercise */  ---------------

desc patient;
--1
ALTER TABLE Patient 
MODIFY column P_name VARCHAR(35) ;

--2

DESC patient_treatment;

ALTER TABLE patient_treatment 
ADD column Dosage INT(2) DEFAULT 0 NOT NULL CHECK(DOSAGE<=99);

--3

desc treatment;

ALTER TABLE Treatment 
RENAME column T_Name TO Treatment_Name;


--4

DROP TABLE Treatment;


--5  

desc patient_treatment;


ALTER TABLE patient_treatment
DROP FOREIGN KEY patient_treatment_ibfk_1;

ALTER TABLE patient_treatment
DROP FOREIGN KEY patient_treatment_ibfk_2;



