CREATE OR REPLACE PACKAGE BODY pkg_load_fact_sales AS

PROCEDURE load_wrk_fct_sales
        IS
    BEGIN
    EXECUTE IMMEDIATE 'truncate table wrk_fct_sales';
    INSERT INTO wrk_fct_sales SELECT
    level AS sale_code,
            round(dbms_random.value(1,31) ) AS day,
            round(dbms_random.value(1,12) ) AS month,
            round(dbms_random.value(2012,2017) ) AS year,
            round(dbms_random.value(1,( SELECT MAX(product_id) FROM bl_3nf.ce_products) ) ) AS product_id,
            trunc(dbms_random.normal * 11000 + 50000) AS customer_id,
            round(dbms_random.value(1,( SELECT MAX(store_id) FROM bl_3nf.ce_stores) ) ) AS store_id,
            round(dbms_random.value(1,(SELECT MAX(emp_id) FROM bl_3nf.ce_employees) ) ) AS employee_id,
            round(dbms_random.value(1,50)) as quantity
            
    FROM dual
    connect by
      level < 500000;
      
    commit;
    exception
      when others then
      raise;
end load_wrk_fct_sales;

/*******************************************************************/

PROCEDURE load_cls_fct_sales
IS
    CURSOR c_or IS
            SELECT
                (
                    CASE
                        WHEN SALE_code < 10   THEN 'SALE000000'|| SALE_code
                        WHEN SALE_code >= 10 AND SALE_code < 100 THEN 'SALE00000' || SALE_code
                        WHEN SALE_code >= 100 AND SALE_code < 1000 THEN 'SALE0000' || SALE_code
                        WHEN SALE_code >= 1000 AND SALE_code < 10000 THEN 'SALE000' || SALE_code
                        WHEN SALE_code >= 10000 AND SALE_code < 100000 THEN 'SALE00' || SALE_code ELSE 'SALE0'|| SALE_code
                    END
                ) AS SALE_code,
                (CASE
                    WHEN month IN (4,6,9,11)AND day = 31 THEN TO_DATE(round(dbms_random.value(1,30) )|| '-'|| month|| '-'|| year,'DD-MM-YYYY')
                    WHEN month = 2 AND day IN (29,30,31) THEN TO_DATE(round(dbms_random.value(1,28) )|| '-'|| month|| '-'|| year, 'DD-MM-YYYY')
                        ELSE TO_DATE(day|| '-'|| month || '-'|| year, 'DD-MM-YYYY' )
                    END
                ) AS sale_date,
                wrk.product_id,
                (
                    CASE
                        WHEN trunc(dbms_random.normal * 11000 + 50000) > (SELECT MAX(customer_id) FROM bl_3nf.ce_customers) 
                            THEN round(dbms_random.value( 1,(SELECT MAX(customer_id) FROM bl_3nf.ce_customers) ) )
                        WHEN trunc(dbms_random.normal * 11000 + 50000) < 1
                            THEN round(dbms_random.value( 1, (SELECT MAX(customer_id)FROM bl_3nf.ce_customers)) )
                        ELSE trunc(dbms_random.normal * 11000 + 50000)
                    END
                ) AS customer_id,
                store_id,
                employee_id,
                quantity,
                pr.price as price,
                nvl(pr.discount, 0) as discount
            FROM
                wrk_fct_sales wrk
                join bl_3nf.ce_products pr on wrk.product_id = pr.product_id;

        TYPE t_fct_orders IS
            TABLE OF cls_fct_sales%rowtype INDEX BY BINARY_INTEGER;
        l_fct_orders   t_fct_orders;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_fct_sales';
        OPEN c_or;
        LOOP
            FETCH c_or BULK COLLECT INTO l_fct_orders;
            EXIT WHEN l_fct_orders.count = 0;
            FOR idx IN l_fct_orders.first..l_fct_orders.last LOOP
                INSERT INTO cls_fct_sales (
                    sale_code,
                    sale_date,
                    product_id,
                    customer_id,
                    store_id,
                    employee_id,
                    quantity,
                    price,
                    discount
                ) VALUES (
                    l_fct_orders(idx).sale_code,
                    l_fct_orders(idx).sale_date,
                    l_fct_orders(idx).product_id,
                    l_fct_orders(idx).customer_id,
                    l_fct_orders(idx).store_id,
                    l_fct_orders(idx).employee_id,
                    l_fct_orders(idx).quantity,
                    l_fct_orders(idx).price,
                    l_fct_orders(idx).discount
                );

            END LOOP;

        END LOOP;

        CLOSE c_or;
        COMMIT;
        --dbms_output.put_line('The data in the table CLS_FCT_ORDERS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_fct_sales;

/***********************************************************/
  /*PROCEDURE load_ce_fct_sales IS

        CURSOR c_or IS
            SELECT
                sale_code,
                sale_date,
                product_id
                customer_id,
                store_id,
                employee_id,
                quantity,
                price,
                discount
            FROM
                cls_fct_sales o
            WHERE
                EXISTS (
                    SELECT
                        1
                    FROM
                        bl_3nf.ce_customers c
                    WHERE
                        c.customer_id = o.customer_id
                );

        rec_or cls_fct_sales%rowtype;
    BEGIN
        OPEN c_or;
        LOOP
            FETCH c_or INTO rec_or;
            IF
                c_or%found
            THEN
                INSERT INTO bl_3nf.ce_fct_sales (
                    sale_id,
                    sale_code,
                    sale_date,
                    product_id,
                    customer_id,
                    store_id,
                    employee_id,
                    quantity,
                    price,
                    discount,
                    insert_dt
                ) VALUES (
                    bl_3nf.seq_fct_sales.nextval,
                    rec_or.sale_code,
                    rec_or.sale_date,
                    rec_or.product_id,
                    rec_or.customer_id,
                    rec_or.store_id,
                    rec_or.employee_id,
                    rec_or.quantity,
                    rec_or.price,
                    rec_or.discount,
                    SYSDATE
                );

            END IF;

            EXIT WHEN c_or%notfound;
        END LOOP;

        CLOSE c_or;
        COMMIT;
        --dbms_output.put_line('The data in the table CE_FCT_ORDERS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_fct_sales;
    
/************************************************************/

END pkg_load_fact_sales;
/