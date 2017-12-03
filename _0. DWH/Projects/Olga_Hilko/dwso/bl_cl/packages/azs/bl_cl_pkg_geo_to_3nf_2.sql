--PKG_CL_TO_3NF_GEO.CL_TO_3NF_Country
--PKG_CL_TO_3NF_GEO.azs_to_3nf
CREATE OR REPLACE PACKAGE PKG_CL_TO_3NF_GEO AS
  PROCEDURE SRC_TO_WRK_AZS_GEO;
  PROCEDURE SRC_TO_CL_GEO;
 -- PROCEDURE SRC_TO_CL_AZS;
  PROCEDURE CL_TO_3NF_Country (table_name IN VARCHAR2,error_table IN VARCHAR2);
  PROCEDURE CL_TO_3NF_Region (table_name IN VARCHAR2,error_table IN VARCHAR2);
  PROCEDURE CL_TO_3NF_District (table_name IN VARCHAR2,error_table IN VARCHAR2);
  PROCEDURE CL_TO_3NF_Location (table_name IN VARCHAR2,error_table IN VARCHAR2);
  PROCEDURE CL_TO_3NF_AZS;
END PKG_CL_TO_3NF_GEO;
/


create or replace PACKAGE BODY PKG_CL_TO_3NF_GEO AS

PROCEDURE SRC_TO_WRK_AZS_GEO
as
begin
 insert into wrk_address
 SELECT LONGITUDE,  LATITUDE,  COUNTRY,
  C1,  C2,  C3,  C4,  C5,  C6
 FROM SRC.SRC_ADDRESS ;

 insert into wrk_AZS
 select * from src.src_AZS;
  /*
 insert into wrk_address
 SELECT LONGITUDE,   LATITUDE,   COUNTRY,  C1,  C2,  C3,  C4,  C5,  C6
 FROM SRC.SRC_ADDRESS ;*/
 
 insert into wrk_GEO  
 (SELECT SOATO,substr(to_char(SOATO),1,1) t1, substr(to_char(SOATO),2,3) t2,
  substr(to_char(SOATO),5,3) t3, substr(to_char(SOATO),8,3) t4, name,
  OBL,   RAION,   SOVET,   TIP,   GNI,   DATAV,   SOATON,   DATEL,   MAL
  FROM SRC.SRC_GEO where datel is null and name is not null) ; 
 EXCEPTION
 WHEN OTHERS THEN
  RAISE;
end SRC_TO_WRK_AZS_GEO;


PROCEDURE SRC_TO_CL_GEO
as
begin
  insert into CL_Country (id_country,country_name,country_code,id_parent,date_update) values (1,'Республика Беларусь','BY',null,sysdate);

  insert into CL_Region 
  (select distinct t1, obl,1 as id_country, sysdate from wrk_GEO s where obl is not null)
  UNION all
  select 0, 'Республика Беларусь',1 as id_country, sysdate from dual
  UNION
  select 5, 'Минск'as name,1 as id_country, sysdate from dual
  ; --6 области (РБ) + 1 fake for roads

  insert into CL_District
  select distinct --t1*1000+t2 child_id, 
  case when gni=671 then 613
       else gni end gni,
  raion  || ' район' child_name, t1, 
  (select max(datav) from (select w.*, DENSE_RANK() OVER (partition by w.t1,w.t2 ORDER BY w.datav DESC) r from wrk_GEO w)  where r=1) as datav
  from wrk_GEO s  where raion is not null
  and gni not in (400,432) order by 2;  --122 района (обл. подчинение)

  insert into CL_District 
  select -(cast (oblast.t1 as number)) id_fake ,oblast.obl,cast (oblast.t1 as number) id_obl, sysdate from
  (select distinct t1, obl from wrk_GEO s where obl is not null order by obl --6 областей (РБ)
  ) oblast
  union all
  select -t1,name,t1, sysdate --,w.name,0,-5, datav
  from wrk_GEO w where name='Минск' 
  union all
  select 0,'Республиканское подчинение' name,0, sysdate --,w.name,0,-5, datav
  from wrk_GEO w where name='Минск' ;

 insert into CL_Location                                --кроме городов областного подчинения 23,648 /23651 - c t3=0
 select w.soato, w.name, 0,
 case when gni=671 then 613
 when gni=400 then 405 
 else gni end gni,                         --было: 27189  нас. пункты (сель/сов)  /23403
 datav
 from wrk_GEO w 
 left join CL_District s on s.id_District = (case when gni=671 then 613 when gni=400 then 405 else gni end)
 where w.name is not null and s.id_District is not null and t3!=0 and gni!=400 ;
 
 insert into CL_Location   
 select w.soato, w.name,0, -t1 , datav                         --7 городов областного полчинения
 from wrk_GEO w 
 where w.name is not null and obl is not null and t3=0  ;

  insert into CL_Location   
  select w.soato ,w.name,0, -t1 , datav  
  from wrk_GEO w where  obl is null and name is not null and name !='Минск' --5 областных города (РБ)
  union ALL
  select w.soato ,w.name,0,-5, datav
  from wrk_GEO w 
  where name='Минск' ;

