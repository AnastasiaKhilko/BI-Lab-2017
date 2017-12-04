CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_subcategories AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_subcategories
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   28-Nov-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_cls_subcategories IS
        CURSOR c_subcat IS
            SELECT DISTINCT
                subcat_code,
                subcategory,
                cat_code
            FROM
                wrk_refer_products;

        rec_subcat   cls_subcategories%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_subcategories';
        OPEN c_subcat;
        LOOP
            FETCH c_subcat INTO rec_subcat;
            IF
                c_subcat%found
            THEN
                INSERT INTO cls_subcategories ( subcat_code,subcategory,cat_code ) VALUES (
                    rec_subcat.subcat_code,
                    rec_subcat.subcategory,
                    rec_subcat.cat_code
                );

            END IF;

            EXIT WHEN c_subcat%notfound;
        END LOOP;

        COMMIT;
        CLOSE c_subcat;
        dbms_output.put_line('The data in the table CLS_SUBCATEGORIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_subcategories;
    
/****************************************************/

    PROCEDURE load_ce_subcategories
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_subcategories d USING
            ( SELECT
                sc.subcat_code,
                sc.subcategory,
                c.cat_id
            FROM
                cls_subcategories sc,
                bl_3nf.ce_categories c
            WHERE
                sc.cat_code = c.cat_code
            MINUS
            SELECT
                subcat_code,
                subcategory,
                cat_id
            FROM
                bl_3nf.ce_subcategories
            )
        cls ON (
            cls.subcat_code = d.subcat_code
        ) WHEN MATCHED THEN
            UPDATE
        SET d.subcategory = cls.subcategory,
            d.cat_id = cls.cat_id,
            d.update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( subcat_id,subcat_code,subcategory,cat_id,insert_dt,update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_SUBCATEGORIES'
),cls.subcat_code,cls.subcategory,cls.cat_id,trunc(SYSDATE),trunc(SYSDATE) );

        COMMIT;
        dbms_output.put_line('The data in the table CE_SUBCATEGORIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_subcategories;
/****************************************************/

END pkg_load_3nf_subcategories;
/