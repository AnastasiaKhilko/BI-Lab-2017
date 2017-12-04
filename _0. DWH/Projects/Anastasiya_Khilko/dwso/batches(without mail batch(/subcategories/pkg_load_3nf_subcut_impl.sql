CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_subcategories AS

    PROCEDURE load_cls_product_subcategories
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table CLS_PRODUCT_SUBCATEGORIES';
        INSERT INTO cls_product_subcategories SELECT DISTINCT
            wrk.subcategory_code, wrk.subcategory_name, c2.category_id
        FROM bl_cl.wrk_products wrk
        inner join BL_3NF.CE_PRODUCT_CATEGORIES c2
            on wrk.category_code = c2.category_code;
        COMMIT;
        --dbms_output.put_line('The data in the table CLS_DELIVERIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_product_subcategories;
    
/****************************************************/

PROCEDURE load_ce_product_subcategories
    IS
BEGIN

    MERGE INTO bl_3nf.ce_product_subcategories d USING
        ( SELECT
            subcategory_code,
            subcategory_desc,
            category_id
        FROM
            cls_product_subcategories
        MINUS
        SELECT
            subcategory_code,
            subcategory_desc,
            category_id
        FROM
            bl_3nf.ce_product_subcategories
        )
    cls ON (
        cls.subcategory_code = d.subcategory_code
    ) WHEN MATCHED THEN
        UPDATE
    SET d.subcategory_desc = cls.subcategory_desc, 
    d.update_dt=sysdate
    WHEN NOT MATCHED 
        THEN INSERT (subcategory_id, subcategory_code, subcategory_desc, category_id, insert_dt, update_dt ) VALUES
    (bl_3nf.seq_subcategories.nextval, cls.subcategory_code,cls.subcategory_desc, cls.category_id,  sysdate, sysdate);
    
    COMMIT;
    --dbms_output.put_line('The data in the table CE_DELIVERIES is loaded successfully!');
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END load_ce_product_subcategories;
/****************************************************/

END pkg_load_3nf_subcategories;
/