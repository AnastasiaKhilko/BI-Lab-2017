/**===============================================*\
Name...............:   Table dim_dates DM layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   30-Nov-2017
\*=============================================== */
DROP TABLE dim_dates;
--**********************************************

--drop table datesdim;

CREATE TABLE dim_dates (
    full_date       DATE PRIMARY KEY,
    day_week        NUMBER(1),
    day_week_name   VARCHAR2(50),
    day_month       NUMBER(2),
    day_year        NUMBER(3),
    month_num       NUMBER(2),
    month_name      VARCHAR2(50),
    quarter         NUMBER(1),
    half_year       NUMBER(1),
    year            NUMBER(4)
);
--**********************************************
-- SELECT  *  FROM    dim_dates;