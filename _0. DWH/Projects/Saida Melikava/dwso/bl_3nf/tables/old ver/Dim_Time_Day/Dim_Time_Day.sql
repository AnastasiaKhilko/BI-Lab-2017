DROP TABLE Dim_Time_Day;
CREATE TABLE Dim_Time_Day
  (
    FULL_DATE_DT                DATE NOT NULL,
    FULL_DATE_DESCR             VARCHAR2(20) NOT NULL,
    DAY_OF_WEEK                 NUMBER(1) NOT NULL,
    DAY_OF_MONTH                NUMBER(2) NOT NULL,
    DAY_OF_YEAR                 NUMBER(3) NOT NULL,
    DAY_NAME                    VARCHAR2(10) NOT NULL,
    WEEKEND_INDICATOR           VARCHAR2(40) NOT NULL,
    LAST_DAY_OF_WEEK_INDICATOR  VARCHAR2(40) NOT NULL,
    LAST_DAY_OF_MONTH_INDICATOR VARCHAR2(40) NOT NULL,
    WEEK_OF_MONTH               NUMBER(1) NOT NULL,
    WEEK_OF_YEAR                NUMBER(2) NOT NULL,
    WEEK_ENDING_DT              DATE NOT NULL,
    MONTH_NUMBER                NUMBER(2) NOT NULL,
    MONTH_NAME                  VARCHAR2(30) NOT NULL,
    MONTH_YEAR                  VARCHAR2(30) NOT NULL,
    QUARTER_NUMBER              NUMBER(3) NOT NULL,
    QUARTER_YEAR                CHAR(30) NOT NULL,
    YEAR_NUMBER                 NUMBER(4) NOT NULL,
    CONSTRAINT DATE_DIMENSION_PK PRIMARY KEY (FULL_DATE_DT)
  );
COMMENT ON TABLE Dim_Time_Day
IS
  'Table Content: All calendar information.   
Refresh Cycle/Window: Data is loaded once and for a long period of time.  
';
  COMMENT ON column Dim_Time_Day.FULL_DATE_DT
IS
  'Dimension surrogate key';
  COMMENT ON column Dim_Time_Day.FULL_DATE_DESCR
IS
  'Date in the format 18 November 2017';
  COMMENT ON column Dim_Time_Day.DAY_OF_WEEK
IS
  '1-7';
  COMMENT ON column Dim_Time_Day.DAY_OF_MONTH
IS
  '1-31';
  COMMENT ON column Dim_Time_Day.DAY_OF_YEAR
IS
  '1-365(366)';
  COMMENT ON column Dim_Time_Day.WEEKEND_INDICATOR
IS
  'Weekend/Weekday';
  COMMENT ON column Dim_Time_Day.LAST_DAY_OF_WEEK_INDICATOR
IS
  'Last day of the week/Not last day of the week';
  COMMENT ON column Dim_Time_Day.LAST_DAY_OF_MONTH_INDICATOR
IS
  'Last day of the month/Not last day of the month';
  COMMENT ON column Dim_Time_Day.WEEK_ENDING_DT
IS
  'Date when week ends (Sunday)';
  COMMENT ON column Dim_Time_Day.MONTH_YEAR
IS
  'Month and year';
  COMMENT ON column Dim_Time_Day.QUARTER_YEAR
IS
  'Quarter and year';
  /*GRANT SELECT ON dim_template TO some_user;*/
 