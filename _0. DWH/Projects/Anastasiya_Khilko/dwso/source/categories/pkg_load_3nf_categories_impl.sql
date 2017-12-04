CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_categories AS
    PROCEDURE load_wrk_products
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_products';
        INSERT INTO wrk_products SELECT
            *
        FROM
            sa_src.ext_products;

        COMMIT;
        --dbms_output.put_line('The data in the table WRK_DELIVERIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_products;
/****************************************************/

    PROCEDURE load_cls_product_categories
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table CLS_PRODUCT_CATEGORIES';
        INSERT INTO cls_product_categories SELECT DISTINCT
            category_code, category_name
        FROM
            wrk_products;

        COMMIT;
        --dbms_output.put_line('The data in the table CLS_DELIVERIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_product_categories;
    
/****************************************************/

PROCEDURE load_ce_product_categories
    IS
BEGIN

    MERGE INTO bl_3nf.ce_product_categories d USING
        ( SELECT
            category_code,
            category_desc
        FROM
            cls_product_categories
        MINUS
        SELECT
            category_code,
            category_desc
        FROM
            bl_3nf.ce_product_categories
        )
    cls ON (
        cls.category_code = d.category_code
    ) WHEN MATCHED THEN
        UPDATE
    SET d.category_desc = cls.category_desc, d.update_dt=sysdate WHEN NOT MATCHED THEN INSERT (category_id, category_code, category_desc, insert_dt, update_dt ) VALUES
    (bl_3nf.seq_categories.nextval, cls.category_code,cls.category_desc, sysdate, sysdate);
    
    COMMIT;
    --dbms_output.put_line('The data in the table CE_DELIVERIES is loaded successfully!');
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END load_ce_product_categories;
/****************************************************/

END pkg_load_3nf_categories;
/