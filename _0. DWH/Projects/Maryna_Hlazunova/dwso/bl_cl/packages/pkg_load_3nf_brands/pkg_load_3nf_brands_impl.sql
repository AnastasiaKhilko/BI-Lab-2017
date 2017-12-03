CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_brands AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_brands
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   23-Nov-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_wrk_brands
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_brands';
        INSERT INTO wrk_brands SELECT
            *
        FROM
            sa_src.ext_brands;

        COMMIT;
        dbms_output.put_line('The data in the table WRK_BRANDS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_brands;
/****************************************************/

    PROCEDURE load_cls_brands
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_brands';
        INSERT INTO cls_brands SELECT DISTINCT
            *
        FROM
            wrk_brands;

        COMMIT;
        dbms_output.put_line('The data in the table CLS_BRANDS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_brands;
    
/****************************************************/

    PROCEDURE load_ce_brands
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_brands b USING
            ( SELECT
                nat_code,
                brand_desc
            FROM
                cls_brands
            MINUS
            SELECT
                nat_code,
                brand_desc
            FROM
                bl_3nf.ce_brands
            )
        cls ON (
            cls.nat_code = b.nat_code
        ) WHEN MATCHED THEN
            UPDATE
        SET b.brand_desc = cls.brand_desc,
            b.update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( brand_id,nat_code,brand_desc,insert_dt,update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_BRANDS'),cls
.nat_code,cls.brand_desc,SYSDATE,SYSDATE );

        COMMIT;
        dbms_output.put_line('The data in the table CE_BRANDS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_brands;
/****************************************************/

END pkg_load_3nf_brands;
/