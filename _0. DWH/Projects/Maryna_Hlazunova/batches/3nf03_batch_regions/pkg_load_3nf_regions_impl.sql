CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_regions AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_regions
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   24-Nov-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_wrk_locations
        IS
    BEGIN
        NULL;
        EXECUTE IMMEDIATE 'truncate table wrk_locations';
        INSERT INTO wrk_locations SELECT
            *
        FROM
            sa_src.ext_locations;

        COMMIT;
        dbms_output.put_line('The data in the table WRK_LOCATIONS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_locations;
/****************************************************/

    PROCEDURE load_cls_regions IS
        CURSOR c_reg IS
            SELECT DISTINCT
                reg_code,
                region
            FROM
                wrk_locations;

        rec_reg   cls_regions%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_regions';
        OPEN c_reg;
        LOOP
            FETCH c_reg INTO rec_reg;
            IF
                c_reg%found
            THEN
                INSERT INTO cls_regions ( reg_code,region ) VALUES (
                    rec_reg.reg_code,
                    rec_reg.region
                );

            END IF;

            EXIT WHEN c_reg%notfound;
        END LOOP;

        COMMIT;
        CLOSE c_reg;
        dbms_output.put_line('The data in the table CLS_REGIONS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_regions;
    
/****************************************************/

    PROCEDURE load_ce_regions
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_regions r USING
            ( SELECT
                reg_code,
                region
            FROM
                cls_regions
            MINUS
            SELECT
                reg_code,
                region
            FROM
                bl_3nf.ce_regions
            )
        cls ON (
            cls.reg_code = r.reg_code
        ) WHEN MATCHED THEN
            UPDATE
        SET r.region = cls.region,
            r.update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( reg_id,reg_code,region,insert_dt,update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_REGIONS'),cls.reg_code
,cls.region,SYSDATE,SYSDATE );

        COMMIT;
        dbms_output.put_line('The data in the table CE_REGIONS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_regions;
/****************************************************/

END pkg_load_3nf_regions;
/