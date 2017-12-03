CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_pickuppoints AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_pickuppoints
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   23-Nov-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_wrk_pickuppoints
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_pickuppoints';
        INSERT INTO wrk_pickuppoints SELECT
            *
        FROM
            sa_src.ext_pickuppoints;

        COMMIT;
        dbms_output.put_line('The data in the table WRK_PICKUPPOINTS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_pickuppoints;
/****************************************************/

    PROCEDURE load_cls_pickuppoints IS

        CURSOR c_pp IS
            SELECT DISTINCT
                nat_code,
                substr(
                    address,
                    instr(address,' ') + 1,
                    instr(
                        address,
                        ' ',
                        1,
                        2
                    ) - instr(address,' ') - 1
                ) AS point_location,
                substr(
                    address,
                    instr(
                        address,
                        ' ',
                        1,
                        2
                    ) + 1
                ) AS point_address
            FROM
                wrk_pickuppoints;

        rec_pp   cls_pickuppoints%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_pickuppoints';
        OPEN c_pp;
        LOOP
            FETCH c_pp INTO rec_pp;
            IF
                c_pp%found
            THEN
                INSERT INTO cls_pickuppoints ( nat_code,point_location,point_address ) VALUES (
                    rec_pp.nat_code,
                    rec_pp.point_location,
                    rec_pp.point_address
                );

            END IF;

            EXIT WHEN c_pp%notfound;
        END LOOP;

        COMMIT;
        CLOSE c_pp;
        dbms_output.put_line('The data in the table CLS_PICKUPPOINTS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_pickuppoints;
    
/****************************************************/

    PROCEDURE load_ce_pickuppoints
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_pickuppoints pp USING
            ( SELECT
                nat_code,
                l.loc_id AS point_loc_id,
                point_address
            FROM
                cls_pickuppoints pp,
                bl_3nf.ce_localities l
            WHERE
                pp.point_location = l.location_name
            MINUS
            SELECT
                nat_code,
                point_loc_id,
                point_address
            FROM
                bl_3nf.ce_pickuppoints
            )
        cls ON (
            cls.nat_code = pp.nat_code
        ) WHEN MATCHED THEN
            UPDATE
        SET pp.point_loc_id = cls.point_loc_id,
            pp.point_address = cls.point_address,
            pp.update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( point_id,nat_code,point_loc_id,point_address,insert_dt,update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_PICKUPPOINTS'
),cls.nat_code,cls.point_loc_id,cls.point_address,SYSDATE,SYSDATE );

        COMMIT;
        dbms_output.put_line('The data in the table CE_PICKUPPOINTS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_pickuppoints;
/****************************************************/

END pkg_load_3nf_pickuppoints;
/