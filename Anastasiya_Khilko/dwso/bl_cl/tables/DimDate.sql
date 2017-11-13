create table DimDate1 as SELECT
   TO_CHAR(TO_DATE('31/12/2012','DD/MM/YYYY')    + NUMTODSINTERVAL(n,'day'),'YYYY')
  || TO_CHAR(TO_DATE('31/12/2012','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')
  ||   TO_CHAR(TO_DATE('31/12/2012','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DD')  AS Date_Key,
  TO_DATE('31/12/2012','DD/MM/YYYY')    + NUMTODSINTERVAL(n,'day') AS Full_Date
  ,
  TO_CHAR(TO_DATE('31/12/2012','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'D')
  AS Day_Of_week,
  TO_CHAR(TO_DATE('31/12/2012','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DD')
  AS Day_Of_Momth,
  TO_CHAR(TO_DATE('31/12/2012','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DDD')
  AS DAY_OF_YEAR ,
  TO_CHAR(TO_DATE('31/12/2012','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DAY')
  AS day_name,
  TO_CHAR(TO_DATE('31/12/2012','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DY')
  AS day_name_short ,
  TO_CHAR(TO_DATE('31/12/2012','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')
  AS Month_Num,
  TO_CHAR(TO_DATE('31/12/2012','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Month'
  ) AS Month_name,
  'Q'
  || TO_CHAR(TO_DATE('31/12/2012','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Q')
  AS Quarter ,
  TO_CHAR(TO_DATE('31/12/2012','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY')
  AS YEAR
FROM
  (
    SELECT
      level n
    FROM
      dual
      CONNECT BY level <= 10000
  );