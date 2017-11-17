------------------------------------------------------------------------------
-- Date Dimension for PMI Data Warehouse for 30 years from 2000 to 2030 ------
------------------------------------------------------------------------------

DROP TABLE dim_date;

CREATE TABLE dim_date (
  Full_date DATE PRIMARY KEY,
  Day_Week NUMBER(1),
  DAY_short VARCHAR(20),
  DAY_long VARCHAR2(20),
  DAY_month NUMBER(2),
  LastDay_month DATE,
  DAY_YEAR NUMBER(3),
  MONTH_year NUMBER(2),
  MONTH_short VARCHAR2(20),
  MONTH_long VARCHAR2(20),
  MONTH_desc VARCHAR(20),
  Quarter NUMBER(1),
  YEAR_half NUMBER(1),
  YEAR NUMBER(4)
);


INSERT INTO dim_date
-- DROP TABLE dim_date1;
-- CREATE TABLE dim_date1 AS 
SELECT
TO_DATE('31/12/2007','DD/MM/YYYY') + n AS Full_Date,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n,'d')) AS Day_Week,
UPPER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'Dy')) AS Day_Short,
TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'DAY') AS Day_Long,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'DD')) AS Day_Month,
LAST_DAY(TO_DATE('31/12/1999','DD/MM/YYYY') + n) AS LastDay_Month,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'DDD')) AS Day_Year,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'MM')) AS Month_Year,
UPPER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'Mon')) AS Month_Short,
UPPER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'Month')) AS Month_Long,
TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n,'YYYY') || '-' || TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'MM') AS Month_Desc,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'Q')) AS Quarter,
  CASE
    WHEN EXTRACT(MONTH FROM (TO_DATE('31/12/1999','DD/MM/YYYY') + n)) <=6 THEN '1'
    ELSE '2'
  END
AS Year_Half,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n,'YYYY')) AS Year
FROM (
select level n
from dual
connect by level <= 10959
);

SELECT * FROM dim_date;
SELECT to_char(SYSDATE,'Q') FROM dual;
SELECT * FROM sh.TIMES;