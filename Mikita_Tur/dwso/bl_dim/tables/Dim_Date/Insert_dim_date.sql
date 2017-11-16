INSERT INTO  DIM_DATE 
SELECT SYSDATE+rownum-365*10 as Date_id, 
       to_number(to_char(SYSDATE+rownum-365*10-1, 'D')) as Day_of_week,
       to_char(SYSDATE+rownum-365*10,'Day','NLS_DATE_LANGUAGE = ENGLISH') AS Day_name_of_week,       
       to_number(to_char(extract(day from SYSDATE+rownum-365*10)))as Day_of_month,
       to_number(to_char(SYSDATE+rownum-365*10, 'DDD')) AS Day_of_year,
       to_number(to_char(SYSDATE+rownum-365*10, 'W')) AS Week_of_month,
       to_number(to_char(SYSDATE+rownum-365*10, 'IW')) AS Week_of_year,
       to_number(to_char(extract(month from SYSDATE+rownum-365*10))) as Month_number,
       to_char(SYSDATE+rownum-365*7, 'MONTH', 'NLS_DATE_LANGUAGE=ENGLISH') AS Month_name,
       to_number(to_char(SYSDATE+rownum-365*10, 'Q')) AS Quarter,
       to_date(last_day(SYSDATE+rownum-365*10)+1,'DD-MM-YYYY') AS First_day_of_month,
       to_date(last_day(SYSDATE+rownum-365*10),'DD-MM-YYYY') AS Last_day_of_month,
       to_number(to_char(extract(year from SYSDATE+rownum-365*10))) as Year
FROM dual
CONNECT BY LEVEL <=10000;