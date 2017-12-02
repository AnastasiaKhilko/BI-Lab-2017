ALTER SESSION SET nls_date_format = 'DD-MON-YYYY';
CREATE OR REPLACE PACKAGE pkg_etl_insert_products
AUTHID CURRENT_USER
AS
    PROCEDURE insert_table_colors;
    PROCEDURE merge_table_ce_colors;
    PROCEDURE insert_table_collections;
    PROCEDURE merge_table_ce_collections;
    PROCEDURE insert_table_categories;
    PROCEDURE merge_table_ce_categories;
    PROCEDURE insert_table_subcategoris;
    PROCEDURE merge_table_ce_subcategories;
    PROCEDURE insert_table_products;
    PROCEDURE merge_table_ce_products;

END pkg_etl_insert_products;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_products
AS
----------------------------------------------------
    PROCEDURE insert_table_colors
    IS
        BEGIN
            EXECUTE IMMEDIATE (' TRUNCATE TABLE cls_colors');
            INSERT INTO cls_colors (
                                        color_id,
                                        color_name
                                    )
            SELECT DISTINCT color as color_id,
                   NVL(initcap (color_name),'Òîí ' || color) as color_name
            FROM wrk_products
            WHERE color IS NOT NULL
            AND color NOT IN (SELECT color
                                        FROM wrk_products
                                        GROUP BY color
                                        HAVING COUNT (color) > 1);
        COMMIT ;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE;   

         END  insert_table_colors;
----------------------------------------------------
PROCEDURE merge_table_ce_colors
    IS 
        BEGIN
        MERGE INTO ce_colors t USING
            ( SELECT color_id,
                     color_name 
              FROM cls_colors
              MINUS
              SELECT color_id,
                     color_name
              FROM ce_colors
              ) c
              ON ( c.color_id=t.color_id )
              WHEN matched THEN
              UPDATE SET t.color_name=c.color_name
              WHEN NOT matched THEN
              INSERT 
                    (color_surr_id,
                     color_id,
                     color_name,
                     insert_dt,
                     update_dt)
             VALUES 
                   (ce_colors_seq.nextval,
                    c.color_id,
                    c.color_name,
                    SYSDATE,
                    SYSDATE) ;
            COMMIT ;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE;
    END merge_table_ce_colors;
----------------------------------------------------
   PROCEDURE insert_table_collections
    IS
        BEGIN
            EXECUTE IMMEDIATE (' TRUNCATE TABLE cls_collections');
            INSERT INTO cls_collections (
                                        collection_name
                                    )
            SELECT DISTINCT  collection_name as collection_name
            FROM wrk_products
            WHERE collection_name!='4,82';
        COMMIT;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE; 
        END insert_table_collections;
----------------------------------------------------
PROCEDURE merge_table_ce_collections
    IS 
        BEGIN
        MERGE INTO ce_collections t USING
            ( SELECT collection_name
              FROM cls_collections
              WHERE collection_name IS NOT NULL
              MINUS
              SELECT collection_name
              FROM ce_collections
              ) c
              ON ( c.collection_name=t.collection_name )
              WHEN NOT matched THEN
              INSERT 
                    (collection_surr_id,
                     collection_name,
                     insert_dt,
                     update_dt)
             VALUES 
                   (ce_collections_seq.nextval,
                    c.collection_name,
                    SYSDATE,
                    SYSDATE) ;
            COMMIT ;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE;
    END merge_table_ce_collections;
----------------------------------------------------
   PROCEDURE insert_table_categories
    IS
        BEGIN
            EXECUTE IMMEDIATE (' TRUNCATE TABLE cls_categories');
            INSERT INTO cls_categories (
                                        category_name
                                    )
           SELECT DISTINCT category_name   
            FROM wrk_products;
        COMMIT;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE; 
        END insert_table_categories;
----------------------------------------------------
PROCEDURE merge_table_ce_categories
    IS 
        BEGIN
        MERGE INTO ce_categories t USING
            ( SELECT category_name
              FROM cls_categories
              MINUS
              SELECT category_name
              FROM ce_categories
              ) c
              ON ( c.category_name=t.category_name )
              WHEN NOT matched THEN
              INSERT 
                    (category_surr_id,
                     category_name,
                     insert_dt,
                     update_dt)
             VALUES 
                   (ce_categories_seq.nextval,
                    c.category_name,
                    SYSDATE,
                    SYSDATE) ;
            COMMIT ;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE;
    END merge_table_ce_categories;
----------------------------------------------------
   PROCEDURE insert_table_subcategoris
    IS
        BEGIN
            EXECUTE IMMEDIATE (' TRUNCATE TABLE cls_subcategories');
            INSERT INTO cls_subcategories (
                                        category_name,
                                        subcategory_name                                        
                                    )
           SELECT DISTINCT category_name,
                           subcategory_name
            FROM wrk_products;
        COMMIT;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE; 
        END insert_table_subcategoris;
