/*select * from SRC.SRC_GEO;
select * from SRC.SRC_AZS;
select * from SRC.SRC_ORG;
select * from SRC.SRC_INDIVIDUALS;
*/

show user;
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('wrk_AZS', 'TABLE');
CREATE TABLE wrk_AZS 
( No NUMBER(4),
  Country VARCHAR2(3),
  Location VARCHAR2(256),
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
  AI98 NUMBER(1));
  
  exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('wrk_GEO', 'TABLE');
  CREATE TABLE wrk_GEO 
( SOATO NUMBER(12) ,
  t1 NUMBER(1),
  t2 NUMBER(3),
  t3 NUMBER(3),
  t4 NUMBER(3),
  NAME NVARCHAR2(100) ,
  OBL VARCHAR2(50),
  RAION VARCHAR2(50),
  SOVET VARCHAR2(128),
  TIP VARCHAR2(26),
  GNI NUMBER(5),
  DATAV DATE ,
  SOATON VARCHAR2(26),
  DATEL DATE ,
  MAL NUMBER(3));
  
  truncate table wrk_GEO;
  insert into wrk_GEO  
 -- select count(*) from
  (SELECT SOATO,substr(to_char(SOATO),1,1) t1, substr(to_char(SOATO),2,3) t2,
  substr(to_char(SOATO),5,3) t3, substr(to_char(SOATO),8,3) t4,
  NAME,   OBL,   RAION,   SOVET,   TIP,   GNI,   DATAV,
  SOATON,   DATEL,   MAL
  FROM SRC.SRC_GEO where datel is null) ;
  commit;
  

  
  
  