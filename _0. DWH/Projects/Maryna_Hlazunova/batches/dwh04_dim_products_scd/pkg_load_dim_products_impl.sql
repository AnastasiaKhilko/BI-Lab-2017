CREATE OR REPLACE PACKAGE BODY pkg_load_dim_products AS
  /**===============================================*\
  Name...............:   pkg_load_dim_products
  Contents...........:   Package body description
  Author.............:   Maryna Hlazunova
  Date...............:   01-Dec-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_cls2_products IS

        CURSOR c_prod IS
            SELECT
                p.prod_id AS product_srcid,
                nvl(p.product_name,'N/D in 3NF') AS product_desc,
                nvl(p.vendor_code,'N/D in 3NF') AS product_vendorcode,
                nvl(c.color_desc,'N/D in 3NF') AS product_color,
                nvl(b.brand_desc,'N/D in 3NF') AS product_brand,
                nvl(t.type_name,'N/D in 3NF') AS product_type,
                nvl(s.subcategory,'N/D in 3NF') AS product_subcategory,
                nvl(ct.category,'N/D in 3NF') AS product_category,
                start_dt,
                end_dt,
                is_active
            FROM
                bl_3nf.ce_products p
                LEFT JOIN bl_3nf.ce_colors c ON p.color_id = c.color_id
                LEFT JOIN bl_3nf.ce_brands b ON p.brand_id = b.brand_id
                LEFT JOIN bl_3nf.ce_types t ON t.type_id = p.type_id
                LEFT JOIN bl_3nf.ce_subcategories s ON s.subcat_id = t.subcat_id
                LEFT JOIN bl_3nf.ce_categories ct ON ct.cat_id = s.cat_id;

        rec_prod   cls2_products%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls2_products';
        OPEN c_prod;
        LOOP
            FETCH c_prod INTO rec_prod;
            IF
                c_prod%found
            THEN
                INSERT INTO cls2_products (
                    product_srcid,
                    product_desc,
                    product_vendorcode,
                    product_color,
                    product_brand,
                    product_type,
                    product_subcategory,
                    product_category,
                    start_dt,
                    end_dt,
                    is_active
                ) VALUES (
                    rec_prod.product_srcid,
                    rec_prod.product_desc,
                    rec_prod.product_vendorcode,
                    rec_prod.product_color,
                    rec_prod.product_brand,
                    rec_prod.product_type,
                    rec_prod.product_subcategory,
                    rec_prod.product_category,
                    rec_prod.start_dt,
                    rec_prod.end_dt,
                    rec_prod.is_active
                );

            END IF;

            EXIT WHEN c_prod%notfound;
        END LOOP;

        CLOSE c_prod;
        COMMIT;
        COMMIT;
        dbms_output.put_line('The data in the table CLS2_PRODUCTS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls2_products;
/****************************************************/

    PROCEDURE load_dim_products_scd
        IS
    BEGIN
        MERGE INTO bl_dwh.dim_products_scd d USING
            ( SELECT
                product_srcid,
                product_desc,
                product_vendorcode,
                product_color,
                product_brand,
                product_type,
                product_subcategory,
                product_category,
                start_dt,
                end_dt,
                is_active
            FROM
                cls2_products
            MINUS
            SELECT
                product_srcid,
                product_desc,
                product_vendorcode,
                product_color,
                product_brand,
                product_type,
                product_subcategory,
                product_category,
                start_dt,
                end_dt,
                is_active
            FROM
                bl_dwh.dim_products_scd
            )
        cls ON (
            d.product_srcid = cls.product_srcid
        ) WHEN MATCHED THEN
            UPDATE
        SET d.product_desc = cls.product_desc,
            d.product_vendorcode = cls.product_vendorcode,
            d.product_color = cls.product_color,
            d.product_brand = cls.product_brand,
            d.product_type = cls.product_type,
            d.product_subcategory = cls.product_subcategory,
            d.product_category = cls.product_category,
            d.start_dt = cls.start_dt,
            d.end_dt = cls.end_dt,
            d.is_active = cls.is_active,
            d.ta_update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( product_surrid,product_srcid,product_desc,product_vendorcode,product_color,product_brand,product_type,product_subcategory
,product_category,start_dt,end_dt,is_active,ta_insert_dt,ta_update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_DWH.SEQ_PRODUCTS'),cls.
product_srcid,cls.product_desc,cls.product_vendorcode,cls.product_color,cls.product_brand,cls.product_type,cls.product_subcategory
,cls.product_category,cls.start_dt,cls.end_dt,cls.is_active,SYSDATE,SYSDATE );

        COMMIT;
        dbms_output.put_line('The data in the table DIM_products_SCD is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_dim_products_scd;
/****************************************************/

END pkg_load_dim_products;
/