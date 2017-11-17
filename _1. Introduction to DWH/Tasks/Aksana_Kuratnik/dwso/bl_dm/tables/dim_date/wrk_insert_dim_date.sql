INSERT INTO DIM_DATE
SELECT TO_DATE('31/12/2006','DD/MM/YYYY')              + NUMTODSINTERVAL(n,'day')          AS date_id,
  to_number(TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'), 'DD'))  AS Day_of_Month,
  to_number(TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DDD'))  AS Day_of_Year,
  TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY')           + NUMTODSINTERVAL(n,'day'),'DAY')   AS Day_Of_Week_Name,
  to_number(TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'W'))    AS Week_of_Month,
  to_number(TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'WW'))   AS Week_of_Year,
  to_number(TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM'))   AS Month_of_Year,
  TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY')           + NUMTODSINTERVAL(n,'day'),'Month') AS Month_Name,
  TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY')           + NUMTODSINTERVAL(n,'day'),'Mon')   AS Month_Name_Short,
  to_number(TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'), 'Q'))   AS Quarter_of_Year,
  CASE
    WHEN TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')<'04'
    THEN 'First quater'
    WHEN TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')<'07'
    THEN 'Second quater'
    WHEN TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')<'10'
    THEN 'Third quater'
    ELSE 'Fourth quater'
  END AS Quarter_Name,
  to_number(
  CASE
    WHEN TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')<'07'
    THEN 1
    ELSE 2
  END) AS Semester_of_Year,
  CASE
    WHEN TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')<'07'
    THEN 'First semester'
    ELSE 'Second semester'
  END                                                                                      AS Semester_Of_Year_Name,
  to_number(TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY')) AS Year,
  TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY')    + NUMTODSINTERVAL(n,'day'),'MM')
  ||'-'
  || TO_CHAR(TO_DATE('31/12/2006','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY') AS Month_Year
FROM
  ( SELECT level n FROM dual CONNECT BY level <= 7305
  );
COMMIT;
