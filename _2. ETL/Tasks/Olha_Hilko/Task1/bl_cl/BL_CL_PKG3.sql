
CREATE OR REPLACE PACKAGE PKG_CL_TO_3NF AS
  PROCEDURE CL_TO_3NF_Continents;
--  PROCEDURE create_errorlogs(rewrite_all IN INTEGER);
  PROCEDURE CL_TO_3NF_Regions;
  PROCEDURE CL_TO_3NF_Countries;
END PKG_CL_TO_3NF;
/


CREATE OR REPLACE PACKAGE BODY PKG_CL_TO_3NF AS
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
   
  PROCEDURE CL_TO_3NF_Continents
    IS
    before_err_cnt NUMBER;
    after_err_cnt NUMBER;
    BEGIN
     
      SELECT count(1) INTO before_err_cnt FROM ERROR_Continents;
      INSERT INTO BL_3NF.Continents (continent_id, continent_name)
      SELECT  continent_id, continent_name
      FROM CL_Continents
      LOG ERRORS INTO ERROR_Continents
      REJECT LIMIT UNLIMITED;
      SELECT count(1) INTO after_err_cnt FROM ERROR_Continents;
      IF before_err_cnt != after_err_cnt THEN
        dbms_output.put_line('Lola: Unpasted rows in BL_3NF.Continents table:' || to_char(after_err_cnt-before_err_cnt) || ' row(s)');
      ELSE 
        dbms_output.put_line('Lola: Loading into BL_3NF.Continents is successful');
      END IF; 
   
    END CL_TO_3NF_Continents;
    
  PROCEDURE CL_TO_3NF_Regions 
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
    END CL_TO_3NF_Countries;
    
END PKG_CL_TO_3NF;
/ 

