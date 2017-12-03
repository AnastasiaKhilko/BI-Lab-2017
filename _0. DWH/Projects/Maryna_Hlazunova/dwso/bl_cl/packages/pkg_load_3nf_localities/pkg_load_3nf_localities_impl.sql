CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_localities AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_districts
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   26-Nov-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_cls_localities IS

        CURSOR c_loc IS
            SELECT DISTINCT
                loc_code,
                location_type,
                location_name,
                dis_code,
                reg_code
            FROM
                wrk_locations;

        rec_loc   cls_localities%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_localities';
        OPEN c_loc;
        LOOP
            FETCH c_loc INTO rec_loc;
            IF
                c_loc%found
            THEN
                INSERT INTO cls_localities (
                    loc_code,
                    location_type,
                    location_name,
                    dis_code,
                    reg_code
                ) VALUES (
                    rec_loc.loc_code,
                    rec_loc.location_type,
                    rec_loc.location_name,
                    rec_loc.dis_code,
                    rec_loc.reg_code
                );

            END IF;

            EXIT WHEN c_loc%notfound;
        END LOOP;

        COMMIT;
        CLOSE c_loc;
        dbms_output.put_line('The data in the table CLS_LOCALITIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_localities;
    
/****************************************************/

    PROCEDURE load_ce_localities
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_localities loc USING
            ( SELECT
                l.loc_code,
                lt.loc_type_id,
                l.location_name,
                d.dis_id
            FROM
                cls_localities l,
                bl_3nf.ce_districts d,
                bl_3nf.ce_loc_types lt
            WHERE
                    1 = 1
                AND
                    l.dis_code = d.dis_code
                AND
                    l.location_type = lt.loc_type_short
            MINUS
            SELECT
                loc_code,
                loc_type_id,
                location_name,
                dis_id
            FROM
                bl_3nf.ce_localities
            )
        cls ON (
            cls.loc_code = loc.loc_code
        ) WHEN MATCHED THEN
            UPDATE
        SET loc.loc_type_id = cls.loc_type_id,
            loc.location_name = cls.location_name,
            loc.dis_id = cls.dis_id,
            loc.update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( loc_id,loc_code,loc_type_id,location_name,dis_id,insert_dt,update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_LOCALITIES'
),cls.loc_code,cls.loc_type_id,cls.location_name,cls.dis_id,SYSDATE,SYSDATE );

        COMMIT;
        dbms_output.put_line('The data in the table CE_LOCALITIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_localities;
/****************************************************/

END pkg_load_3nf_localities;
/