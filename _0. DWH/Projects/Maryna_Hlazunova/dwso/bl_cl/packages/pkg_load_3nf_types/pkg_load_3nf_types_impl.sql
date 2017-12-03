CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_types AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_types
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   28-Nov-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_cls_types IS
        CURSOR c_typ IS
            SELECT DISTINCT
                type_code,
                type,
                subcat_code
            FROM
                wrk_refer_products;

        rec_typ   cls_types%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_types';
        OPEN c_typ;
        LOOP
            FETCH c_typ INTO rec_typ;
            IF
                c_typ%found
            THEN
                INSERT INTO cls_types ( type_code,type_name,subcat_code ) VALUES (
                    rec_typ.type_code,
                    rec_typ.type_name,
                    rec_typ.subcat_code
                );

            END IF;

            EXIT WHEN c_typ%notfound;
        END LOOP;

        COMMIT;
        CLOSE c_typ;
        dbms_output.put_line('The data in the table CLS_TYPES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_types;
    
/****************************************************/

    PROCEDURE load_ce_types
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_types typ USING
            ( SELECT
                t.type_code,
                t.type_name,
                sc.subcat_id
            FROM
                cls_types t,
                bl_3nf.ce_subcategories sc
            WHERE
                    1 = 1
                AND
                    t.subcat_code = sc.subcat_code
            MINUS
            SELECT
                type_code,
                type_name,
                subcat_id
            FROM
                bl_3nf.ce_types
            )
        cls ON (
            cls.type_code = typ.type_code
        ) WHEN MATCHED THEN
            UPDATE
        SET typ.type_name = cls.type_name,
            typ.subcat_id = cls.subcat_id,
            typ.update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( type_id,type_code,type_name,subcat_id,insert_dt,update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_TYPES'
),cls.type_code,cls.type_name,cls.subcat_id,trunc(SYSDATE),trunc(SYSDATE) );

        COMMIT;
        dbms_output.put_line('The data in the table CE_TYPES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_types;
/****************************************************/

END pkg_load_3nf_types;
/