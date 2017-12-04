CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_categories AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_categories
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   27-Nov-2017
  \*=============================================== */

    PROCEDURE load_wrk_refer_products
        IS
    BEGIN
        INSERT INTO wrk_refer_products SELECT
            *
        FROM
            sa_src.ext_refer_products;

        COMMIT;
        dbms_output.put_line('The data in the table CLS_CATEGORIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_refer_products; 
 /****************************************************/

    PROCEDURE load_cls_categories
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_categories';
        INSERT INTO cls_categories SELECT DISTINCT
            cat_code,
            category
        FROM
            wrk_refer_products;

        COMMIT;
        dbms_output.put_line('The data in the table CLS_CATEGORIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_categories;
    
/****************************************************/

    PROCEDURE load_ce_categories
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_categories c USING
            ( SELECT
                cat_code,
                category
            FROM
                cls_categories
            MINUS
            SELECT
                cat_code,
                category
            FROM
                bl_3nf.ce_categories
            )
        cls ON (
            cls.cat_code = c.cat_code
        ) WHEN MATCHED THEN
            UPDATE
        SET c.category = cls.category,
            c.update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( cat_id,cat_code,category,insert_dt,update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_CATEGORIES'),cls
.cat_code,cls.category,SYSDATE,SYSDATE );

        COMMIT;
        dbms_output.put_line('The data in the table CE_CATEGORIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_categories;
/****************************************************/

END pkg_load_3nf_categories;
/