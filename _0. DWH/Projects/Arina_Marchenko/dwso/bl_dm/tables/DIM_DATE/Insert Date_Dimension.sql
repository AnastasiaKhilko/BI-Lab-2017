INSERT INTO  Date_Dimension
SELECT SYSDATE+rownum-365*1018 as Date_id, 
    to_number(to_char(SYSDATE+rownum-365*1018-7*1, 'D'))as Day_per_week,
    to_number(to_char(extract(day from SYSDATE+rownum-365*1018)))as Day_per_month,
    to_number(to_char(SYSDATE+rownum-365*1018, 'DDD')) AS Day_per_year,
    to_number(to_char(SYSDATE+rownum-365*1018, 'W')) AS Week_per_month,
    to_number(to_char(SYSDATE+rownum-365*1018, 'IW')) AS Week_per_year,
    to_number(to_char(extract(month from SYSDATE+rownum-365*1018))) as Month_number,
    to_char(SYSDATE+rownum-365*1018, 'MONTH', 'NLS_DATE_LANGUAGE=English') AS Month_name,
    to_number(to_char(extract(year from SYSDATE+rownum-365*1018))) as Year,
    to_char(extract(day from SYSDATE+rownum-365*1018) || '-'|| to_char(extract(month from (SYSDATE+rownum-365*1018)))) as Day_Month,
    to_char(extract(year from SYSDATE+rownum-365*1018) || '-'|| to_char(extract(month from (SYSDATE+rownum-365*1018)))) as Year_Month
FROM dual CONNECT BY rownum <=365*1018;
