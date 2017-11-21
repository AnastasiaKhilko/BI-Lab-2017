DROP TABLE Date_Dimension;
CREATE TABLE Date_Dimension (
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
    Year_Month VARCHAR2(200),
    CONSTRAINT Date_id PRIMARY KEY (Date_id));