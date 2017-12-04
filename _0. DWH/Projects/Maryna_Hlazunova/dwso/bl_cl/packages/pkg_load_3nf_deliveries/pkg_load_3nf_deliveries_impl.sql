CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_deliveries AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_deliveries
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   23-Nov-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_wrk_deliveries
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_deliveries';
        INSERT INTO wrk_deliveries SELECT
            *
        FROM
            sa_src.ext_deliveries;

        COMMIT;
        dbms_output.put_line('The data in the table WRK_DELIVERIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_deliveries;
/****************************************************/

    PROCEDURE load_cls_deliveries
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_deliveries';
        INSERT INTO cls_deliveries SELECT DISTINCT
            *
        FROM
            wrk_deliveries;

        COMMIT;
        dbms_output.put_line('The data in the table CLS_DELIVERIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_deliveries;
    
/****************************************************/

    PROCEDURE load_ce_deliveries
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_deliveries d USING
            ( SELECT
                nat_code,
                delivery
            FROM
                cls_deliveries
            MINUS
            SELECT
                nat_code,
                delivery
            FROM
                bl_3nf.ce_deliveries
            )
        cls ON (
            cls.nat_code = d.nat_code
        ) WHEN MATCHED THEN
            UPDATE
        SET d.delivery = cls.delivery,
            d.update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( del_id,nat_code,delivery,insert_dt,update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_DELIVERIES'),cls
.nat_code,cls.delivery,SYSDATE,SYSDATE );

        COMMIT;
        dbms_output.put_line('The data in the table CE_DELIVERIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_deliveries;
/****************************************************/

END pkg_load_3nf_deliveries;
/