----------------------------------------------------
PROCEDURE merge_table_ce_subcategories
    IS 
        BEGIN
        MERGE INTO ce_subcategories t USING
            ( SELECT sub.subcategory_name,
                    ce.category_surr_id
              FROM cls_subcategories  sub JOIN ce_categories ce ON sub.category_name=ce.category_name
              MINUS
              SELECT subcategory_name,
                     category_surr_id
              FROM ce_subcategories
              ) c
              ON ( c.subcategory_name=t.subcategory_name )
              WHEN matched THEN
              UPDATE SET t.category_surr_id=c.category_surr_id
              WHEN NOT matched THEN
              INSERT 
                    (subcategory_surr_id,
                     subcategory_name,
                     category_surr_id,
                     insert_dt,
                     update_dt)
             VALUES 
                   (ce_subcategories_seq.nextval,
                    c.subcategory_name,
                    c.category_surr_id,
                    SYSDATE,
                    SYSDATE) ;
            COMMIT ;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE;
    END merge_table_ce_subcategories;
----------------------------------------------------
 PROCEDURE insert_table_products
    IS
        BEGIN
        DECLARE 
            CURSOR pro_cursor IS
            SELECT product_code||'-'||color || '-'|| subcat.subcategory_surr_id AS product_id,
                   product_name,
                   NVL(product_desc,wrk.subcategory_name) as product_desc,
                   to_number ( price, '99999999.99') as price,
                   clr.color_surr_id,
                   col.collection_surr_id,
                   cat.category_surr_id,
                   subcat.subcategory_surr_id,
                   to_date(wrk.start_date,'DD-MM-YYYY') as start_dt
            FROM wrk_products wrk  JOIN ce_colors clr ON wrk.color=clr.color_id
            JOIN ce_categories cat ON wrk.category_name=cat.category_name
            JOIN ce_subcategories subcat ON wrk.subcategory_name=subcat.subcategory_name
            JOIN ce_collections col ON wrk.collection_name=col.collection_name;
            
            BEGIN
            EXECUTE IMMEDIATE (' TRUNCATE TABLE cls_products');
            FOR prod_cursor_val IN pro_cursor LOOP
            INSERT INTO cls_products (
                                        product_id,
                                        product_name,
                                        product_desc,
                                        price,
                                        color_id,
                                        collection_id,
                                        category_id,
                                        subcategory_id,
                                        start_dt,
                                        end_dt,
                                        is_active
                                    )
                                VALUES ( prod_cursor_val.product_id,
                                         prod_cursor_val.product_name,
                                         prod_cursor_val.product_desc,
                                         prod_cursor_val.price,
                                         prod_cursor_val.color_surr_id,
                                         prod_cursor_val.collection_surr_id,
                                         prod_cursor_val.category_surr_id,
                                         prod_cursor_val.subcategory_surr_id,
                                         prod_cursor_val.start_dt,
                                         TO_DATE('31-ÄÅÊ-9999','DD-MON-YYYY'),
                                         'Y'
                                           );
                        END LOOP;          
                    
           
        COMMIT;
        END;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE; 
        END insert_table_products;
----------------------------------------------------
PROCEDURE merge_table_ce_products
    IS 
        BEGIN
        MERGE INTO ce_products t USING
            ( SELECT product_id,
                     product_name,
                     product_desc,
                     price,
                     color_id,
                     collection_id,
                     subcategory_id,
                     start_dt,
                     end_dt,
                     is_active
              FROM cls_products  
              MINUS
              SELECT product_id ,
                     product_name,
                     product_desc,
                     price,
                     color_surr_id,
                     collection_surr_id,
                     subcategory_surr_id,
                     start_dt,
                     end_dt,
                     is_active
              FROM ce_products
              ) c
              ON ( c.product_id=t.product_id 
              )
              WHEN matched THEN
              UPDATE SET 
                     t.product_name=c.product_name,
                     t.product_desc=c.product_desc,
                     t.price=c.price,
                     t.color_surr_id=c.color_id,
                     t.collection_surr_id=c.collection_id,
                     t.subcategory_surr_id=c.subcategory_id,
                     t.end_dt=c.end_dt,
                     t.is_active=c.is_active
              WHEN NOT matched THEN
              INSERT 
                    (product_surr_id,
                     product_id,
                     product_name,
                     product_desc,
                     price,
                     color_surr_id,
                     collection_surr_id,
                     subcategory_surr_id,
                     start_dt,
                     end_dt,
                     is_active
                 )
             VALUES 
                   (ce_products_seq.nextval,
                    c.product_id,
                    c.product_name,
                    c.product_desc,
                    c.price,
                    c.color_id,
                    c.collection_id,
                    c.subcategory_id,
                    c.start_dt,
                    c.end_dt,
                    c.is_active
                    ) ;
            COMMIT ;
        EXCEPTION
        WHEN OTHERS 
            THEN RAISE;
    END merge_table_ce_products;
----------------------------------------------------
END pkg_etl_insert_products;