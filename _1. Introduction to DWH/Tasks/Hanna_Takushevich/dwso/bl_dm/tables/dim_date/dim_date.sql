CREATE TABLE DIM_DATE
  (
    date_id                  DATE PRIMARY KEY,
    dateDayWeek              NUMBER,
    dateDayMonth             NUMBER,
    dateDayYear              NUMBER,
    dateDayOfWeekNameEN      VARCHAR2(25),
    dateWeekMonth            NUMBER,
    dateWeekYear             NUMBER,
    dateMonth                NUMBER,
    dateMonthNameEN          VARCHAR2(25),
    dateMonthNameShortEN     VARCHAR2(25),
    dateQuarterYear          NUMBER,
    dateQuarterNameEN        VARCHAR2(25),
    dateSemesterYear         NUMBER,
    dateSemesterOfYearNameEN VARCHAR2(25),
    dateYear                 NUMBER,
    dateWeekMonthName        VARCHAR2(25),
    dateWeekYearName         VARCHAR2(25),
    dateMonthYearName        VARCHAR2(25)
  );
INSERT INTO DIM_DATE
SELECT TO_DATE('31/12/2013','DD/MM/YYYY')              + NUMTODSINTERVAL(n,'day')          AS date_id,
  to_number(TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'), 'D'))   AS dateDayWeek,
  to_number(TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'), 'DD'))  AS dateDayMonth,
  to_number(TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DDD'))  AS dateDayYear,
  TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY')           + NUMTODSINTERVAL(n,'day'),'DAY')   AS dateDayOfWeekNameEN,
  to_number(TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'W'))    AS dateWeekMonth,
  to_number(TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'WW'))   AS dateWeekYear,
  to_number(TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM'))   AS dateMonth,
  TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY')           + NUMTODSINTERVAL(n,'day'),'Month') AS dateMonthNameEN,
  TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY')           + NUMTODSINTERVAL(n,'day'),'Mon')   AS dateMonthNameShortEN,
  to_number(TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'), 'Q'))   AS dateQuarterYear,
  CASE
    WHEN TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')<'04'
    THEN 'First quater'
    WHEN TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')<'07'
    THEN 'Second quater'
    WHEN TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')<'10'
    THEN 'Third quater'
    ELSE 'Fourth quater'
  END AS dateQuarterNameEN,
  to_number(
  CASE
    WHEN TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')<'07'
    THEN 1
    ELSE 2
  END) AS dateSemesterYear,
  CASE
    WHEN TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')<'07'
    THEN 'First semester'
    ELSE 'Second semester'
  END                                                                                      AS dateSemesterOfYearNameEn,
  to_number(TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY')) AS dateYear,
  TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY')           + NUMTODSINTERVAL(n,'day'),'W')
  ||'-'
  ||TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')AS dateWeekMonthName,
  TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY')   + NUMTODSINTERVAL(n,'day'),'WW')
  ||'-'
  || TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY') AS dateWeekYearName,
  TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY')    + NUMTODSINTERVAL(n,'day'),'MM')
  ||'-'
  || TO_CHAR(TO_DATE('31/12/2013','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY') AS dateMonthYearName
FROM
  ( SELECT level n FROM dual CONNECT BY level <= 5000
  );
COMMIT;