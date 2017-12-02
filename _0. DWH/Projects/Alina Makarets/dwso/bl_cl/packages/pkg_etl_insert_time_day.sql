CREATE OR REPLACE PACKAGE pkg_etl_insert_time_day
AUTHID CURRENT_USER
AS
    PROCEDURE insert_table_data;
    PROCEDURE insert_table_ce_date;

END pkg_etl_insert_time_day;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_time_day
AS
----------------------------------------------------
    PROCEDURE insert_table_data
    IS 
        BEGIN
            EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_customers');
            INSERT INTO cls_date
                       ( date_dt,
                         week_name,
                         week_number_of_month,
                         week_number_of_year,
                         day_number_of_week,
                         day_number_of_month,
                         day_number_of_year,
                         month_year,
                         month_number,
                         month_name,
                         quarter,
                         year_quater,
                         year) 
            SELECT trunc(SYSDATE+rownum-365*7)                                                                            AS date_dt, 
                   to_char(SYSDATE+rownum-365*7,'Day','NLS_DATE_LANGUAGE = RUSSIAN')                                AS week_name,
                   to_number(to_char(SYSDATE+rownum-365*7, 'W'))                                                    AS week_number_of_month,
                   to_number(to_char(SYSDATE+rownum-365*7, 'IW'))                                                   AS week_number_of_year,
                   to_number(to_char(SYSDATE+rownum-365*7-1, 'D'))                                                  AS day_number_of_week,
                   to_number(to_char(extract(day from SYSDATE+rownum-365*7)))                                       AS day_number_of_month,
                   to_number(to_char(SYSDATE+rownum-365*7, 'DDD'))                                                  AS day_number_of_year,
                   to_char(extract(month from SYSDATE+rownum-365*7)||'-'|| extract(year from SYSDATE+rownum-365*7)) AS month_year,
                   to_number(to_char(extract(month from SYSDATE+rownum-365*7)))                                     AS month_number,
                   to_char(SYSDATE+rownum-365*7, 'MONTH', 'NLS_DATE_LANGUAGE=Russian')                              AS month_name,
                   to_number(to_char(SYSDATE+rownum-365*7, 'Q'))                                                    AS quarter,
                   to_char(extract(year from SYSDATE+rownum-365*7) || ' '|| to_char(SYSDATE+rownum-365*7, 'Q') || ' ' ||' вартал') AS year_quater,
                   to_number(to_char(extract(year from SYSDATE+rownum-365*7)))                                      AS year
            FROM dual
            CONNECT BY rownum <=365*7;
            COMMIT;
            EXCEPTION
                WHEN OTHERS 
            THEN RAISE;  
    END insert_table_data;
----------------------------------------------------
PROCEDURE insert_table_ce_date
IS
    BEGIN
        INSERT INTO ce_date
                       ( date_dt,
                         week_name,
                         week_number_of_month,
                         week_number_of_year,
                         day_number_of_week,
                         day_number_of_month,
                         day_number_of_year,
                         month_year,
                         month_number,
                         month_name,
                         quarter,
                         year_quater,
                         year)
         SELECT          date_dt,
                         week_name,
                         week_number_of_month,
                         week_number_of_year,
                         day_number_of_week,
                         day_number_of_month,
                         day_number_of_year,
                         month_year,
                         month_number,
                         month_name,
                         quarter,
                         year_quater,
                         year
        FROM cls_date
        WHERE date_dt NOT IN (SELECT date_dt
                                        FROM cls_date
                                        GROUP BY date_dt
                                        HAVING COUNT (date_dt) > 1);
        
        COMMIT;
        EXCEPTION
        WHEN OTHERS
            THEN RAISE;
END insert_table_ce_date;
----------------------------------------------------
END pkg_etl_insert_time_day;