CREATE OR REPLACE PACKAGE BODY pkg_load_fct_sales AS
    PROCEDURE load_cls_fct_sales IS

        CURSOR c_sales IS
            SELECT
                o.product_id,
                o.sale_date,
                i.customer_id,
                o.store_id,
                o.employee_id,
                SUM(i.quantity) AS fct_quantity,
                SUM(i.price * i.quantity) AS fct_item_sum,
                SUM(i.price * i.quantity * i.discount / 100) AS fct_discount_sum,
                SUM(i.price * i.quantity - i.price * i.quantity * i.discount / 100) AS fct_total_sum
            FROM
                bl_3nf.ce_fct_sales i
                JOIN bl_3nf.ce_fct_sales o ON o.sale_id = i.sale_id
            GROUP BY
                o.sale_date,
                o.sale_id,
                i.product_id,
                o.customer_id,
                o.store_id,
                o.employee_id;
        TYPE fetch_array IS
            TABLE OF c_sales%rowtype;
        sales_array   fetch_array;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_fct_sales';
        OPEN c_sales;
        LOOP
            FETCH c_sales BULK COLLECT INTO sales_array;
            FORALL i IN 1..sales_array.count
                INSERT INTO cls_fct_sales VALUES sales_array ( i );

            EXIT WHEN c_sales%notfound;
        END LOOP;

        CLOSE c_sales;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_fct_sales;
/****************************************************/

    PROCEDURE load_fct_salesitems
        IS
    BEGIN
        FOR sale IN (
            SELECT
                cls.sale_id,
                d.full_date,
                p.product_id,
                c.customer_id,
                pd.store_id,
                pp.employee_id,
                fct_quantity,
                fct_item_sum,
                fct_discount_sum,
                fct_total_sum
            FROM
                cls_fct_sales cls
                JOIN bl_dm.dim_dates d ON cls.sale_date = d.full_date
                JOIN bl_dm.dim_customers_scd c ON cls.customer_id = customer_id
                JOIN bl_dm.dim_products_scd p ON cls.product_id = p.product_id
                JOIN bl_dm.dim_stores pp ON cls.store_id = pp.store_id
                JOIN bl_dm.dim_employees pd ON
                    cls.employee_id = employee_id
        ) LOOP
            INSERT INTO bl_dm.fct_sales (
                sale_id,
                sale_date,
                product_id,
                customer_id,
                store_id,
                employee_id,
                fct_quantity,
                fct_item_sum,
                fct_discount_sum,
                fct_total_sum,
                insert_dt
            ) VALUES (
                item.order_id,
                item.full_date,
                item.customer_surrid,
                item.product_surrid,
                item.paydelivery_surrid,
                item.pickuppoint_surrid,
                item.fct_quantity,
                item.fct_item_sum,
                item.fct_discount_sum,
                item.fct_total_sum,
                SYSDATE
            );

        END LOOP;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_fct_salesitems;
/****************************************************/

END pkg_load_fct_sales;
/