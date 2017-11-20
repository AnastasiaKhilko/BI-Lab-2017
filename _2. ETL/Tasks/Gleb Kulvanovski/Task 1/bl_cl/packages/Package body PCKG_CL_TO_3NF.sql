CREATE OR REPLACE PACKAGE BODY PCKG_CL_TO_3NF AS
  PROCEDURE CL_TO_3NF_Continents
    IS
    before_err_cnt INT;
    after_err_cnt INT;
    BEGIN
      SELECT count(1) INTO before_err_cnt FROM ERROR_Continents;
      INSERT INTO BL_3NF.Continents (continent_id, continent_name)
      SELECT  continent_id, continent_name
      FROM CL_Continents
      LOG ERRORS INTO ERROR_Continents
      REJECT LIMIT UNLIMITED;
      SELECT count(1) INTO after_err_cnt FROM ERROR_Continents;
      IF before_err_cnt != after_err_cnt THEN
        dbms_output.put_line('Number of error is ' || to_char(after_err_cnt-before_err_cnt) || ' row in CL_Continents table');
      ELSE 
        dbms_output.put_line('Loading sucsses');
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
        dbms_output.put_line('Number of error is ' || to_char(after_err_cnt-before_err_cnt) || ' row in CL_Continents table');
      ELSE 
        dbms_output.put_line('Loading sucsses');
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
        dbms_output.put_line('Number of error is ' || to_char(after_err_cnt-before_err_cnt) || ' row in CL_Continents table');
      ELSE 
        dbms_output.put_line('Loading sucsses');
      END IF;  
    END CL_TO_3NF_Countries;
END PCKG_CL_TO_3NF;
/ 
