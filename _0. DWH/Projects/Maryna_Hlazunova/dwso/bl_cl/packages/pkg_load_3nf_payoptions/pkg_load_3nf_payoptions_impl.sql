CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_payoptions AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_payoptions
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   23-Nov-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_wrk_payoptions
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_payoptions';
        INSERT INTO wrk_payoptions SELECT
            *
        FROM
            sa_src.ext_payoptions;

        COMMIT;
        dbms_output.put_line('The data in the table WRK_PAYOPTIONS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_payoptions;
/****************************************************/

    PROCEDURE load_cls_payoptions
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_payoptions';
        INSERT INTO cls_payoptions SELECT DISTINCT
            *
        FROM
            wrk_payoptions;

        COMMIT;
        dbms_output.put_line('The data in the table CLS_PAYOPTIONS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_payoptions;
    
/****************************************************/

    PROCEDURE load_ce_payoptions
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_payoptions p USING
            ( SELECT
                nat_code,
                payoption
            FROM
                cls_payoptions
            MINUS
            SELECT
                nat_code,
                payoption
            FROM
                bl_3nf.ce_payoptions
            )
        cls ON (
            cls.nat_code = p.nat_code
        ) WHEN MATCHED THEN
            UPDATE
        SET p.payoption = cls.payoption,
            p.update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( pay_id,nat_code,payoption,insert_dt,update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_PAYOPTIONS'),cls
.nat_code,cls.payoption,SYSDATE,SYSDATE );

        COMMIT;
        dbms_output.put_line('The data in the table CE_PAYOPTIONS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_payoptions;
/****************************************************/

END pkg_load_3nf_payoptions;
/