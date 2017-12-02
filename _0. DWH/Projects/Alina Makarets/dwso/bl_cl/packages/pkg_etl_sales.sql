ALTER SESSION SET nls_date_format = 'DD-MON-YYYY';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;

CREATE OR REPLACE PACKAGE pkg_etl_insert_sales
AUTHID CURRENT_USER
AS
    PROCEDURE insert_table_sales;
    PROCEDURE insert_table_ce_sales;

END pkg_etl_insert_sales;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_sales
AS
------------------------------------------------
PROCEDURE insert_table_sales
IS
    BEGIN
        EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_sales');
           BEGIN
            FOR i IN 1..1000000
                LOOP
                  dbms_random.seed
                  (
                    i * 5
                  )
                  ;
                INSERT INTO cls_sales
                    (   sales_number,
                        event_dt,
                        product_id,
                        employee_id,
                        customer_id,
                        shop_id,
                        payment_method,
                        unit_amount,
                        total_sum
                    )
                SELECT 
                    sal.sales_number,
                    TRUNC(sal.event_dt),
                    sal.product_id,
                    sal.employee_id,
                    sal.customer_id,
                    sal.shop_id,
                    sal.payment_method,
                    sal.unit_amount,
                    ce.price*unit_amount*(1-(cus.discount/100)) as total_sum
                FROM
                            (
                            SELECT
                               trunc( dbms_random.value( 100000000, 999999999 ) ) as sales_number,
                               to_date( trunc (
                                             dbms_random.value ( 
                                            ( SELECT to_char( MIN ( date_dt ), 'J' ) FROM ce_date ),
                                            ( SELECT to_char( MAX ( date_dt ), 'J' ) FROM ce_date )
                                                 )
                                                 ), 'J' ) as event_dt,
                                 round ( dbms_random.value ( 
                                                            ( SELECT MIN ( product_surr_id ) FROM ce_products ) ,
                                                            ( SELECT MAX ( product_surr_id ) FROM ce_products )
                                                            ) 
                                                            )  as product_id,
                                 round ( dbms_random.value ( 
                                                            ( SELECT MIN ( employee_surr_id ) FROM ce_employees ) ,
                                                            ( SELECT MAX ( employee_surr_id ) FROM ce_employees )
                                                            ) 
                                                            )  as employee_id,
                                round ( dbms_random.value ( 
                                                            ( SELECT MIN ( customer_surr_id ) FROM ce_customers ) ,
                                                            ( SELECT MAX ( customer_surr_id ) FROM ce_customers )
                                                            ) 
                                                            )  as customer_id,
                                round ( dbms_random.value ( 
                                                            ( SELECT MIN ( shop_surr_id ) FROM ce_shops ) ,
                                                            ( SELECT MAX ( shop_surr_id ) FROM ce_shops )
                                                            ) 
                                                            )  as shop_id,                              
                                (SELECT CASE 
                                        WHEN (SELECT 
                                                abs(trunc(dbms_random.normal))
                                            FROM dual)=1
                                            THEN 'Наличные деньги'
                                        WHEN (SELECT 
                                                abs(trunc(dbms_random.normal))
                                            FROM dual)=0
                                            THEN  'Кредитная карта'
                                        ELSE 'Наличные деньги'
                                        END 
                                    FROM dual) as payment_method,
                                  round ( dbms_random.value (  1 ,  10  ) )  as unit_amount   
                            FROM dual)sal
                            JOIN ce_products ce ON sal.product_id=ce.product_surr_id
                            JOIN ce_customers cus ON sal.customer_id=cus.customer_surr_id;
                    END LOOP;
           END;

                COMMIT;
                EXCEPTION   
                WHEN OTHERS 
                    THEN RAISE;
END insert_table_sales;
-----------------------------------------------
PROCEDURE insert_table_ce_sales
IS 
    BEGIN 
        INSERT INTO ce_sales
                    (   sales_surr_id,
                        sales_number,
                        event_dt,
                        product_surr_id,
                        employee_surr_id,
                        customer_surr_id,
                        shop_surr_id,
                        payment_method,
                        unit_amount,
                        total_sum
                    )
                SELECT  ce_sales_seq.nextval,
                        sales_number,
                        event_dt,
                        product_id,
                        employee_id,
                        customer_id,
                        shop_id,
                        payment_method,
                        unit_amount,
                        total_sum
                FROM cls_sales ;
        COMMIT;
        EXCEPTION 
        WHEN OTHERS
            THEN RAISE;
END insert_table_ce_sales;
------------------------------------------------
END pkg_etl_insert_sales;

