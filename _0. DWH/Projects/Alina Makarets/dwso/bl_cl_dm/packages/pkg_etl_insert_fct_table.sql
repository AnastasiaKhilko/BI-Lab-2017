ALTER SESSION SET nls_date_format = 'DD-MON-YYYY';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;

CREATE OR REPLACE PACKAGE pkg_etl_insert_fct_table
AUTHID CURRENT_USER
AS

    PROCEDURE insert_table_dim_fct_table;

END pkg_etl_insert_fct_table;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_fct_table
AS
-----------------------------------------------
PROCEDURE insert_table_dim_fct_table
IS 
    BEGIN 
    DECLARE 
        CURSOR c_data IS
        SELECT          ce.sales_surr_id,
                        ce.event_dt,
                        dim.product_id,
                        emp.employee_id,
                        cus.customer_id,
                        dshop.shop_id ,
                        ce.payment_method,
                        ce.unit_amount,
                        ce.total_sum,
                        SYSDATE as insert_dt,
                        SYSDATE as update_dt
                FROM ce_sales ce    LEFT JOIN dim_products dim  ON ce.product_surr_id=Dim.Product_surr_Id
                                    LEFT JOIN dim_shops dshop   ON ce.shop_surr_id=dshop.shop_surr_id
                                    LEFT JOIN dim_employees emp ON ce.employee_surr_id=emp.employee_surr_id
                                    LEFT JOIN dim_customers cus ON ce.customer_surr_id=cus.customer_surr_id ;
            TYPE fetch_array IS TABLE OF c_data%ROWTYPE ;
            s_array fetch_array;
            BEGIN
            OPEN c_data;
                LOOP
                    FETCH c_data BULK COLLECT INTO s_array;
                    
                    FORALL i IN 1..s_array.COUNT
                     INSERT INTO fct_sales
                     VALUES s_array(i) ;
                     EXIT WHEN c_data%NOTFOUND;
            END LOOP;
        CLOSE      c_data;   
        COMMIT;
END;
END insert_table_dim_fct_table;
------------------------------------------------
END pkg_etl_insert_fct_table;

