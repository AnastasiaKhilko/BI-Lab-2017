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
        INSERT INTO fct_sales
                    (   sales_id,
                        event_dt,
                        product_id,
                        employee_id,
                        customer_id,
                        shop_id,
                        payment_method,
                        unit_amount,
                        total_sum,
                        insert_dt,
                        update_dt
                    )
                SELECT  sales_surr_id,
                        event_dt,
                        dim.product_id,
                        emp.employee_id,
                        cus.customer_id,
                        dshop.shop_id as shop_id,
                        payment_method,
                        unit_amount,
                        total_sum,
                        SYSDATE,
                        SYSDATE
                FROM ce_sales ce    LEFT JOIN dim_products dim  ON ce.product_surr_id=Dim.Product_surr_Id
                                    LEFT JOIN dim_shops dshop   ON ce.shop_surr_id=dshop.shop_surr_id
                                    LEFT JOIN dim_employees emp ON ce.employee_surr_id=emp.employee_surr_id
                                    LEFT JOIN dim_customers cus ON ce.customer_surr_id=cus.customer_surr_id ;
        COMMIT;
        EXCEPTION 
        WHEN OTHERS
            THEN RAISE;
END insert_table_dim_fct_table;
------------------------------------------------
END pkg_etl_insert_fct_table;

