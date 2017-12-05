CREATE OR REPLACE PROCEDURE sp_DATE_DIMENSION(
    v_START_YEAR IN NUMBER,
    v_END_YEAR   IN NUMBER)
AS
  --Declare two variables as DATE datatypes
  v_CURRENT_DATE DATE;
  v_END_DATE     DATE;
BEGIN
  --Assign the start year and end year to it's respective variables
  v_CURRENT_DATE := TO_DATE('0101' || v_START_YEAR, 'MMDDYYYY');
  v_END_DATE     := TO_DATE('1231' || v_END_YEAR, 'MMDDYYYY');
  --Clear/Dump what is currently stored in the table
  DELETE FROM Dim_Time_Day;
  --Check the condition to see if the start year is less than the end year (Input Parameters)
  WHILE v_CURRENT_DATE <= v_END_DATE
  LOOP
    --DATE_DIMENSION Table
    INSERT
    INTO Dim_Time_Day
      (
        FULL_DATE_DT,
        FULL_DATE_DESCR,
        DAY_OF_WEEK,
        DAY_OF_MONTH,
        DAY_OF_YEAR,
        DAY_NAME,
        WEEKEND_INDICATOR,
        LAST_DAY_OF_WEEK_INDICATOR,
        LAST_DAY_OF_MONTH_INDICATOR,
        WEEK_OF_MONTH,
        WEEK_OF_YEAR,
        WEEK_ENDING_DT,
        MONTH_NUMBER,
        MONTH_NAME,
        MONTH_YEAR,
        QUARTER_NUMBER,
        QUARTER_YEAR,
        YEAR_NUMBER
      )
      VALUES
      (
        --DATE_KEY
        to_date(v_CURRENT_DATE, 'dd-MM-yyyy'), --FULL_DATE
        TO_CHAR(v_CURRENT_DATE,'DD')
        ||' '
        ||TO_CHAR(v_CURRENT_DATE,'Month')
        ||TO_CHAR(v_CURRENT_DATE,'YYYY'),                                                         --FULL_DATE _DESCR
        TO_NUMBER(TO_CHAR(v_CURRENT_DATE, 'DAY', 'NLS_DATE_LANGUAGE=''numeric date language''')), --DAY_OF_WEEK
        TO_NUMBER(TO_CHAR(v_CURRENT_DATE,'DD')),                                                  --DAY_OF_MONTH
        TO_NUMBER(TO_CHAR(v_CURRENT_DATE,'DDD')),                                                 --DAY_OF_YEAR
        TO_CHAR(v_CURRENT_DATE,'FMDay'),                                                          --DAY_NAME
        CASE                                                                                      --LWEEKend_INDICATOR
          WHEN TO_CHAR(v_CURRENT_DATE,'FMDay') = 'Saturday'
          OR TO_CHAR(v_CURRENT_DATE,'FMDay')   = 'Sunday'
          THEN 'Weekend'
          ELSE 'Weekday'
        END,
        CASE --LAST_DAY_OF_WEEK_INDICATOR
          WHEN TO_CHAR(v_CURRENT_DATE,'FMDay') = 'Sunday'
          THEN 'Last day of the week'
          ELSE 'Not last day of the week'
        END,
        CASE --LAST_DAY_OF_MONTH_INDICATOR
          WHEN LAST_DAY(TO_DATE(v_CURRENT_DATE, 'DD-MM-YYYY')) = TO_DATE(v_CURRENT_DATE, 'DD-MM-YYYY')
          THEN 'Last day of the month'
          ELSE 'Not last day of the month'
        END,
        TO_NUMBER(TO_CHAR(v_CURRENT_DATE,'W')),  --WEEK_OF_MONTH
        TO_NUMBER(TO_CHAR(v_CURRENT_DATE,'IW')), --WEEK_OF_YEAR
        CASE                                     --WEEK_ENDING_DATE OF CURRENT WEEK ENDING ON SUNDAY
          WHEN TO_CHAR(v_CURRENT_DATE,'FMDay') = 'Sunday'
          THEN v_CURRENT_DATE
          ELSE NEXT_DAY(v_CURRENT_DATE,'SUNDAY')
        END,
        TO_NUMBER(TO_CHAR(v_CURRENT_DATE,'MM')),  --MONTH_NUMBER
        TO_CHAR(v_CURRENT_DATE,'MONTH'),          --MONTH_NAME
        TO_CHAR(v_CURRENT_DATE,'MONTH-YYYY'),     --YEAR_MONTH
        TO_CHAR(v_CURRENT_DATE,'Q'),              --QUARTER_NUMBER
        TO_CHAR(v_CURRENT_DATE,'Q-YYYY'),         --YEAR_QUARTER
        TO_NUMBER(TO_CHAR(v_CURRENT_DATE,'YYYY')) --YEAR_NUMBER
      );
    --Increment and assign the current date value to be re-evaluated
    v_CURRENT_DATE := v_CURRENT_DATE + 1;
  END LOOP;
END;