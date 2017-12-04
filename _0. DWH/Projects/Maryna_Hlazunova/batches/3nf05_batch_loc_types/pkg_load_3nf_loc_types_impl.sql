CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_loc_types AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_pickuppoints
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   26-Nov-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_cls_loc_types
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_loc_types';
        INSERT INTO cls_loc_types SELECT
            location_type AS loc_type_short,
            (
                CASE
                    WHEN
                        location_type = 'г.'
                    OR
                        location_type = 'г'
                    THEN 'город'
                    WHEN
                        location_type = 'аг.'
                    OR
                        location_type = 'аг'
                    THEN 'агрогородок'
                    WHEN
                        location_type = 'д.'
                    OR
                        location_type = 'д'
                    THEN 'деревня'
                    WHEN
                        location_type = 'п.'
                    OR
                        location_type = 'п'
                    THEN 'поселок'
                    WHEN
                        location_type = 'рп.'
                    OR
                        location_type = 'рп'
                    THEN 'рабочий поселок'
                    WHEN
                        location_type = 'кп'
                    OR
                        location_type = 'кп.'
                    THEN 'курортный поселок'
                    WHEN
                        location_type = 'гп'
                    OR
                        location_type = 'гп.'
                    THEN 'городской поселок'
                    WHEN
                        location_type = 'пгт'
                    OR
                        location_type = 'пгт.'
                    THEN 'поселок городского типа'
                    WHEN
                        location_type = 'снп'
                    OR
                        location_type = 'снп.'
                    THEN 'сельский населенный пункт'
                    WHEN
                        location_type = 'с'
                    OR
                        location_type = 'с.'
                    THEN 'село'
                    WHEN
                        location_type = 'х'
                    OR
                        location_type = 'х.'
                    THEN 'хутор'
                END
            ) AS loc_type_full
        FROM
            (
                SELECT DISTINCT
                    location_type
                FROM
                    wrk_locations
            ) t;

        COMMIT;
        dbms_output.put_line('The data in the table CLS_LOC_TYPES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_loc_types;
    
/****************************************************/

    PROCEDURE load_ce_loc_types
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_loc_types lt USING
            ( SELECT
                loc_type_short,
                loc_type_full
            FROM
                cls_loc_types
            MINUS
            SELECT
                loc_type_short,
                loc_type_full
            FROM
                bl_3nf.ce_loc_types
            )
        cls ON (
            cls.loc_type_short = lt.loc_type_short
        ) WHEN MATCHED THEN
            UPDATE
        SET lt.loc_type_full = cls.loc_type_full,
            lt.update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( loc_type_id,loc_type_short,loc_type_full,insert_dt,update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_LOC_TYPES'
),cls.loc_type_short,cls.loc_type_full,SYSDATE,SYSDATE );

        COMMIT;
        dbms_output.put_line('The data in the table CE_LOC_TYPES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_loc_types;
/****************************************************/

END pkg_load_3nf_loc_types;
/