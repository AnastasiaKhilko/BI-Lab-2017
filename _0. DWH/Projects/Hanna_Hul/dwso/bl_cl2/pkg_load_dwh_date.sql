CREATE OR REPLACE PACKAGE pkg_load_date
AS
  PROCEDURE generate_date;
  PROCEDURE load_date;
END pkg_load_date;
/
CREATE OR REPLACE PACKAGE BODY pkg_load_date
AS
PROCEDURE generate_date
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_date';
  INSERT INTO cls_date
  SELECT CurrDate                  AS Date_ID,
    TO_CHAR(CurrDate,'YYYYMMDD')   AS date_line,
    TO_CHAR(CurrDate,'DD.MM.YYYY') AS date_format,
    TO_CHAR(CurrDate,'Day')        AS Week_Day_Full,
    TO_CHAR(CurrDate,'DY')         AS Week_Day_Short,
    TO_NUMBER(TRIM(leading '0'
  FROM TO_CHAR(CurrDate,'D'))) AS Day_Num_of_Week,
    TO_NUMBER(TRIM(leading '0'
  FROM TO_CHAR(CurrDate,'DD'))) AS Day_Num_of_Month,
    TO_NUMBER(TRIM(leading '0'
  FROM TO_CHAR(CurrDate,'DDD'))) AS Day_Num_of_Year,
    UPPER(TO_CHAR(CurrDate,'Mon')
    || '-'
    || TO_CHAR(CurrDate,'YYYY')) AS Month_ID,
    TO_CHAR (CurrDate,'Mon')     AS Month_Short,
    TO_CHAR(CurrDate,'Month')    AS Month_Long,
    TO_NUMBER(TRIM(leading '0'
  FROM TO_CHAR(CurrDate,'MM'))) AS Month_Num_of_Year,
    'Q'
    || UPPER(TO_CHAR(CurrDate,'Q')
    || '-'
    || TO_CHAR(CurrDate,'YYYY')) AS Quarter_ID,
    'Q'
    || UPPER(TO_CHAR(CurrDate,'Q'))  AS Quarter,
    TO_NUMBER(TO_CHAR(CurrDate,'Q')) AS Quarter_Num_of_Year,
    TO_CHAR(CurrDate,'YYYY')         AS Year_ID
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
      CONNECT BY level <= 11000
    )
  ORDER BY CurrDate;
  COMMIT;
END generate_date;
PROCEDURE load_date
IS
BEGIN
  INSERT INTO bl_dwh.dim_date
  SELECT * FROM cls_date;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
END load_date;
END pkg_load_date;
/
