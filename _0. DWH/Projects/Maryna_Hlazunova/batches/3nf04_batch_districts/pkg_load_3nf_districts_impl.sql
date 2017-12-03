CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_districts AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_districts
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   24-Nov-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_cls_districts IS
        CURSOR c_dis IS
            SELECT DISTINCT
                dis_code,
                district,
                reg_code
            FROM
                wrk_locations;

        rec_dis   cls_districts%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_districts';
        OPEN c_dis;
        LOOP
            FETCH c_dis INTO rec_dis;
            IF
                c_dis%found
            THEN
                INSERT INTO cls_districts ( dis_code,district,reg_code ) VALUES (
                    rec_dis.dis_code,
                    rec_dis.district,
                    rec_dis.reg_code
                );

            END IF;

            EXIT WHEN c_dis%notfound;
        END LOOP;

        COMMIT;
        CLOSE c_dis;
        dbms_output.put_line('The data in the table CLS_DISTRICTS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_districts;
    
/****************************************************/

    PROCEDURE load_ce_districts
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_districts d USING
            ( SELECT
                d.dis_code,
                d.district,
                r.reg_id
            FROM
                cls_districts d,
                bl_3nf.ce_regions r
            WHERE
                d.reg_code = r.reg_code
            MINUS
            SELECT
                dis_code,
                district,
                reg_id
            FROM
                bl_3nf.ce_districts
            )
        cls ON (
            cls.dis_code = d.dis_code
        ) WHEN MATCHED THEN
            UPDATE
        SET d.district = cls.district,
            d.update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( dis_id,dis_code,district,reg_id,insert_dt,update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_DISTRICTS'
),cls.dis_code,cls.district,cls.reg_id,SYSDATE,SYSDATE );

        COMMIT;
        dbms_output.put_line('The data in the table CE_DISTRICTS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_districts;
/****************************************************/

END pkg_load_3nf_districts;
/