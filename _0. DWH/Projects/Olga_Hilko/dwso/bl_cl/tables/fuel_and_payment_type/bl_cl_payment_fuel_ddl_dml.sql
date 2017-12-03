exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('wrk_Fuel_Type', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('wrk_Payment_Type', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('cl_Fuel_Type', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('Cl_Payment_Type', 'TABLE');
CREATE TABLE wrk_Fuel_Type
(
	--ID_FUEL_TYPE NUMBER(10) NOT NULL,
  ID_FUEL_CODE NUMBER(3) ,
  ENG_TYPE VARCHAR2(10) ,
	RUS_TYPE VARCHAR2(26) ,
  DESCRIPTION VARCHAR2(128),
  start_date VARCHAR2(10) ,
  end_date VARCHAR2(10)
)
;
CREATE TABLE wrk_Payment_Type
(
	ID_PAYMENT_TYPE NUMBER(2) ,
	ENG_TYPE VARCHAR2(10) ,
	RUS_TYPE VARCHAR2(100),
  DESCRIPTION VARCHAR2(128),
  start_date VARCHAR2(10),
  end_date VARCHAR2(10) 
   )
;


CREATE TABLE cl_Fuel_Type
(
	--ID_FUEL_TYPE NUMBER(10) NOT NULL,
  ID_FUEL_CODE NUMBER(3) NOT NULL,
  ENG_TYPE VARCHAR2(10) not null,
	RUS_TYPE VARCHAR2(26) not null,
  DESCRIPTION VARCHAR2(128) not null,
  start_date date not null,
  end_date date not null,
  is_active number not null
	
)
;
CREATE TABLE cl_Payment_Type
(
	ID_PAYMENT_TYPE NUMBER(2) NOT NULL,
	ENG_TYPE VARCHAR2(10) not null,
	RUS_TYPE VARCHAR2(100) not null,
  DESCRIPTION VARCHAR2(128) not null,
  start_date date not null,
  end_date date not null,
  is_active number not null
 )
;
