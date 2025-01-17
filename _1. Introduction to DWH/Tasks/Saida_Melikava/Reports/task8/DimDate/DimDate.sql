CREATE TABLE DimDate
(  
DATE_KEY VARCHAR2(8) NOT NULL,
FULL_DATE DATE NOT NULL,
FULL_DATE_DESCR VARCHAR2(40) NOT NULL,
DAY_OF_WEEK NUMBER(1,0) NOT NULL,
DAY_OF_MONTH NUMBER(2,0) NOT NULL,
DAY_OF_YEAR NUMBER(3,0) NOT NULL,
DAY_NAME VARCHAR2(10) NOT NULL,
WEEKEND_INDICATOR VARCHAR2(40) NOT NULL,
LAST_DAY_OF_WEEK_INDICATOR VARCHAR2(40) NOT NULL,
LAST_DAY_OF_MONTH_INDICATOR VARCHAR2(40) NOT NULL,
WEEK_OF_MONTH NUMBER(1,0) NOT NULL,
WEEK_OF_YEAR NUMBER(2,0) NOT NULL,
WEEK_ENDING_DATE DATE NOT NULL,
MONTH_NUMBER NUMBER(2,0) NOT NULL,
MONTH_NAME VARCHAR2(32) NOT NULL,
MONTH_YEAR CHAR(32) NOT NULL,
QUARTER_NUMBER NUMBER(1,0) NOT NULL,
QUARTER_YEAR CHAR(32) NOT NULL,
YEAR_NUMBER NUMBER(4,0) NOT NULL,
CONSTRAINT DATE_DIMENSION_PK PRIMARY KEY (DATE_KEY)
);
