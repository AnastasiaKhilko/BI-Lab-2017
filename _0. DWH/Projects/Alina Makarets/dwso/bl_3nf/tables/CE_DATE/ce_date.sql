CREATE TABLE CE_DATE (
        "Date_srcid" DATE ,
        "Day_of_week" NUMBER(2),
        "Day_name_of_week" VARCHAR2(25),
        "Day_of_month" NUMBER(8),
        "Day_of_year" NUMBER(8),
        "Week_of_month" NUMBER(8),
        "Week_of_year" NUMBER(8),
        "Month_number" NUMBER(8),
        "Month_name" VARCHAR2(20),
        "Quarter" NUMBER(2),
        "First_day_of_month" DATE,
        "Last_day_of_month" DATE,
        "Year" NUMBER(8),
        "Year-Quater" VARCHAR2(25),
        CONSTRAINT "PK_Date_srcid" 
           PRIMARY KEY ("Date_srcid")
        );