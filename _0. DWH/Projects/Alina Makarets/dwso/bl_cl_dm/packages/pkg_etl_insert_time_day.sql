CREATE OR REPLACE PACKAGE pkg_etl_insert_time_day
AUTHID CURRENT_USER
AS
    PROCEDURE insert_table_dim_time_day;
END pkg_etl_insert_time_day;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_time_day
AS
----------------------------------------------------
    PROCEDURE insert_table_dim_time_day
    IS 
        BEGIN
            INSERT INTO dim_time_day
                       SELECT   *
                        FROM ce_date;

            COMMIT;
            EXCEPTION
                WHEN OTHERS 
            THEN RAISE;  
    END insert_table_dim_time_day;

END pkg_etl_insert_time_day;