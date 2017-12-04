CREATE OR REPLACE PACKAGE pkg_etl_insert_products
AUTHID CURRENT_USER
AS
    PROCEDURE insert_table_products;
    PROCEDURE merge_table_dim_products;    
END pkg_etl_insert_products;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_products
AS
----------------------------------------------------
    PROCEDURE insert_table_products
    IS 
    BEGIN
    DECLARE
    CURSOR c_data
    IS 
                    SELECT DISTINCT product_surr_id as product_id,
                                product_name,
                                product_desc,
                                price,
                                col.color_surr_id,
                                col.color_name,
                                coll.collection_surr_id,
                                coll.collection_name,
                                cat.category_surr_id,
                                cat.category_name,
                                subcat.subcategory_surr_id,
                                subcat.subcategory_name,
                                start_dt,
                                end_dt,
                                is_active
                        FROM ce_products prod LEFT JOIN ce_colors col ON prod.color_surr_id=col.color_surr_id
                        LEFT JOIN ce_collections coll ON prod.collection_surr_id=coll.collection_surr_id
                        LEFT JOIN ce_subcategories subcat ON prod.subcategory_surr_id=subcat.subcategory_surr_id
                        LEFT JOIN ce_categories cat ON subcat.category_surr_id=cat.category_surr_id;
       type t__data
                IS
                  TABLE OF c_data%rowtype;
                  t_data t__data; 
        BEGIN
            EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_dim_products');
            OPEN c_data;
            LOOP
                    FETCH c_data bulk collect INTO t_data;
                    EXIT WHEN t_data.count = 0;
                    FOR i IN t_data.first .. t_data.last
                    LOOP
                         INSERT INTO cls_dim_products
                         VALUES
                         (
                            t_data(i).product_id,
                            t_data(i).product_name,
                            t_data(i).product_desc,
                            t_data(i).price,
                            t_data(i).color_surr_id,
                            t_data(i).color_name,
                            t_data(i).collection_surr_id,
                            t_data(i).collection_name,
                            t_data(i).category_surr_id,
                            t_data(i).category_name,
                            t_data(i).subcategory_surr_id,
                            t_data(i).subcategory_name,
                            t_data(i).start_dt,
                            t_data(i).end_dt,
                            t_data(i).is_active
                            );                         
                      END LOOP;
                END LOOP;
                CLOSE c_data;                   
            END;
END insert_table_products;
----------------------------------------------------
PROCEDURE merge_table_dim_products
    IS 
        BEGIN
        MERGE INTO dim_products t USING
            ( SELECT product_id,
                     product_name,
                     product_desc,
                     price,
                     color_id,
                     color_name,
                     collection_id,
                     collection_name,
                     category_id,
                     category_name,
                     subcategory_id,
                     subcategory_name,
                     start_dt,
                     end_dt,
                     is_active
              FROM cls_dim_products
              MINUS
              SELECT product_id,
                     product_name,
                     product_desc,
                     price,
                     color_id,
                     color_name,
                     collection_id,
                     collection_name,
                     category_id,
                     category_name,
                     subcategory_id,
                     subcategory_name,
                     start_dt,
                     end_dt,
                     is_active
              FROM dim_products  
              ) c
              ON ( c.product_id=t.product_id )
              WHEN matched THEN
              UPDATE SET 
                         t.product_name=c.product_name,
                         t.product_desc=c.product_desc,
                         t.price=c.price,
                         t.color_id=c.color_id,
                         t.color_name=c.color_name,
                         t.collection_id=c.collection_id,
                         t.collection_name=c.collection_name,
                         t.category_id=c.category_id,
                         t.category_name=c.category_name,
                         t.subcategory_id=c.subcategory_id,
                         t.subcategory_name=c.subcategory_name,
                         t.start_dt=c.start_dt,
                         t.end_dt=c.end_dt,
                         t.is_active=c.is_active                         
              WHEN NOT matched THEN
              INSERT 
                    (  product_id, 
                       product_surr_id,
                       product_name,
                       product_desc,
                       price,
                       color_id,
                       color_name,
                       collection_id,
                       collection_name,
                       category_id,
                       category_name,
                       subcategory_id,
                       subcategory_name,
                       start_dt,
                       end_dt,
                       is_active)
             VALUES 
                   (dim_products_seq.nextval,
                    c.product_id,
                    c.product_name,
                    c.product_desc,
                    c.price,
                    c.color_id,
                    c.color_name,
                    c.collection_id,
                    c.collection_name,
                    c.category_id,
                    c.category_name,
                    c.subcategory_id,
                    c.subcategory_name,
                    c.start_dt,
                    c.end_dt,
                    c.is_active) ;
            COMMIT ;
        

    END merge_table_dim_products;
----------------------------------------------------
END pkg_etl_insert_products;