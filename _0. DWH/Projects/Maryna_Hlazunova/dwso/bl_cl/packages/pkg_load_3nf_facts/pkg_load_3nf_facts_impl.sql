CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_facts AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_facts
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   30-Nov-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_wrk_fct_orders
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_fct_orders';
        INSERT INTO wrk_fct_orders SELECT
            level AS order_code,
            round(dbms_random.value(1,31) ) AS day,
            round(dbms_random.value(1,12) ) AS month,
            round(dbms_random.value(2012,2017) ) AS year,
            trunc(dbms_random.normal * 11000 + 50000) AS cust_id,
            round(dbms_random.value(
                1,
                (
                    SELECT
                        MAX(del_id)
                    FROM
                        bl_3nf.ce_deliveries
                )
            ) ) AS del_id,
            round(dbms_random.value(
                1,
                (
                    SELECT
                        MAX(pay_id)
                    FROM
                        bl_3nf.ce_payoptions
                )
            ) ) AS pay_id,
            round(dbms_random.value(
                1,
                (
                    SELECT
                        MAX(point_id)
                    FROM
                        bl_3nf.ce_pickuppoints
                )
            ) ) AS point_id
        FROM
            dual
        CONNECT BY
            level < 600000;

        COMMIT;
        dbms_output.put_line('The data in the table WRK_FCT_ORDERS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_fct_orders;
/****************************************************/

    PROCEDURE load_cls_fct_orders IS

        CURSOR c_or IS
            SELECT
                (
                    CASE
                        WHEN order_code < 10   THEN 'OR000000'
                         || order_code
                        WHEN
                            order_code >= 10
                        AND
                            order_code < 100
                        THEN 'OR00000'
                         || order_code
                        WHEN
                            order_code >= 100
                        AND
                            order_code < 1000
                        THEN 'OR0000'
                         || order_code
                        WHEN
                            order_code >= 1000
                        AND
                            order_code < 10000
                        THEN 'OR000'
                         || order_code
                        WHEN
                            order_code >= 10000
                        AND
                            order_code < 100000
                        THEN 'OR00'
                         || order_code
                        ELSE 'OR0'
                         || order_code
                    END
                ) AS order_code,
                (
                    CASE
                        WHEN
                            month IN (
                                4,6,9,11
                            )
                        AND
                            day = 31
                        THEN TO_DATE(
                            round(dbms_random.value(1,30) )
                             || '-'
                             || month
                             || '-'
                             || year,
                            'DD-MM-YYYY'
                        )
                        WHEN
                            month = 2
                        AND
                            day IN (
                                29,30,31
                            )
                        THEN TO_DATE(
                            round(dbms_random.value(1,28) )
                             || '-'
                             || month
                             || '-'
                             || year,
                            'DD-MM-YYYY'
                        )
                        ELSE TO_DATE(
                            day
                             || '-'
                             || month
                             || '-'
                             || year,
                            'DD-MM-YYYY'
                        )
                    END
                ) AS order_date,
                (
                    CASE
                        WHEN trunc(dbms_random.normal * 11000 + 50000) > (
                            SELECT
                                MAX(customer_id)
                            FROM
                                bl_3nf.ce_customers
                        ) THEN round(dbms_random.value(
                            1,
                            (
                                SELECT
                                    MAX(customer_id)
                                FROM
                                    bl_3nf.ce_customers
                            )
                        ) )
                        WHEN trunc(dbms_random.normal * 11000 + 50000) < 1                                                 THEN round(dbms_random.value(
                            1,
                            (
                                SELECT
                                    MAX(customer_id)
                                FROM
                                    bl_3nf.ce_customers
                            )
                        ) )
                        ELSE trunc(dbms_random.normal * 11000 + 50000)
                    END
                ) AS cust_id,
                del_id,
                pay_id,
                point_id
            FROM
                wrk_fct_orders;

        TYPE t_fct_orders IS
            TABLE OF cls_fct_orders%rowtype INDEX BY BINARY_INTEGER;
        l_fct_orders   t_fct_orders;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_fct_orders';
        OPEN c_or;
        LOOP
            FETCH c_or BULK COLLECT INTO l_fct_orders;
            EXIT WHEN l_fct_orders.count = 0;
            FOR idx IN l_fct_orders.first..l_fct_orders.last LOOP
                INSERT INTO cls_fct_orders (
                    order_code,
                    order_date,
                    cust_id,
                    del_id,
                    pay_id,
                    point_id
                ) VALUES (
                    l_fct_orders(idx).order_code,
                    l_fct_orders(idx).order_date,
                    l_fct_orders(idx).cust_id,
                    l_fct_orders(idx).del_id,
                    l_fct_orders(idx).pay_id,
                    l_fct_orders(idx).point_id
                );

            END LOOP;

        END LOOP;

        CLOSE c_or;
        COMMIT;
        dbms_output.put_line('The data in the table CLS_FCT_ORDERS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_fct_orders;
/****************************************************/

    PROCEDURE load_ce_fct_orders IS

        CURSOR c_or IS
            SELECT
                order_code,
                order_date,
                cust_id,
                del_id,
                pay_id,
                point_id
            FROM
                cls_fct_orders o
            WHERE
                EXISTS (
                    SELECT
                        1
                    FROM
                        bl_3nf.ce_customers c
                    WHERE
                        c.customer_id = o.cust_id
                );

        rec_or   cls_fct_orders%rowtype;
    BEGIN
        OPEN c_or;
        LOOP
            FETCH c_or INTO rec_or;
            IF
                c_or%found
            THEN
                INSERT INTO bl_3nf.ce_fct_orders (
                    order_id,
                    order_code,
                    order_date,
                    cust_id,
                    del_id,
                    pay_id,
                    point_id,
                    insert_dt
                ) VALUES (
                    pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_FCT_ORDERS'),
                    rec_or.order_code,
                    rec_or.order_date,
                    rec_or.cust_id,
                    rec_or.del_id,
                    rec_or.pay_id,
                    rec_or.point_id,
                    SYSDATE
                );

            END IF;

            EXIT WHEN c_or%notfound;
        END LOOP;

        CLOSE c_or;
        COMMIT;
        dbms_output.put_line('The data in the table CE_FCT_ORDERS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_fct_orders;
    
/****************************************************/

    PROCEDURE load_cls_fct_items
        IS
    BEGIN
        INSERT INTO cls_fct_items SELECT
            trunc(dbms_random.value(
                (
                    SELECT
                        MIN(order_id)
                    FROM
                        bl_3nf.ce_fct_orders
                ),
                (
                    SELECT
                        MAX(order_id)
                    FROM
                        bl_3nf.ce_fct_orders
                )
            ) ) AS order_id,
            (
                CASE
                    WHEN trunc(dbms_random.normal * 11000 + 50000) > (
                        SELECT
                            MAX(prod_id)
                        FROM
                            bl_3nf.ce_products
                    ) THEN round(dbms_random.value(
                        1,
                        (
                            SELECT
                                MAX(prod_id)
                            FROM
                                bl_3nf.ce_products
                        )
                    ) )
                    WHEN trunc(dbms_random.normal * 11000 + 50000) < 1                                            THEN round(dbms_random.value(
                        1,
                        (
                            SELECT
                                MAX(prod_id)
                            FROM
                                bl_3nf.ce_products
                        )
                    ) )
                    ELSE trunc(dbms_random.normal * 11000 + 50000)
                END
            ) AS prod_id,
            trunc(
                dbms_random.value(10,5000),
                2
            ) price,
            trunc(dbms_random.value(1,5) ) quantity,
            trunc(dbms_random.value(0,30) ) discount
        FROM
            dual
        CONNECT BY
            level < 1200000;

        COMMIT;
        dbms_output.put_line('The data in the table CLS_FCT_ITEMS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_fct_items;
/****************************************************/

    PROCEDURE load_ce_fct_items IS

        CURSOR c_it IS
            SELECT
                i.order_id,
                i.product_id,
                i.price,
                i.quantity,
                i.discount
            FROM
                cls_fct_items i
            WHERE
                EXISTS (
                    SELECT
                        1
                    FROM
                        bl_3nf.ce_products p
                    WHERE
                        p.prod_id = i.product_id
                );

        rec_it   cls_fct_items%rowtype;
    BEGIN
        OPEN c_it;
        LOOP
            FETCH c_it INTO rec_it;
            IF
                c_it%found
            THEN
                INSERT INTO bl_3nf.ce_fct_items (
                    item_id,
                    order_id,
                    product_id,
                    price,
                    quantity,
                    discount,
                    insert_dt
                ) VALUES (
                    pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_FCT_ITEMS'),
                    rec_it.order_id,
                    rec_it.product_id,
                    rec_it.price,
                    rec_it.quantity,
                    rec_it.discount,
                    SYSDATE
                );

            END IF;

            EXIT WHEN c_it%notfound;
        END LOOP;

        CLOSE c_it;
        COMMIT;
        dbms_output.put_line('The data in the table CE_FCT_ITEMS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_fct_items;
/****************************************************/

END pkg_load_3nf_facts;
/