EXCEPTION
WHEN OTHERS THEN
  RAISE;
end SRC_TO_CL_GEO;
/*PROCEDURE SRC_TO_CL_AZS
as
begin
 
 insert into wrk_address
 SELECT LONGITUDE,   LATITUDE,   COUNTRY,  C1,  C2,  C3,  C4,  C5,  C6
 FROM SRC.SRC_ADDRESS ;
  
 insert into wrk_GEO  
 (SELECT SOATO,substr(to_char(SOATO),1,1) t1, substr(to_char(SOATO),2,3) t2,
  substr(to_char(SOATO),5,3) t3, substr(to_char(SOATO),8,3) t4, name,
  OBL,   RAION,   SOVET,   TIP,   GNI,   DATAV,   SOATON,   DATEL,   MAL
  FROM SRC.SRC_GEO where datel is null and name is not null) ; 
EXCEPTION
WHEN OTHERS THEN
  RAISE;
end SRC_TO_CL_AZS;*/


   
 PROCEDURE CL_TO_3NF_Country (table_name IN VARCHAR2,error_table IN VARCHAR2)
    IS
    before_err_cnt NUMBER;
    after_err_cnt NUMBER;
    sql_stmt varchar2(256);
    BEGIN
    sql_stmt := 'begin SELECT COUNT(*) INTO :before_err_cnt FROM '|| error_table||'  ; end;'     ;
    EXECUTE IMMEDIATE sql_stmt USING out before_err_cnt;
     /* sql_stmt:='INSERT INTO '|| table_name || ' select * from ' || src_table_name
      || ' LOG ERRORS INTO ' || error_table || 'REJECT LIMIT UNLIMITED;';
      EXECUTE IMMEDIATE sql_stmt;*/
     INSERT INTO  BL_3NF.CE_Country --(ID_COUNTRY, COUNTRY_NAME, COUNTRY_CODE,  ID_PARENT,  DATE_UPDATE) 
     SELECT  * --ID_COUNTRY, COUNTRY_NAME, COUNTRY_CODE,  ID_PARENT,  DATE_UPDATE
     FROM CL_Country  LOG ERRORS INTO BL_3NF.ERROR_CE_Country
     REJECT LIMIT UNLIMITED;
     sql_stmt := 'begin SELECT COUNT(*) INTO :after_err_cnt FROM '|| error_table||'  ; end;'     ;
     EXECUTE IMMEDIATE sql_stmt USING out after_err_cnt;
      IF before_err_cnt != after_err_cnt THEN
        dbms_output.put_line('Lola: Not insered rows in '||table_name ||' table:' || to_char(after_err_cnt-before_err_cnt) || ' row(s)');
      ELSE 
        dbms_output.put_line('Lola: Loading into '||table_name ||' is successful');
      END IF; 
   
    END CL_TO_3NF_Country;
  
 PROCEDURE CL_TO_3NF_Region (table_name IN VARCHAR2,error_table IN VARCHAR2)
    IS
    before_err_cnt NUMBER;
    after_err_cnt NUMBER;
    sql_stmt varchar2(256);
    BEGIN
    sql_stmt := 'begin SELECT COUNT(*) INTO :before_err_cnt FROM '|| error_table||'  ; end;'     ;
    EXECUTE IMMEDIATE sql_stmt USING out before_err_cnt;
     INSERT INTO  BL_3NF.CE_Region --(ID_COUNTRY, COUNTRY_NAME, COUNTRY_CODE,  ID_PARENT,  DATE_UPDATE) 
     SELECT  * --ID_COUNTRY, COUNTRY_NAME, COUNTRY_CODE,  ID_PARENT,  DATE_UPDATE
     FROM CL_Region  LOG ERRORS INTO BL_3NF.ERROR_CE_Region
     REJECT LIMIT UNLIMITED;
     sql_stmt := 'begin SELECT COUNT(*) INTO :after_err_cnt FROM '|| error_table||'  ; end;'     ;
     EXECUTE IMMEDIATE sql_stmt USING out after_err_cnt;
      IF before_err_cnt != after_err_cnt THEN
        dbms_output.put_line('Lola: Not insered rows in '||table_name ||' table:' || to_char(after_err_cnt-before_err_cnt) || ' row(s)');
      ELSE 
        dbms_output.put_line('Lola: Loading into '||table_name ||' is successful');
      END IF; 
   
    END CL_TO_3NF_Region;
    
 PROCEDURE CL_TO_3NF_District (table_name IN VARCHAR2,error_table IN VARCHAR2)
    IS
    before_err_cnt NUMBER;
    after_err_cnt NUMBER;
    sql_stmt varchar2(256);
    BEGIN
    sql_stmt := 'begin SELECT COUNT(*) INTO :before_err_cnt FROM '|| error_table||'  ; end;'     ;
    EXECUTE IMMEDIATE sql_stmt USING out before_err_cnt;
     INSERT INTO  BL_3NF.CE_District --(ID_COUNTRY, COUNTRY_NAME, COUNTRY_CODE,  ID_PARENT,  DATE_UPDATE) 
     SELECT  * --ID_COUNTRY, COUNTRY_NAME, COUNTRY_CODE,  ID_PARENT,  DATE_UPDATE
     FROM CL_District  LOG ERRORS INTO BL_3NF.ERROR_CE_District
     REJECT LIMIT UNLIMITED;
     sql_stmt := 'begin SELECT COUNT(*) INTO :after_err_cnt FROM '|| error_table||'  ; end;'     ;
     EXECUTE IMMEDIATE sql_stmt USING out after_err_cnt;
      IF before_err_cnt != after_err_cnt THEN
        dbms_output.put_line('Lola: Not insered rows in '||table_name ||' table:' || to_char(after_err_cnt-before_err_cnt) || ' row(s)');
      ELSE 
        dbms_output.put_line('Lola: Loading into '||table_name ||' is successful');
      END IF; 
   
    END CL_TO_3NF_District;
    
 PROCEDURE CL_TO_3NF_Location (table_name IN VARCHAR2,error_table IN VARCHAR2)
    IS
    before_err_cnt NUMBER;
    after_err_cnt NUMBER;
    sql_stmt varchar2(256);
    BEGIN
    
    sql_stmt := 'begin SELECT COUNT(*) INTO :before_err_cnt FROM '|| error_table||'  ; end;'     ;
    EXECUTE IMMEDIATE sql_stmt USING out before_err_cnt;
     INSERT INTO  BL_3NF.CE_Location --(ID_COUNTRY, COUNTRY_NAME, COUNTRY_CODE,  ID_PARENT,  DATE_UPDATE) 
     SELECT  * --ID_COUNTRY, COUNTRY_NAME, COUNTRY_CODE,  ID_PARENT,  DATE_UPDATE
     FROM CL_Location  LOG ERRORS INTO BL_3NF.ERROR_CE_Location
     REJECT LIMIT UNLIMITED;
     sql_stmt := 'begin SELECT COUNT(*) INTO :after_err_cnt FROM '|| error_table||'  ; end;'     ;
     EXECUTE IMMEDIATE sql_stmt USING out after_err_cnt;
      IF before_err_cnt != after_err_cnt THEN
        dbms_output.put_line('Lola: Not insered rows in '||table_name ||' table:' || to_char(after_err_cnt-before_err_cnt) || ' row(s)');
      ELSE 
        dbms_output.put_line('Lola: Loading into '||table_name ||' is successful');
      END IF; 
   
    END CL_TO_3NF_Location;    

 procedure CL_TO_3NF_AZS
 is
  cursor cur is (select LONGITUDE,   LATITUDE, ID_DISTRICT,DISTRICT_NAME  from 
 (select a.* ,dense_rank() over(partition by LONGITUDE,LATITUDE order by ID_DISTRICT ) r from CL_AZS_MAP_ADDRESS a) t where t.r=1);
