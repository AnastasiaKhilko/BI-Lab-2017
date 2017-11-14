INSERT INTO dim_date (
    start_date,
    week_day_full_name,
    week_day_short_name,
    day_number_of_week,
    day_number_of_month,
    day_number_of_year,
    month_year,
    month_full_name,
    month_short_name,
    month_number_of_year,
    quarter_year,
    quarter_number_of_year,
    half_year_number,
    half_year,
    year
) SELECT
    start_date,
    TO_CHAR(start_date,'Day'),
    TO_CHAR(start_date,'DY'),
    to_number(TRIM(LEADING '0' FROM TO_CHAR(start_date,'D') ) ),
    to_number(TRIM(LEADING '0' FROM TO_CHAR(start_date,'DD') ) ),
    to_number(TRIM(LEADING '0' FROM TO_CHAR(start_date,'DDD') ) ),
    upper(TO_CHAR(start_date,'YYYY') || '-' || TO_CHAR(start_date,'Mon') ),
    TO_CHAR(start_date,'Month'),
    TO_CHAR(start_date,'Mon'),
    to_number(TRIM(LEADING '0' FROM TO_CHAR(start_date,'MM') ) ),
    upper(TO_CHAR(start_date,'YYYY')) || '-' || 'Q' || TO_CHAR(start_date,'Q'),
    TO_CHAR(start_date,'Q'),
    (CASE
     WHEN to_number(TO_CHAR(start_date,'Q') ) <= 2 
     THEN 1
     ELSE 2 END),
    (CASE WHEN to_number(TO_CHAR(start_date,'Q') ) <= 2 
     THEN TO_CHAR(start_date,'YYYY') || '-' ||  'H' || 1 
     ELSE TO_CHAR(start_date,'YYYY') || '-' || 'H' || 2 END),
     TO_CHAR(start_date,'YYYY')
FROM
    (SELECT level n,
            TO_DATE('31/12/2016','DD/MM/YYYY') + numtodsinterval(level,'DAY') start_date
     FROM dual
     CONNECT BY level <= 10950)
ORDER BY start_date;