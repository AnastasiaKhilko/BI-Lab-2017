--PKG_CL_TO_3NF_GEO.CL_TO_3NF_Country
CREATE OR REPLACE PACKAGE PKG_CL_TO_3NF_GEO AS
  PROCEDURE CL_TO_3NF_Country;
--  PROCEDURE create_errorlogs(rewrite_all IN INTEGER);
--  PROCEDURE CL_TO_3NF_Regions;
--  PROCEDURE CL_TO_3NF_Countries;
END PKG_CL_TO_3NF_GEO;
/


CREATE OR REPLACE PACKAGE BODY PKG_CL_TO_3NF_GEO AS
 /*  PROCEDURE create_errorlogs(rewrite_all IN INTEGER)
    IS
    ex_table EXCEPTION;
   PRAGMA EXCEPTION_INIT( ex_table, -00942 );
   
   begin
    case  when rewrite_all=1 then 
     dbms_output.put_line('User has no grants');
     -- dbms_errlog.create_error_log('CL_Continents','ERROR_Continents');
      --FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_Continents','TABLE');
      -- EXECUTE IMMEDIATE 'TRUNCATE TABLE BL_CL.ERROR_Continents  drop storage';
    else 
      FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_Continents','TABLE');
      dbms_errlog.create_error_log('CL_Continents','ERROR_Continents') ;
    end case;
       EXCEPTION 
       when ex_table then
          dbms_output.put_line('User has no grants');
      WHEN OTHERS THEN
          NULL;

   end create_errorlogs;*/
   
  PROCEDURE CL_TO_3NF_Country
    IS
    before_err_cnt NUMBER;
    after_err_cnt NUMBER;
    table_name varchar2(50):='BL_3NF.CE_Country';
    src_table_name varchar2(50):='CL_Country';
    error_table varchar2(50):='BL_3NF.ERROR_CE_Country';
    sql_stmt varchar2(256);
    BEGIN
    sql_stmt := 'begin SELECT COUNT(*) INTO :before_err_cnt FROM '|| error_table||'  ; end;'     ;
    EXECUTE IMMEDIATE sql_stmt USING out before_err_cnt;
   
  
   --  SELECT count(1) INTO before_err_cnt FROM BL_3NF.ERROR_CE_Country;
    --   SELECT count(1) INTO before_err_cnt FROM BL_3NF.ERROR_CE_Country;
   /* sql_stmt:='INSERT INTO '|| table_name || ' select * from ' || src_table_name
      || ' LOG ERRORS INTO ' || error_table || 'REJECT LIMIT UNLIMITED;';
      EXECUTE IMMEDIATE sql_stmt;*/
     INSERT INTO  BL_3NF.CE_Country --(ID_COUNTRY, COUNTRY_NAME, COUNTRY_CODE,  ID_PARENT,  DATE_UPDATE) 
     SELECT  * --ID_COUNTRY, COUNTRY_NAME, COUNTRY_CODE,  ID_PARENT,  DATE_UPDATE
     FROM CL_Country
     LOG ERRORS INTO BL_3NF.ERROR_CE_Country
     REJECT LIMIT UNLIMITED;
     sql_stmt := 'begin SELECT COUNT(*) INTO :after_err_cnt FROM '|| error_table||'  ; end;'     ;
    EXECUTE IMMEDIATE sql_stmt USING out after_err_cnt;
     -- SELECT count(1) INTO after_err_cnt FROM BL_3NF.ERROR_CE_Country;
      IF before_err_cnt != after_err_cnt THEN
        dbms_output.put_line('Lola: Not insered rows in '||table_name ||' table:' || to_char(after_err_cnt-before_err_cnt) || ' row(s)');
      ELSE 
        dbms_output.put_line('Lola: Loading into '||table_name ||' is successful');
      END IF; 
   
    END CL_TO_3NF_Country;
    
  /*PROCEDURE CL_TO_3NF_Regions 
     IS
     before_err_cnt INT;
     after_err_cnt INT;
     BEGIN
      SELECT count(1) INTO before_err_cnt FROM ERROR_Regions;
      INSERT INTO BL_3NF.Regions (Region_id, Region_name, Continent_id)
      SELECT Region_id, Region_name, Continent_id
      FROM cl_Regions
      LOG ERRORS INTO ERROR_Regions
      REJECT LIMIT UNLIMITED;
      SELECT count(1) INTO after_err_cnt FROM ERROR_Regions;
     IF before_err_cnt != after_err_cnt THEN
        dbms_output.put_line('Lola: Unpasted rows in BL_3NF.Regions table:' || to_char(after_err_cnt-before_err_cnt) || ' row(s)');
      ELSE 
        dbms_output.put_line('Lola: Loading into BL_3NF.Regions  is successful');
      END IF; 
   END CL_TO_3NF_Regions;
    
   PROCEDURE CL_TO_3NF_Countries
    IS
    before_err_cnt INT;
    after_err_cnt INT;
    BEGIN
      SELECT count(1) INTO before_err_cnt FROM ERROR_Countries;
      INSERT INTO BL_3NF.Countries (Country_id, country_name, country_code, region_id)
      SELECT Country_id, country_name, country_code, region_id
      FROM cl_Countries
      LOG ERRORS INTO ERROR_Countries
      REJECT LIMIT UNLIMITED;
      SELECT count(1) INTO after_err_cnt FROM ERROR_Countries;
     IF before_err_cnt != after_err_cnt THEN
        dbms_output.put_line('Lola: Unpasted rows in BL_3NF.Countries table:' || to_char(after_err_cnt-before_err_cnt) || ' row(s)');
      ELSE 
        dbms_output.put_line('Lola: Loading into BL_3NF.Countries  is successful');
      END IF; 
    END CL_TO_3NF_Countries;*/
    
END PKG_CL_TO_3NF_GEO;
/ 

