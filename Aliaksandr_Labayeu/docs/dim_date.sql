------------------------------------------------------------------------------
-- Date Dimension for PMI Data Warehouse for 30 years from 2000 to 2030 ------
------------------------------------------------------------------------------

DROP TABLE dim_date;
CREATE TABLE dim_date AS
SELECT
TO_DATE('31/12/2007','DD/MM/YYYY') + n AS Full_Date,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n,'d')) AS Day_Week,
UPPER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'Dy')) AS Day_Short,
TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'DAY') AS Day_Long,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'DD')) AS Day_Month,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'DDD')) AS Day_Year,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'MM')) AS Month_Year,
UPPER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'Mon')) AS Month_Short,
UPPER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'Month')) AS Month_Long,
  CASE 
    WHEN EXTRACT(MONTH FROM (TO_DATE('31/12/1999','DD/MM/YYYY') + n)) <=3 THEN '1'
    WHEN EXTRACT(MONTH FROM (TO_DATE('31/12/1999','DD/MM/YYYY') + n)) BETWEEN 3 AND 6  THEN '2'
    WHEN EXTRACT(MONTH FROM (TO_DATE('31/12/1999','DD/MM/YYYY') + n)) BETWEEN 6 AND 9 THEN '3'
    WHEN EXTRACT(MONTH FROM (TO_DATE('31/12/1999','DD/MM/YYYY') + n)) BETWEEN 9 AND 12 THEN '4'
  END
AS Quarter,
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