-- TYPE t_address
  -- IS TABLE OF employees%ROWTYPE
    --  INDEX BY PLS_INTEGER;
  -- l_employees employees_aat;
 sql_stat varchar(400);
 before_cnt NUMBER;
 after_cnt NUMBER;
 table_name varchar(100):='BL_3NF.ce_AZS';
 begin
     before_cnt :=  FRAMEWORK.PKG_UTL.get_row_count(table_name) ;

           MERGE INTO  BL_3NF.ce_AZS nf USING
          ( select w.No,  tmp.ID_DISTRICT , w.LOCATION ,w.LATITUDE,  w.LONGITUDE,  w.ROAD1,  w.ROAD2,  
                  w.DT,  w.DT2,  w.AI92,  w.BN92,  w.AI95,  w.LPG,  w.AI98  
                   FROM WRK_AZS w
                   left join (select LONGITUDE,   LATITUDE, ID_DISTRICT,DISTRICT_NAME  from 
                      (select LONGITUDE,   LATITUDE, ID_DISTRICT,DISTRICT_NAME ,dense_rank() over(partition by LONGITUDE,LATITUDE order by ID_DISTRICT ) r 
                      from CL_AZS_MAP_ADDRESS) t 
                      where t.r=1) tmp
                   on tmp.LONGITUDE=w.LONGITUDE and tmp.LATITUDE=w.LATITUDE )
      cls ON (
           cls.LONGITUDE= nf.LONGITUDE and cls.LATITUDE=nf.LATITUDE
      ) WHEN MATCHED THEN
          UPDATE
              SET 
              nf.No=cls.No,  nf.ID_DISTRICT=cls.ID_DISTRICT , nf.Location_Desc=cls.LOCATION ,
              nf.ROAD1=cls.ROAD1,  nf.ROAD2=cls.ROAD2,  nf.DT=cls.DT,  
              nf.DT2=cls.DT2,  nf.AI92=cls.AI92,  nf.BN92=cls.BN92, 
              nf.AI95=cls.AI95,  nf.LPG=cls.LPG,  nf.AI98=cls.AI98,
              date_update=SYSDATE
     
              where  
              decode(nf.No,cls.No,0,1)+decode(nf.ID_DISTRICT,cls.ID_DISTRICT,0,1)+decode(nf.Location_Desc,cls.LOCATION,0,1)+
              decode(nf.ROAD1,cls.ROAD1,0,1)+
              decode(nf.ROAD2,cls.ROAD2,0,1)+decode(nf.DT,cls.DT,0,1)+decode(nf.DT2,cls.DT2,0,1)+
              decode(nf.AI92,cls.AI92,0,1)+decode(nf.BN92,cls.BN92,0,1)+decode(nf.AI95,cls.AI95,0,1)+
              decode(nf.LPG,cls.LPG,0,1)+decode(nf.AI98,cls.AI98,0,1)>0
          WHEN NOT MATCHED 
           THEN INSERT 
              (ID_Station, NO, ID_DISTRICT, Location_Desc,  LATITUDE,  LONGITUDE, ROAD1,
              ROAD2,  DT,  DT2,  AI92,  BN92,  AI95,  LPG,  AI98, date_update) 
              VALUES
             (FRAMEWORK.pkg_utl_seq.seq_getval('BL_3NF.SEQ_CE_AZS_ID'),
              cls.NO, cls.ID_DISTRICT, cls.Location, cls.LATITUDE,  cls.LONGITUDE, cls. ROAD1,
              cls.ROAD2, cls. DT, cls. DT2, cls. AI92, cls. BN92, cls. AI95, cls. LPG, cls. AI98, SYSDATE
        );
     
     after_cnt :=  FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
     dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');
 end CL_TO_3NF_AZS;

