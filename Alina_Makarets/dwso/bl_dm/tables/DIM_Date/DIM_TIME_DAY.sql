CREATE TABLE DIM_TIME_DAY (
        "Date_id" DATE NOT NULL,
        "Day_of_week" NUMBER(2) NOT NULL,
        "Day_name_of_week" VARCHAR2(25) NOT NULL,
        "Day_of_month" NUMBER(8) NOT NULL,
        "Day_of_year" NUMBER(8) NOT NULL,
        "Week_of_month" NUMBER(8) NOT NULL,
        "Week_of_year" NUMBER(8) NOT NULL,
        "Month_number" NUMBER(8) NOT NULL,
        "Month_name" VARCHAR2(20) NOT NULL,
        "Quarter" NUMBER(2) NOT NULL,
        "First_day_of_month" DATE NOT NULL,
        "Last_day_of_month" DATE NOT NULL,
        "Year" NUMBER(8) NOT NULL,
        "Year-Quater" VARCHAR2(25) NOT NULL,
        CONSTRAINT "PK_DATE_ID"
          PRIMARY KEY ("Date_id")
        );

        
        