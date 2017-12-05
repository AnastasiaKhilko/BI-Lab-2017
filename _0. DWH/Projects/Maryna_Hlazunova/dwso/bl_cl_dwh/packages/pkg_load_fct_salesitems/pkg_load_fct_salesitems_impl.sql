CREATE OR REPLACE PACKAGE BODY pkg_load_fct_salesitems AS
  /**===============================================*\
  Name...............:   pkg_load_fct_salesitems
  Contents...........:   Package body description
  Author.............:   Maryna Hlazunova
  Date...............:   02-Dec-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_cls2_fct_salesitems IS

        CURSOR c_items IS
            SELECT
                o.order_id,
                o.order_date,
                o.cust_id,
                i.product_id,
                o.pay_id,
                o.del_id,
                o.point_id,
                SUM(i.quantity) AS fct_quantity,
                SUM(i.price * i.quantity) AS fct_item_sum,
                SUM(i.price * i.quantity * i.discount / 100) AS fct_discount_sum,
                SUM(i.price * i.quantity - i.price * i.quantity * i.discount / 100) AS fct_total_sum
            FROM
                bl_3nf.ce_fct_items i
                JOIN bl_3nf.ce_fct_orders o ON o.order_id = i.order_id
            GROUP BY
                o.order_date,
                o.order_id,
                i.product_id,
                o.cust_id,
                o.pay_id,
                o.del_id,
                o.point_id;

        TYPE fetch_array IS
            TABLE OF c_items%rowtype;
        items_array   fetch_array;
        
    rec_it   cls2_fct_salesitems%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls2_fct_salesitems';
        OPEN c_items;
--        LOOP
            FETCH c_items BULK COLLECT INTO items_array;
            FORALL i IN 1..items_array.count
                INSERT INTO cls2_fct_salesitems VALUES items_array ( i );

         --   EXIT WHEN c_items%notfound;
--        END LOOP;
       
        COMMIT;
        CLOSE c_items;
        dbms_output.put_line('The data in the table CLS2_FCT_SALESITEMS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls2_fct_salesitems;
/****************************************************/

    PROCEDURE load_fct_salesitems
        IS
    BEGIN
        FOR item IN (
            SELECT
                cls.order_id,
                d.full_date,
                c.customer_surrid,
                p.product_surrid,
                pd.paydelivery_surrid,
                pp.pickuppoint_surrid,
                fct_quantity,
                fct_item_sum,
                fct_discount_sum,
                fct_total_sum
            FROM
                cls2_fct_salesitems cls
                JOIN bl_dwh.dim_dates d ON cls.order_date = d.full_date
                JOIN bl_dwh.dim_customers_scd c ON cls.customer_id = customer_srcid
                JOIN bl_dwh.dim_products_scd p ON cls.product_id = p.product_srcid
                JOIN bl_dwh.dim_pickuppoints pp ON cls.pickuppoint_id = pp.pickuppoint_srcid
                JOIN bl_dwh.dim_paydeliveries pd ON
                    cls.pay_id = payoption_srcid
                AND
                    cls.del_id = delivery_srcid
        ) LOOP
            INSERT INTO bl_dwh.fct_salesitems (
                dd_order_srcid,
                dim_order_date,
                dim_customer_surrid,
                dim_product_surrid,
                dim_paydelivery_surrid,
                dim_pickuppoint_surrid,
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
        dbms_output.put_line('The data in the table FCT_SALESITEMS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_fct_salesitems;
/****************************************************/

END pkg_load_fct_salesitems;
/