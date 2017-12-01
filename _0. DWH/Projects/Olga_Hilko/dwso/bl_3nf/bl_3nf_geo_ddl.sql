--show user;
--commit;
--alter session set ddl_lock_timeout=10;
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_AZS', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Location', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_District', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Region', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CE_Country', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('SEQ_CE_AZS_ID', 'SEQUENCE');

create table CE_Country
(id_country NUMBER(10) Primary key,
country_name varchar(100) not null,
country_code varchar(100) not null,
id_parent NUMBER(10),
date_update date not null
);

create table CE_Region
(id_region NUMBER(10) Primary key,
region_name varchar(100) not null,
id_country NUMBER(10) not null,
date_update date not null,
constraint FK_Region_Country FOREIGN KEY (id_country) REFERENCES CE_Country (id_country)  
);


create table CE_District
(id_district NUMBER(10) Primary key,
district_name varchar(100) not null,
id_region NUMBER(10)  not null,
date_update date not null,
constraint FK_District_Region FOREIGN KEY (id_region) REFERENCES CE_Region (id_region)  
);

create table CE_Location
(id_location NUMBER(10) Primary key,
location_name varchar(100) not null,
is_sovet NUMBER(1)  not null,
id_parent NUMBER(10) not null,
date_update date not null,
constraint FK_Location_District FOREIGN KEY (id_parent) REFERENCES CE_District (id_district)  
);


exec FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_CE_Location','TABLE');
exec dbms_errlog.create_error_log('CE_Location','ERROR_CE_Location') ;

exec FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_CE_District','TABLE');
exec dbms_errlog.create_error_log('CE_District','ERROR_CE_District') ;

exec FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_CE_Country','TABLE');
exec dbms_errlog.create_error_log('CE_Country','ERROR_CE_Country') ;

exec FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_CE_Region','TABLE');
exec dbms_errlog.create_error_log('CE_Region','ERROR_CE_Region') ;


CREATE TABLE CE_AZS 
( ID_Station NUMBER(10) primary key,
  No NUMBER(4),
  id_District NUMBER(10, 6),
  Location_Desc varchar(255),
  Latitude NUMBER(10, 6),
  Longitude VARCHAR2(26),
  ROAD1 VARCHAR2(26),
  ROAD2 VARCHAR2(5),
  DT NUMBER(1),
  DT2 NUMBER(1),
  AI92 NUMBER(1),
  BN92 NUMBER(1),
  AI95 NUMBER(1),
  LPG NUMBER(1),
  AI98 NUMBER(1),
  date_update date not null,
  constraint FK_AZS_District FOREIGN KEY (id_District) REFERENCES CE_District (id_District) ,
  constraint U_AZS_Latitude_Longitude unique (Latitude, Longitude)
  )  ;
  --select * from CE_AZS;


CREATE SEQUENCE SEQ_CE_AZS_ID 
	INCREMENT BY 1 
	START WITH 1 
	NOMAXVALUE 
	MINVALUE  1 
	NOCYCLE 
	NOCACHE 
	NOORDER
;

  
/*exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('SEQ_BL_3NF_Customer_ID_CUST', 'SEQUENCE');
CREATE SEQUENCE SEQ_BL_3NF_Customer_ID_CUST 
	INCREMENT BY 1 
	START WITH 1 
	NOMAXVALUE 
	MINVALUE  1 
	NOCYCLE 
	NOCACHE 
	NOORDER
;*/


--GRANT select on BL_CL2.SEQ_BL_3NF_Station_ID_STATION to Public;
--GRANT select on BL_CL2.SEQ_BL_3NF_Customer_ID_CUST to Public;

 
--  select count(*) from wrk_address ;
/*
--exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'BL_3NF','CE_Location','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'BL_3NF','CE_District','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'BL_3NF','CE_Region','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'BL_3NF','CE_Country','BL_CL');

--exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('update', 'BL_3NF','CE_Location','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('update', 'BL_3NF','CE_District','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('update', 'BL_3NF','CE_Region','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('update', 'BL_3NF','CE_Country','BL_CL');

--exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('insert', 'BL_3NF','CE_Location','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('insert', 'BL_3NF','CE_District','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('insert', 'BL_3NF','CE_Region','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('insert', 'BL_3NF','CE_Country','BL_CL');
*/


exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','SEQ_CE_AZS_ID','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','SEQ_CE_AZS_ID','FRAMEWORK');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','CE_Location','BL_CL');


exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','CE_District','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','CE_Region','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','CE_Country','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','CE_AZS','BL_CL');


exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','ERROR_CE_Country','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','ERROR_CE_Region','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','ERROR_CE_District','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','ERROR_CE_Location','BL_CL');



exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','CE_District','BL_CL_DM');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','CE_Region','BL_CL_DM');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','CE_Country','BL_CL_DM');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','CE_AZS','BL_CL_DM');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT', 'BL_3NF','CE_Location','BL_CL_DM');

--exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant (' SELECT, INSERT, UPDATE, DELETE', 'BL_3NF','ERROR_CE_AZS','BL_CL');
--GRANT select on SEQ_BL_3NF_Station_ID_STATION to Public;


/*exec FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_CE_AZS','TABLE');
exec dbms_errlog.create_error_log('CE_AZS','ERROR_CE_AZS') ;*/
--GRANT SELECT, INSERT, UPDATE, DELETE ON ERROR_CE_Region TO BL_CL;