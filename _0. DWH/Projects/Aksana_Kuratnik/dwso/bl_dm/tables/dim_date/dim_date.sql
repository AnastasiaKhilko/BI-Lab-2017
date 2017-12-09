DROP TABLE DIM_DATE;
CREATE TABLE DIM_DATE
  (
    date_id               DATE PRIMARY KEY,
    Day_of_Month          NUMBER,
    Day_of_Year           NUMBER,
    Day_Of_Week_Name      VARCHAR2(25),
    Week_of_Month         NUMBER,
    Week_of_Year          NUMBER,
    Month_of_Year         NUMBER,
    Month_Name            VARCHAR2(25),
    Month_Name_Short      VARCHAR2(25),
    Quarter_of_Year       NUMBER,
    Quarter_Name          VARCHAR2(25),
    Semester_of_Year      NUMBER,
    Semester_Of_Year_Name VARCHAR2(25),
    YEAR                  NUMBER,
    Month_Year            VARCHAR2(25)
  );