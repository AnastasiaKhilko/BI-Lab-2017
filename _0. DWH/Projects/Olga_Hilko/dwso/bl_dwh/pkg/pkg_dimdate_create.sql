--PKG_CL_TO_3NF_GEO.CL_TO_3NF_Country
CREATE OR REPLACE PACKAGE PKG_DWH_DIMDATE AS
  PROCEDURE Proc_DimDate_Recreate(Table_Name in VARCHAR2, Start_date in  DATE, End_Date in DATE, FlagDel in  BOOLEAN);
 --  PROCEDURE create_errorlogs(rewrite_all IN INTEGER);
--  PROCEDURE CL_TO_3NF_Regions;
--  PROCEDURE CL_TO_3NF_Countries;
END PKG_DWH_DIMDATE;
/
CREATE OR REPLACE PACKAGE BODY PKG_DWH_DIMDATE AS
PROCEDURE Proc_DimDate_Recreate (Table_Name VARCHAR2, Start_date DATE, End_Date DATE, FlagDel BOOLEAN)
IS
  T_Name VARCHAR2(30) := Table_Name;
  S_Date DATE := Start_Date;
  E_Date DATE := End_Date;
  cnt INT := 0;
  cnt_days NUMBER(10) := to_number(E_Date-S_Date);
  F_Del BOOLEAN := FlagDel;
  iExist INT;
  date_id DATE;
  day_d NUMBER(2);
  month_d NUMBER(2);
  year_d NUMBER(4);
  Day_y NUMBER(3);
  Day_w NUMBER(1);
  wy NUMBER(2);
  wm NUMBER(1);
  quat NUMBER(1);
  e_d VARCHAR2(15);
  r_d VARCHAR2(25);
  s_d VARCHAR2(15);
  g_d VARCHAR2(15);
  e_m VARCHAR2(15);
  r_m VARCHAR2(25);
  s_m VARCHAR2(15);
  g_m VARCHAR2(15);   
BEGIN
  IF(S_Date>=E_DATE)
  THEN 
    RAISE_APPLICATION_ERROR(-20001, 'End date > start date');
  END IF;
  SELECT COUNT(1) INTO iExist FROM User_Tables WHERE TABLE_NAME = UPPER(T_Name);
  IF (iExist > 0 AND F_Del = FALSE)
  THEN
    RAISE_APPLICATION_ERROR (-20002, 'Table exist');
  ELSIF (iExist > 0 AND F_Del)
  THEN
  EXECUTE IMMEDIATE ('DROP TABLE ' || T_Name);
  END IF;
  EXECUTE IMMEDIATE ('CREATE TABLE ' || T_Name || ' ( Date_id DATE PRIMARY KEY, Day NUMBER(2) NOT NULL, Month NUMBER(2) NOT NULL, Year NUMBER(4), Day_Of_Year NUMBER(3) NOT NULL,
    Day_Of_Week NUMBER(1) NOT NULL, Week_Of_Year NUMBER(2) NOT NULL, Week_Of_Month NUMBER(1) NOT NULL, Quarter NUMBER(1) NOT NULL,
    English_Day_Of_Month VARCHAR2(15) NOT NULL, Russian_Day_Of_Month VARCHAR2(25) NOT NULL, Spanish_Day_Of_Month VARCHAR2(15) NOT NULL, German_Day_Of_Month VARCHAR2(15) NOT NULL,
    English_Month_Name VARCHAR2(15) NOT NULL, Russina_Month_Name VARCHAR2(25) NOT NULL, Spanish_Month_Name VARCHAR2(15) NOT NULL, German_Month_Name VARCHAR2(15) NOT NULL)');
  FOR cnt IN 0..cnt_days LOOP
  date_id := (s_date + cnt);
  day_d := extract(day from S_Date+cnt);
  month_d :=  extract(month from S_Date+cnt);
  year_d  := extract(year from S_Date+cnt);
  Day_y := to_number(to_char(S_Date+cnt, 'DDD'));
  Day_w  := to_number(to_char(S_Date+cnt-1, 'D'));
  wy  := to_number(to_char(S_Date+cnt, 'IW'));
  wm  := to_number(to_char(S_Date+cnt, 'W'));
  quat  := to_number(to_char(S_Date+cnt, 'Q'));
  e_d  := initcap(to_char(S_Date+cnt, 'DAY', 'NLS_DATE_LANGUAGE=ENGLISH'));
  r_d  := lower(to_char(S_Date+cnt, 'DAY', 'NLS_DATE_LANGUAGE=RUSSIAN'));
  s_d := initcap(to_char(S_Date+cnt, 'DAY', 'NLS_DATE_LANGUAGE=SPANISH'));
  g_d := initcap(to_char(S_Date+cnt, 'DAY', 'NLS_DATE_LANGUAGE=GERMAN'));
  e_m := initcap(to_char(S_Date+cnt, 'MONTH', 'NLS_DATE_LANGUAGE=ENGLISH'));
  r_m := lower(to_char(S_Date+cnt, 'MONTH', 'NLS_DATE_LANGUAGE=RUSSIAN'));
  s_m := initcap(to_char(S_Date+cnt, 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH'));
  g_m := initcap(to_char(S_Date+cnt, 'MONTH', 'NLS_DATE_LANGUAGE=GERMAN'));
  EXECUTE IMMEDIATE 'INSERT INTO ' || T_Name || '(Date_id, Day, Month, Year, Day_Of_Year, Day_Of_Week, Week_Of_Year, Week_Of_Month, Quarter, English_Day_Of_Month, Russian_Day_Of_Month,
    Spanish_Day_Of_Month, German_Day_Of_Month, English_Month_Name, Russina_Month_Name, Spanish_Month_Name, German_Month_Name)  VALUES(:b1, :b2, :b3, :b4, :b5, :b6, :b7, :b8,  :b9,
     :b10, :b11, :b12, :b13, :b14,  :b15, :b16, :b17)' USING date_id, day_d, month_d, year_d, day_y, Day_w, wy, wm, quat, e_d, r_d, s_d, g_d, e_m, r_m, s_m, g_m;
    END LOOP;
  COMMIT;
END Proc_DimDate_Recreate; 
end PKG_DWH_DIMDATE;
/