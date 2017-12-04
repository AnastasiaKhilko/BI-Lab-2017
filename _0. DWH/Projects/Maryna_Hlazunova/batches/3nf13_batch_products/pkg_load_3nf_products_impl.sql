CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_products AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_products
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   29-Nov-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_wrk_products IS

        CURSOR c_prod IS
            SELECT
                product_code,
                vendor_code,
                product_name,
                product_color,
                brand,
                type
            FROM
                sa_src.ext_products;

        rec_prod   wrk_products%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_products';
        OPEN c_prod;
        LOOP
            FETCH c_prod INTO rec_prod;
            IF
                c_prod%found
            THEN
                INSERT INTO wrk_products (
                    prod_code,
                    vendor_code,
                    product_name,
                    product_color,
                    brand,
                    type
                ) VALUES (
                    rec_prod.prod_code,
                    rec_prod.vendor_code,
                    rec_prod.product_name,
                    rec_prod.product_color,
                    rec_prod.brand,
                    rec_prod.type
                );

            END IF;

            EXIT WHEN c_prod%notfound;
        END LOOP;

        CLOSE c_prod;
        COMMIT;
        dbms_output.put_line('The data in the table WRK_PRODUCTS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_products;
    
/****************************************************/

    PROCEDURE load_cls_colors
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_colors';
        INSERT INTO cls_colors ( color_name ) SELECT DISTINCT
            product_color
        FROM
            wrk_products;

        COMMIT;
        dbms_output.put_line('The data in the table CLS_COLORS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_colors;

/****************************************************/

    PROCEDURE load_ce_colors
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_colors c USING
            ( SELECT
                color_name
            FROM
                cls_colors
            MINUS
            SELECT
                color_desc
            FROM
                bl_3nf.ce_colors
            )
        cls ON (
            cls.color_name = c.color_desc
        ) WHEN NOT MATCHED THEN INSERT ( color_id,color_desc,insert_dt,update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_COLORS'),cls.color_name
,trunc(SYSDATE),trunc(SYSDATE) );

        COMMIT;
        dbms_output.put_line('The data in the table CE_COLORS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_colors;

/****************************************************/

    PROCEDURE load_cls_products IS

        CURSOR c_prod IS
            SELECT
                src.prod_code,
                src.vendor_code,
                src.product_name,
                c.color_id,
                b.brand_id,
                t.type_id,
                nvl2(
                    tgt.prod_code,
                    trunc(SYSDATE),
                    TO_DATE('01/01/1900','DD/MM/YYYY')
                ) start_dt,
                TO_DATE('31/12/9999','DD/MM/YYYY') end_dt,
                'Y' is_active
            FROM
                wrk_products src
                LEFT JOIN bl_3nf.ce_products tgt ON (
                        tgt.start_dt <= trunc(SYSDATE)
                    AND
                        tgt.end_dt > trunc(SYSDATE)
                    AND
                        tgt.prod_code = src.prod_code
                )
                LEFT JOIN bl_3nf.ce_colors c ON c.color_desc = src.product_color
                LEFT JOIN bl_3nf.ce_brands b ON b.nat_code = src.brand
                LEFT JOIN bl_3nf.ce_types t ON t.type_code = src.type
            WHERE
                ( DECODE(
                    src.prod_code,
                    tgt.prod_code,
                    0,
                    1
                ) + DECODE(
                    src.vendor_code,
                    tgt.vendor_code,
                    0,
                    1
                ) + DECODE(
                    src.product_name,
                    tgt.product_name,
                    0,
                    1
                ) + DECODE(
                    c.color_id,
                    tgt.color_id,
                    0,
                    1
                ) + DECODE(
                    b.brand_id,
                    tgt.brand_id,
                    0,
                    1
                ) + DECODE(
                    t.type_id,
                    tgt.type_id,
                    0,
                    1
                ) ) > 0
            UNION ALL
            SELECT
                tgt.prod_code,
                tgt.vendor_code,
                tgt.product_name,
                tgt.color_id,
                tgt.brand_id,
                tgt.type_id,
                tgt.start_dt,
                trunc(SYSDATE) end_dt,
                'N' is_active
            FROM
                wrk_products src
                JOIN bl_3nf.ce_products tgt ON (
                        tgt.start_dt <= trunc(SYSDATE)
                    AND
                        tgt.end_dt > trunc(SYSDATE)
                    AND
                        tgt.prod_code = src.prod_code
                )
                LEFT JOIN bl_3nf.ce_colors c ON c.color_desc = src.product_color
                LEFT JOIN bl_3nf.ce_brands b ON b.nat_code = src.brand
                LEFT JOIN bl_3nf.ce_types t ON t.type_code = src.type
            WHERE
                ( DECODE(
                    src.prod_code,
                    tgt.prod_code,
                    0,
                    1
                ) + DECODE(
                    src.vendor_code,
                    tgt.vendor_code,
                    0,
                    1
                ) + DECODE(
                    src.product_name,
                    tgt.product_name,
                    0,
                    1
                ) + DECODE(
                    c.color_id,
                    tgt.color_id,
                    0,
                    1
                ) + DECODE(
                    b.brand_id,
                    tgt.brand_id,
                    0,
                    1
                ) + DECODE(
                    t.type_id,
                    tgt.type_id,
                    0,
                    1
                ) ) > 0;

        rec_prod   cls_products%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_products';
        OPEN c_prod;
        LOOP
            FETCH c_prod INTO rec_prod;
            IF
                c_prod%found
            THEN
                INSERT INTO cls_products (
                    prod_code,
                    vendor_code,
                    product_name,
                    color_id,
                    brand_id,
                    type_id,
                    start_dt,
                    end_dt,
                    is_active
                ) VALUES (
                    rec_prod.prod_code,
                    rec_prod.vendor_code,
                    rec_prod.product_name,
                    rec_prod.color_id,
                    rec_prod.brand_id,
                    rec_prod.type_id,
                    rec_prod.start_dt,
                    rec_prod.end_dt,
                    rec_prod.is_active
                );

            END IF;

            EXIT WHEN c_prod%notfound;
        END LOOP;

        COMMIT;
        CLOSE c_prod;
        dbms_output.put_line('The data in the table CLS_PRODUCTS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_products;

/****************************************************/

    PROCEDURE load_ce_products
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_products tgt USING
            ( SELECT
                prod_code,
                vendor_code,
                product_name,
                color_id,
                brand_id,
                type_id,
                start_dt,
                end_dt,
                is_active
            FROM
                cls_products
            )
        src ON (
                src.prod_code = tgt.prod_code
            AND
                src.start_dt = tgt.start_dt
        ) WHEN MATCHED THEN
            UPDATE
        SET tgt.end_dt = src.end_dt,
            tgt.is_active = src.is_active
        WHEN NOT MATCHED THEN INSERT ( prod_id,prod_code,vendor_code,product_name,color_id,brand_id,type_id,start_dt,end_dt,is_active ) VALUES ( pkg_utl_seq
.seq_getvalue('BL_3NF.SEQ_PRODUCTS'),src.prod_code,src.vendor_code,src.product_name,src.color_id,src.brand_id,src.type_id,src.start_dt
,src.end_dt,src.is_active );

        COMMIT;
        dbms_output.put_line('The data in the table CE_PRODUCTS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_products;
/****************************************************/

END pkg_load_3nf_products;
/