CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_fact_table AS

PROCEDURE load_wrk_fct_sales
        IS
BEGIN
    EXECUTE IMMEDIATE 'truncate table wrk_fct_sales';
    
    insert into  wrk_fct_sales
    select   
    level as sale_code,
    round (dbms_random.value (1, 31)) as day,
    round (dbms_random.value (1, 12)) as month,
    round (dbms_random.value (2012, 2017)) as year,
    TRUNC(DBMS_RANDOM.normal*11000+50000) as customer_id, 
    round(dbms_random.value ( 1, (select max(product_id) from bl_3nf.ce_products))) as product_id,
    round(dbms_random.value ( 1, (select max(store_id)from bl_3nf.ce_stores))) as store_id,
    round(dbms_random.value ( 1, (select max(employee_id)from bl_3nf.ce_employees))) as employee_id,
    round(dbms_random.value(1, 15) ) as amount_sold_items,
    round(dbms_random.value(1, 2000),2) as total_cost
          from dual
    connect by level < 600000;

commit;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_fct_sales;
/****************************************************/

    PROCEDURE load_cls_fct_sales
        IS
    cursor c_sale
    is
    select 
        (CASE
        WHEN sale_code<10 THEN 'OR000000'||sale_code
        WHEN sale_code>=10 AND sale_code<100 THEN 'OR00000'||sale_code
        WHEN sale_code>=100 AND sale_code<1000 THEN 'OR0000'||sale_code
        WHEN sale_code>=1000 AND sale_code<10000 THEN 'OR000'||sale_code
        WHEN sale_code>=10000 AND sale_code<100000 THEN 'OR00'||sale_code
        ELSE 'OR0'||sale_code END) AS sale_code,
        (CASE 
        WHEN month in (4, 6, 9, 11) and day=31
        THEN to_date ( round (dbms_random.value (1, 30))||'-'||month||'-'|| year, 'DD-MM-YYYY')  
        when month=2 and day in (29,30,31)
        THEN to_date ( round (dbms_random.value (1, 28))||'-'||month||'-'|| year, 'DD-MM-YYYY')  
        ELSE to_date ( day||'-'||month||'-'|| year, 'DD-MM-YYYY') END) AS sale_date,
        (case
        when TRUNC(DBMS_RANDOM.normal*11000+50000)>(select max(customer_id)from bl_3nf.ce_customers)
          then round(dbms_random.value ( 1, (select max(customer_id)from bl_3nf.ce_customers)))
        when TRUNC(DBMS_RANDOM.normal*11000+50000)<1 
          then round(dbms_random.value ( 1, (select max(customer_id)from bl_3nf.ce_customers)))
        else TRUNC(DBMS_RANDOM.normal*11000+50000)
        end) as customer_id,
        product_id, store_id, employee_id
        from wrk_fct_sales;
   
  type t_fct_sales is table of cls_fct_sales%rowtype index by binary_integer;
  l_fct_sales t_fct_sales;
  
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_fct_sales';
        OPEN c_sale;
        loop
        FETCH c_sale bulk collect INTO l_fct_sales;
        exit WHEN l_fct_sales.count = 0;
        FOR idx IN l_fct_sales.FIRST .. l_fct_sales.LAST loop
        INSERT
        INTO cls_fct_sales
          (
            sale_code,
            sale_date,
            customer_id,
            product_id,
            store_id,
            employee_id
          )
          VALUES
          ( l_fct_sales(idx).sale_code,
            l_fct_sales(idx).sale_date,
            l_fct_sales(idx).customer_id,
            l_fct_sales(idx).product_id,
            l_fct_sales(idx).store_id,
            l_fct_sales(idx).employee_id
          );
          end loop;
        end loop;
        CLOSE c_sale;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_fct_sales;
/****************************************************/
    PROCEDURE load_ce_fct_sales
        IS
    cursor c_sale
    is
    select sale_code, sale_date, customer_id,
    product_id, store_id, employee_id
    from cls_fct_sales o
    where exists (select 1 from bl_3nf.ce_customers c where c.customer_id=o.customer_id);
    
    rec_sale cls_fct_sales%rowtype;
    BEGIN
        OPEN c_sale;
          LOOP
            FETCH c_sale INTO rec_sale;
            IF c_sale%found THEN
              INSERT INTO bl_3nf.ce_fct_sales ( sale_id, sale_code, sale_date, customer_id, product_id, store_id, employee_id, insert_dt)
              values (pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_FCT_ORDERS'), rec_or.order_code, rec_or.order_date,
              rec_sale.customer_id, rec_sale.product_id, rec_sale.store_id, rec_sale.employee_id, sysdate);
            END IF;
            EXIT WHEN c_sale%notfound;
          END LOOP;
          CLOSE c_sale;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_fct_sales;
    
/****************************************************/
END pkg_load_3nf_fact_table;
/