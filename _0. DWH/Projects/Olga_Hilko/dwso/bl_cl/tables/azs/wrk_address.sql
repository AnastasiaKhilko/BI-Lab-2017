exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('wrk_address', 'TABLE');
 
CREATE TABLE wrk_address 
( longitude NUMBER(10, 6),
  latitude NUMBER(10, 6),
  country VARCHAR2(50),
  c1 VARCHAR2(100),
  c2 VARCHAR2(100),
  c3 VARCHAR2(128),
  c4 VARCHAR2(50),
  c5 VARCHAR2(50),
  c6 VARCHAR2(50));
  
 insert into wrk_address
 SELECT LONGITUDE,
  LATITUDE,
  COUNTRY,
  C1,  C2,  C3,  C4,  C5,  C6
FROM SRC.SRC_ADDRESS ;
commit;
  select count(*) from wrk_address ;