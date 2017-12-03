DROP TABLE cl_dim_Date cascade constraints;
CREATE TABLE cl_dim_date (
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
    Year_Month VARCHAR2(200)
	);
	
  GRANT SELECT ON cl_dim_date TO bl_dm;