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
    
    insert into  wrk_fct_orders
    select   
    level as order_code,
    round (dbms_random.value (1, 31)) as day,
    round (dbms_random.value (1, 12)) as month,
    round (dbms_random.value (2012, 2017)) as year,
    TRUNC(DBMS_RANDOM.normal*11000+50000) as cust_id, 
    round(dbms_random.value ( 1, (select max(del_id) from bl_3nf.ce_deliveries))) as del_id,
    round(dbms_random.value ( 1, (select max(pay_id)from bl_3nf.ce_payoptions))) as pay_id,
    round(dbms_random.value ( 1, (select max(point_id)from bl_3nf.ce_pickuppoints))) as point_id
          from dual
    connect by level < 600000;

commit;

        dbms_output.put_line('The data in the table WRK_FCT_ORDERS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_fct_orders;
/****************************************************/

    PROCEDURE load_cls_fct_orders
        IS
    cursor c_or
    is
    select 
        (CASE
        WHEN order_code<10 THEN 'OR000000'||order_code
        WHEN order_code>=10 AND order_code<100 THEN 'OR00000'||order_code
        WHEN order_code>=100 AND order_code<1000 THEN 'OR0000'||order_code
        WHEN order_code>=1000 AND order_code<10000 THEN 'OR000'||order_code
        WHEN order_code>=10000 AND order_code<100000 THEN 'OR00'||order_code
        ELSE 'OR0'||order_code END) AS order_code,
        (CASE 
        WHEN month in (4, 6, 9, 11) and day=31
        THEN to_date ( round (dbms_random.value (1, 30))||'-'||month||'-'|| year, 'DD-MM-YYYY')  
        when month=2 and day in (29,30,31)
        THEN to_date ( round (dbms_random.value (1, 28))||'-'||month||'-'|| year, 'DD-MM-YYYY')  
        ELSE to_date ( day||'-'||month||'-'|| year, 'DD-MM-YYYY') END) AS order_date,
        (case
        when TRUNC(DBMS_RANDOM.normal*11000+50000)>(select max(customer_id)from bl_3nf.ce_customers)
          then round(dbms_random.value ( 1, (select max(customer_id)from bl_3nf.ce_customers)))
        when TRUNC(DBMS_RANDOM.normal*11000+50000)<1 
          then round(dbms_random.value ( 1, (select max(customer_id)from bl_3nf.ce_customers)))
        else TRUNC(DBMS_RANDOM.normal*11000+50000)
        end) as cust_id,
        del_id, pay_id, point_id
        from wrk_fct_orders;
   
  type t_fct_orders is table of cls_fct_orders%rowtype index by binary_integer;
  l_fct_orders t_fct_orders;
  
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_fct_orders';
        OPEN c_or;
        loop
        FETCH c_or bulk collect INTO l_fct_orders;
        exit WHEN l_fct_orders.count = 0;
        FOR idx IN l_fct_orders.FIRST .. l_fct_orders.LAST loop
        INSERT
        INTO cls_fct_orders
          (
            order_code,
            order_date,
            cust_id,
            del_id,
            pay_id,
            point_id
          )
          VALUES
          ( l_fct_orders(idx).order_code,
            l_fct_orders(idx).order_date,
            l_fct_orders(idx).cust_id,
            l_fct_orders(idx).del_id,
            l_fct_orders(idx).pay_id,
            l_fct_orders(idx).point_id
          );
          end loop;
        end loop;
        CLOSE c_or;
        COMMIT;
        dbms_output.put_line('The data in the table CLS_FCT_ORDERS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_fct_orders;
/****************************************************/
    PROCEDURE load_ce_fct_orders
        IS
    cursor c_or
    is
    select order_code, order_date, cust_id,
    del_id, pay_id, point_id
    from cls_fct_orders o
    where exists (select 1 from bl_3nf.ce_customers c where c.customer_id=o.cust_id);
    
    rec_or cls_fct_orders%rowtype;
    BEGIN
        OPEN c_or;
          LOOP
            FETCH c_or INTO rec_or;
            IF c_or%found THEN
              INSERT INTO bl_3nf.ce_fct_orders ( order_id, order_code, order_date, cust_id, del_id, pay_id, point_id, insert_dt)
              values (pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_FCT_ORDERS'), rec_or.order_code, rec_or.order_date,
              rec_or.cust_id, rec_or.del_id, rec_or.pay_id, rec_or.point_id, sysdate);
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
    INSERT INTO cls_fct_items 
    SELECT   
      TRUNC (DBMS_RANDOM.VALUE ((SELECT MIN(order_id)FROM bl_3nf.ce_fct_orders), (SELECT MAX(order_id)FROM bl_3nf.ce_fct_orders))) AS  order_id,      
      (CASE
      WHEN trunc(dbms_random.NORMAL*11000+50000)>(SELECT MAX(prod_id)FROM bl_3nf.ce_products)
      THEN round(dbms_random.VALUE ( 1, (SELECT MAX(prod_id)FROM bl_3nf.ce_products)))
      WHEN trunc(dbms_random.NORMAL*11000+50000)<1
      THEN round(dbms_random.VALUE ( 1, (SELECT MAX(prod_id)FROM bl_3nf.ce_products)))
      ELSE trunc(dbms_random.NORMAL*11000+50000)
      END) AS prod_id,
      TRUNC (DBMS_RANDOM.VALUE (10, 5000), 2) PRICE,
      TRUNC (DBMS_RANDOM.VALUE (1, 5)) QUANTITY,
      TRUNC (DBMS_RANDOM.VALUE (0, 30)) DISCOUNT
            FROM DUAL
      CONNECT BY LEVEL < 1200000;
        COMMIT;
    dbms_output.put_line('The data in the table CLS_FCT_ITEMS is loaded successfully!');
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END load_cls_fct_items;
/****************************************************/
    PROCEDURE load_ce_fct_items
        IS
    cursor c_it
    is
    select i.order_id, i.product_id, i.price, i.quantity, i.discount
    from cls_fct_items i
    where exists (select 1 from bl_3nf.ce_products p where p.prod_id=i.product_id);
    
    rec_it cls_fct_items%rowtype;
    
    BEGIN
        OPEN c_it;
          LOOP
            FETCH c_it INTO rec_it;
            IF c_it%found THEN
              INSERT INTO bl_3nf.ce_fct_items ( item_id, order_id, product_id, price, quantity, discount, insert_dt)
              values (pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_FCT_ITEMS'), rec_it.order_id, rec_it.product_id,
              rec_it.price, rec_it.quantity, rec_it.discount, sysdate);
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