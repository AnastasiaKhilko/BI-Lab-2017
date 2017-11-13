CREATE TABLE DateDim as
select sysdate+rownum-365*10 as FullDate, extract(month from sysdate+rownum-365*10) as month, extract(year from sysdate+rownum-365*10) as year, extract(day from sysdate+rownum-365*10)as day,
to_char(sysdate+rownum-365*10-1, 'D') as DayofWeek,
to_char(sysdate+rownum-365*10, 'DAY', 'NLS_DATE_LANGUAGE=ENGLISH') AS D_Eng, to_char(sysdate+rownum-365*10, 'DAY', 'NLS_DATE_LANGUAGE=RUSSIAN') AS D_Rus, 
to_char(sysdate+rownum-365*10, 'DAY', 'NLS_DATE_LANGUAGE=SPANISH') AS D_Esp, to_char(sysdate+rownum-365*10, 'DAY', 'NLS_DATE_LANGUAGE=GERMAN') AS D_Ger,
to_char(sysdate+rownum-365*10, 'MONTH', 'NLS_DATE_LANGUAGE=ENGLISH') AS M_Eng, to_char(sysdate+rownum-365*10, 'MONTH', 'NLS_DATE_LANGUAGE=RUSSIAN') AS M_Rus, 
to_char(sysdate+rownum-365*10, 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') AS M_Esp, to_char(sysdate+rownum-365*10, 'MONTH', 'NLS_DATE_LANGUAGE=GERMAN') AS M_Ger,
to_char(sysdate+rownum-365*10, 'DDD') AS DayofYear, to_char(sysdate+rownum-365*10, 'IW') AS WeekY, to_char(sysdate+rownum-365*10, 'Q') AS Quarter,
to_char(sysdate+rownum-365*10, 'W') AS WeekofMonth
from dual
connect by rownum <= 365*100;
