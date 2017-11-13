drop table dim_date;
CREATE TABLE dim_date AS
SELECT --CurrDate AS Day_ID,
--1 AS Day_Time_Span,
TO_char(CurrDate,'YYYYMMDD') AS date_id,
CurrDate AS Day_End_Date,
TO_CHAR(CurrDate,'Day') AS Week_Day_Full,
TO_CHAR(CurrDate,'DY') AS Week_Day_Short,
TO_NUMBER(TRIM(leading '0' FROM TO_CHAR(CurrDate,'D'))) AS Day_Num_of_Week,
TO_NUMBER(TRIM(leading '0' FROM TO_CHAR(CurrDate,'DD'))) AS Day_Num_of_Month,
TO_NUMBER(TRIM(leading '0' FROM TO_CHAR(CurrDate,'DDD'))) AS Day_Num_of_Year,
--UPPER(TO_CHAR(CurrDate,'Mon') || '-' || TO_CHAR(CurrDate,'YYYY')) AS Month_ID,
-- 31 AS Month_Time_Span,
--MAX(TO_NUMBER(TO_CHAR(CurrDate, 'DD'))) OVER (PARTITION BY TO_CHAR(CurrDate,'Mon')) AS Month_Time_Span,
--to_date('31-JAN-2010','DD-MON-YYYY') AS Month_End_Date,
--MAX(CurrDate) OVER (PARTITION BY TO_CHAR(CurrDate,'Mon')) as Month_End_Date,
--TO_CHAR(CurrDate,'Mon') || ' ' || TO_CHAR(CurrDate,'YYYY') AS Month_Short_Desc,
--TRIM(TO_CHAR(CurrDate,'Month')) || ' ' || TO_CHAR(CurrDate,'YYYY') AS Month_Long_Desc,
TO_CHAR (CurrDate,'Mon') AS Month_Short,
TO_CHAR(CurrDate,'Month') AS Month_Long,
TO_NUMBER(TRIM(leading '0'FROM TO_CHAR(CurrDate,'MM'))) AS Month_Num_of_Year,
--'Q' || UPPER(TO_CHAR(CurrDate,'Q') || '-' || TO_CHAR(CurrDate,'YYYY')) AS Quarter_ID,
'Q' || UPPER(TO_CHAR(CurrDate,'Q')) AS Quarter_ID,
-- 31 AS Quarter_Time_Span,
--COUNT(*) OVER (PARTITION BY TO_CHAR(CurrDate,'Q')) AS Quarter_Time_Span,
-- to_date('31-JAN-2010','DD-MON-YYYY') AS Quarter_End_Date,
--MAX(CurrDate) OVER (PARTITION BY TO_CHAR(CurrDate,'Q')) AS Quarter_End_Date,
TO_NUMBER(TO_CHAR(CurrDate,'Q')) AS Quarter_Num_of_Year,
TO_CHAR(CurrDate,'YYYY') AS Year_ID
--31 AS Year_Time_Span,
--COUNT(*) OVER (PARTITION BY TO_CHAR(CurrDate,'YYYY')) AS Year_Time_Span,
-- to_date('31-JAN-2010','DD-MON-YYYY') AS Year_End_Date
--MAX(CurrDate) OVER (PARTITION BY TO_CHAR(CurrDate,'YYYY')) Year_End_Date
FROM
(SELECT level n,
-- Calendar starts at the day after this date.
TO_DATE('31/12/2007','DD/MM/YYYY') + NUMTODSINTERVAL(level,'day') CurrDate
FROM dual
-- Change for the number of days to be added to the table.
CONNECT BY level <= 11000)
ORDER BY CurrDate;
commit;
select * from dim_date;
