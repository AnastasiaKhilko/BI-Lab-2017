CREATE TABLE dim_date
    AS
        WITH base_calendar AS (
            SELECT
                n AS date_id,
                start_date AS full_date,
                TO_CHAR(start_date,'Day') AS week_day_full_name,
                TO_CHAR(start_date,'DY') AS week_day_short_name,
                to_number(TRIM(LEADING '0' FROM TO_CHAR(start_date,'D') ) ) AS day_number_of_week,
                to_number(TRIM(LEADING '0' FROM TO_CHAR(start_date,'DD') ) ) AS day_number_of_month,
                to_number(TRIM(LEADING '0' FROM TO_CHAR(start_date,'DDD') ) ) AS day_number_of_year,
                upper(TO_CHAR(start_date,'Mon')
                 || '-'
                 || TO_CHAR(start_date,'YYYY') ) AS month_year,
                TO_CHAR(start_date,'Month') AS month_full_name,
                TO_CHAR(start_date,'Mon') AS month_short_name,
                to_number(TRIM(LEADING '0' FROM TO_CHAR(start_date,'MM') ) ) AS month_number_of_year,
                'Q'
                 || upper(TO_CHAR(start_date,'Q')
                 || '-'
                 || TO_CHAR(start_date,'YYYY') ) AS quarter_year,
                to_number(TO_CHAR(start_date,'Q') ) AS quarter_number_of_year,
                    CASE
                        WHEN to_number(TO_CHAR(start_date,'Q') ) <= 2 THEN 1
                        ELSE 2
                    END
                AS half_year_number,
                    CASE
                        WHEN to_number(TO_CHAR(start_date,'Q') ) <= 2 THEN 'H'
                         || 1
                         || '-'
                         || TO_CHAR(start_date,'YYYY')
                        ELSE 'H'
                         || 2
                         || '-'
                         || TO_CHAR(start_date,'YYYY')
                    END
                AS half_year,
                TO_CHAR(start_date,'YYYY') AS year
            FROM
                (
                    SELECT
                        level n,
      -- Calendar starts at the day after 31/12/2016.
                        TO_DATE('31/12/2016','DD/MM/YYYY') + numtodsinterval(level,'DAY') start_date
                    FROM
                        dual
      -- The number of days to be added to the table.
                    CONNECT BY
                        level <= 10950
                )
        ) SELECT
            date_id,
            full_date,
            week_day_full_name,
            week_day_short_name,
            day_number_of_week,
            day_number_of_month,
            day_number_of_year,
            MAX(
                date_id
            ) OVER(PARTITION BY
                month_year
            ) AS month_end_date,
            month_full_name,
            month_short_name,
            month_number_of_year,
            month_year,
            quarter_year,
            quarter_number_of_year,
            half_year_number,
            half_year,
            year,
            MAX(
                date_id
            ) OVER(PARTITION BY
                year
            ) AS year_end_date
        FROM
            base_calendar
        ORDER BY date_id;

ALTER TABLE dim_date ADD CONSTRAINT date_id_pk PRIMARY KEY ( date_id );