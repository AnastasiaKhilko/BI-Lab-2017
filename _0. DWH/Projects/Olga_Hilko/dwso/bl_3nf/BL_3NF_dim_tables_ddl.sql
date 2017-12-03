show user;

/*exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Country', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Region', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_District', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Location', 'TABLE');

exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Station', 'TABLE');*/

--exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Currency', 'TABLE');

exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Payment', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Payment_Type', 'TABLE');

exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Fuel_Type', 'TABLE');

exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Customer_Type', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Customer', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Organization', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Individual', 'TABLE');


exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Payment', 'SEQUENCE');

exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('SEQ_Payment_ID_PAYMENT', 'SEQUENCE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('SEQ_CE_Payment_Type_ID', 'SEQUENCE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('SEQ_CE_Fuel_Type_ID', 'SEQUENCE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('SEQ_CE_Customer_ID', 'SEQUENCE');


CREATE TABLE CE_Fuel_Type
(
	ID_SEQUENCE NUMBER(16) primary key,
  ID_FUEL_CODE NUMBER(3) NOT NULL,
  ENG_TYPE VARCHAR2(10) not null,
	RUS_TYPE VARCHAR2(26) not null,
  DESCRIPTION VARCHAR2(128) not null,
  start_date date not null,
  end_date date not null,
  is_active number not null
	--,CONSTRAINT PK_Fuel_Type 	PRIMARY KEY (ID_FUEL_CODE)
)
;

CREATE TABLE CE_Customer_Type
(
	ID_CUSTOMER_TYPE NUMBER(1) NOT NULL PRIMARY KEY,
	DESCRIPTION VARCHAR2(50) NOT NULL
)
;
CREATE TABLE CE_Customer
(
	ID_CUSTOMER NUMBER(10) NOT NULL ,
  CUSTOMER_NK VARCHAR2(50) NOT NULL,
	ID_CUSTOMER_TYPE NUMBER(1) NOT NULL,
	ID_LOCATION NUMBER(10),
	ADDRESS VARCHAR2(50),
	PHONE VARCHAR2(50),
	POSTALCODE NUMBER(8),
	EMAIL VARCHAR2(50),
  UPDATE_DATE DATE NOT NULL,
  --END_DATE DATE NOT NULL,
  CONSTRAINT PK_Customer 	PRIMARY KEY (ID_CUSTOMER),
  CONSTRAINT FK_Customer_Customer_Type
	FOREIGN KEY (ID_CUSTOMER_TYPE) REFERENCES CE_Customer_Type (ID_CUSTOMER_TYPE)
)
;
CREATE TABLE CE_Individual
(
	ID_CUSTOMER NUMBER(10) NOT NULL,
  CUSTOMER_NK VARCHAR2(50) NOT NULL ,
	FIRST_NAME VARCHAR2(50) NOT NULL,
	LAST_NAME VARCHAR2(50) NOT NULL,
	MIDDLE_NAME VARCHAR2(50) NOT NULL,
	BIRTHDAY DATE NOT NULL,
	SEX NUMBER(1) NOT NULL,
  VEHICLE_DESC VARCHAR2(50),
  VEHICLE_YEAR number(4),
  CONSTRAINT PK_Individual 	PRIMARY KEY (ID_CUSTOMER),
  CONSTRAINT FK_Individual_Customer
	FOREIGN KEY (ID_CUSTOMER) REFERENCES CE_Customer (ID_CUSTOMER)
)
;
CREATE TABLE CE_Organization
(
	ID_CUSTOMER NUMBER(10) NOT NULL,
  TAX_ID VARCHAR2(50) NOT NULL,
	RUS_FULL_NAME VARCHAR2(400) NOT NULL,
  MNS_NAME VARCHAR2(128) NOT NULL,
  MNS_NUM NUMBER(10) NOT NULL,
  CONSTRAINT PK_Organization 	PRIMARY KEY (ID_CUSTOMER),
  CONSTRAINT FK_Organization_Customer
	FOREIGN KEY (ID_CUSTOMER) REFERENCES CE_Customer (ID_CUSTOMER)
)
;

CREATE TABLE CE_Payment_Type
(
	ID_SEQUENCE NUMBER(16) primary key,
  ID_PAYMENT_TYPE NUMBER(2) NOT NULL,
	ENG_TYPE VARCHAR2(10) not null,
	RUS_TYPE VARCHAR2(100) not null,
  DESCRIPTION VARCHAR2(128) not null,
  start_date date not null,
  end_date date not null,
  is_active number not null--,
  --CONSTRAINT PK_Payment_Type 	PRIMARY KEY (ID_PAYMENT_TYPE)
  )
;

SELECT * FROM CE_Payment;
drop table CE_Payment;
CREATE TABLE CE_Payment
(
	ID_PAYMENT NUMBER(16) NOT NULL,
	--ID_CURRENCY VARCHAR2(3) NOT NULL,
	ID_CUSTOMER NUMBER(10),
	ID_PAYMENT_TYPE NUMBER(2) NOT NULL,
  ID_STATION NUMBER(4) NOT NULL,
  ID_FUEL_CODE NUMBER(3) NOT NULL,
  
	PAYMENT_DATE DATE NOT NULL,
	PRICE NUMBER(8,2) NOT NULL,
  QUANTITY NUMBER(10,3) NOT NULL,
	PAYMENT_TIME varchar2(10),
	
  CONSTRAINT FK_Payment_Customer
	FOREIGN KEY (ID_CUSTOMER) REFERENCES CE_Customer (ID_CUSTOMER),
 
  CONSTRAINT FK_Payment_Payment_Type
	FOREIGN KEY (ID_PAYMENT_TYPE) REFERENCES CE_Payment_Type (ID_SEQUENCE),

  CONSTRAINT FK_Payment_Station
	FOREIGN KEY (ID_STATION) REFERENCES CE_AZS (ID_STATION),
  
   CONSTRAINT FK_Payment_Fuel_Type
	FOREIGN KEY (ID_FUEL_CODE) REFERENCES CE_Fuel_Type (ID_SEQUENCE)

) PARTITION BY RANGE (PAYMENT_DATE)
  (
  PARTITION pr0 VALUES LESS THAN (TO_DATE('01-01-2016', 'DD-MM-YYYY')),
  PARTITION pr1 VALUES LESS THAN (TO_DATE('01-01-2017', 'DD-MM-YYYY')),
  PARTITION pr2 VALUES LESS THAN (TO_DATE('01-01-2018', 'DD-MM-YYYY')),
  PARTITION pr3 VALUES LESS THAN (TO_DATE('01-01-2019', 'DD-MM-YYYY')),
  PARTITION pr4 VALUES LESS THAN (MAXVALUE)
  )
;

/*CREATE SEQUENCE SEQ_Payment_ID_PAYMENT 
	INCREMENT BY 1 
	START WITH 1 
	NOMAXVALUE 
	MINVALUE  1 
	NOCYCLE 
	NOCACHE 
	NOORDER
;
*/
CREATE SEQUENCE SEQ_CE_Payment_Type_ID 
	INCREMENT BY 1 
	START WITH 1 
	NOMAXVALUE 
	MINVALUE  1 
	NOCYCLE 
	NOCACHE 
	NOORDER
;
CREATE SEQUENCE SEQ_CE_Fuel_Type_ID 
	INCREMENT BY 1 
	START WITH 1 
	NOMAXVALUE 
	MINVALUE  1 
	NOCYCLE 
	NOCACHE 
	NOORDER
;

CREATE SEQUENCE SEQ_CE_Customer_ID 
	INCREMENT BY 1 
	START WITH 1 
	NOMAXVALUE 
	MINVALUE  1 
	NOCYCLE 
	NOCACHE 
	NOORDER
;

exec FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_CE_Customer_Type','TABLE');
exec dbms_errlog.create_error_log('CE_Customer_Type','ERROR_CE_Customer_Type') ;

exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','CE_Payment_Type','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','CE_Fuel_Type','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','CE_Customer_Type','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','CE_Customer','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','CE_Organization','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','CE_Individual','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','CE_Payment','BL_CL');

exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','ERROR_CE_Customer_Type','BL_CL');


--exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','SEQ_Payment_ID_PAYMENT','FRAMEWORK');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','SEQ_CE_Fuel_Type_ID','FRAMEWORK');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','SEQ_CE_Payment_Type_ID','FRAMEWORK');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','SEQ_CE_Customer_ID','FRAMEWORK');


--exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','SEQ_Payment_ID_PAYMENT','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','SEQ_CE_Fuel_Type_ID','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','SEQ_CE_Payment_Type_ID','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','SEQ_CE_Customer_ID','Public');


exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','CE_Payment_Type','BL_CL_DM');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','CE_Fuel_Type','BL_CL_DM');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','CE_Customer_Type','BL_CL_DM');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','CE_Customer','BL_CL_DM');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','CE_Organization','BL_CL_DM');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','CE_Individual','BL_CL_DM');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','CE_Payment','BL_CL_DM');

/*
grant select on Station to BL_CL2;
grant update on Station to BL_CL2;--BL_CL2;
grant insert on Station to BL_CL2;--BL_CL2;

grant select on Currency to BL_CL2;
grant update on Currency to BL_CL2;--BL_CL2;
grant insert on Currency to BL_CL2;

grant select on Payment_Type to BL_CL2;
grant update on Payment_Type to BL_CL2;--BL_CL2;
grant insert on Payment_Type to BL_CL2;

grant select on Customer to BL_CL2;
grant update on Customer to BL_CL2;--BL_CL2;
grant insert on Customer to BL_CL2;

grant select on Individual to BL_CL2;
grant update on Individual to BL_CL2;--BL_CL2;
grant insert on Individual to BL_CL2;


grant select on CUSTOMER_TYPE to BL_CL2;
grant update on CUSTOMER_TYPE to BL_CL2;--BL_CL2;
grant insert on CUSTOMER_TYPE to BL_CL2;*/