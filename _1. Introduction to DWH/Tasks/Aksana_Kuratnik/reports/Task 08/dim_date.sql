CREATE TABLE Dim_Date as
select to_number(to_char(sysdate+rownum-365*10, 'yyyymmdd')) as DATE_ID, 
       sysdate+rownum-365*10 as FULL_DATE, 
       extract(day from sysdate+rownum-365*10)as DAY_OF_MOUNTH,
       to_char(sysdate+rownum-365*10-1, 'D') as DAY_OF_WEEK,
       to_char(sysdate+rownum-365*10, 'DDD') AS DAY_OF_YEAR,
       to_char(sysdate+rownum-365*10, 'W') AS WEEK_OF_MOUNTH,
       to_char(sysdate+rownum-365*10, 'IW') AS WEEK_AF_YEAR,
       extract(month from sysdate+rownum-365*10) as MOUNTH_OF_YEAR,
       to_char(sysdate+rownum-365*10, 'MONTH', 'NLS_DATE_LANGUAGE=ENGLISH') AS MOUNTH_NAME,
       to_char(sysdate+rownum-365*10, 'Q') AS QUARTER,
       extract(year from sysdate+rownum-365*10) as YEAR
from dual
connect by rownum <= 365*10;
