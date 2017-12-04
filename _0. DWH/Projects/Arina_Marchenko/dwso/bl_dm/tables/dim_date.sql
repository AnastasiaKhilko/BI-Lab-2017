DROP TABLE dim_Date cascade constraints;
CREATE TABLE dim_date (
    Event_DT DATE NOT NULL,
    Day_per_week NUMBER(8),
    Day_per_month NUMBER(8),
    Day_per_year NUMBER(8),
    Week_per_month NUMBER(8),
    Week_per_year NUMBER(8),
    Month_number NUMBER(8),
    Month_name VARCHAR2(200),
    Year NUMBER(8),
    Day_Month VARCHAR2(200),
    Year_Month VARCHAR2(200));
   ALTER TABLE dim_date ADD CONSTRAINT event_dt PRIMARY KEY (event_dt);
	
  GRANT SELECT, INSERT, DELETE, UPDATE ON dim_date TO bl_cl_dm;
  
  GRANT SELECT, INSERT, DELETE, UPDATE ON dim_date TO bl_cl_dm;
