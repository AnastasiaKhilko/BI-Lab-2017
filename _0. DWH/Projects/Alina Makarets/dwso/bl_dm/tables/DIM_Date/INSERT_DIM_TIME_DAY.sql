INSERT INTO  DIM_TIME_DAY 
SELECT SYSDATE+rownum-365*7 as Date_id, 
       to_number(to_char(SYSDATE+rownum-365*7-1, 'D')) as Day_of_week,
       to_char(SYSDATE+rownum-365*7,'Day','NLS_DATE_LANGUAGE = RUSSIAN') AS Day_name_of_week,       
       to_number(to_char(extract(day from SYSDATE+rownum-365*7)))as Day_of_month,
       to_number(to_char(SYSDATE+rownum-365*7, 'DDD')) AS Day_of_year,
       to_number(to_char(SYSDATE+rownum-365*7, 'W')) AS Week_of_month,
       to_number(to_char(SYSDATE+rownum-365*7, 'IW')) AS Week_of_year,
       to_number(to_char(extract(month from SYSDATE+rownum-365*7))) as Month_number,
       to_char(SYSDATE+rownum-365*7, 'MONTH', 'NLS_DATE_LANGUAGE=Russian') AS Month_name,
       to_number(to_char(SYSDATE+rownum-365*7, 'Q')) AS Quarter,
       to_date(last_day(SYSDATE+rownum-365*7)+1,'DD-MM-YYYY') AS First_day_of_month,
       to_date(last_day(SYSDATE+rownum-365*7),'DD-MM-YYYY') AS Last_day_of_month,
       to_number(to_char(extract(year from SYSDATE+rownum-365*7))) as Year,
       to_char(extract(year from SYSDATE+rownum-365*7) || ' '|| to_char(SYSDATE+rownum-365*7, 'Q') || ' ' ||'Квартал') as "Year-Quater"
FROM dual
CONNECT BY rownum <=365*7;