PROCEDURE TEMPL
as
begin
null;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
end TEMPL;
    
END PKG_CL_TO_3NF_GEO;

/*


DECLARE
   TYPE ids_t IS TABLE OF cl_AZS %ROWTYPE;

   l_ids   ids_t := ids_t (100, 200, 300);
BEGIN
   FORALL indx IN 1 .. l_ids.COUNT
   LOOP
      UPDATE plch_employees
         SET last_name = UPPER (last_name)
       WHERE employee_id = l_ids (indx);
   END LOOP;       
END;



PROCEDURE process_all_rows
IS
   TYPE employees_aat 
   IS TABLE OF employees%ROWTYPE
      INDEX BY PLS_INTEGER;
   l_employees employees_aat;
BEGIN
   SELECT *
   BULK COLLECT INTO l_employees
      FROM employees;
     
   FOR indx IN 1 .. l_employees.COUNT 
   LOOP
       analyze_compensation 
      (l_employees(indx));
   END LOOP;
END process_all_rows;




 CREATE OR REPLACE Function TotalIncome
   ( dep_id IN number ) return cursor
   IS
   total_val number(6);
   cursor c1 is (select * from HR.EMPLOYEES where DEPARTMENT_ID=dep_id);
 begin
   total_val := 0;

   FOR employee_rec in c1
   LOOP
      total_val := total_val + employee_rec.monthly_income;
   END LOOP;

   RETURN total_val;
 end;
 
 */