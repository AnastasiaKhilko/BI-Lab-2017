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
                        location_type = '�.'
                    OR
                        location_type = '�'
                    THEN '�����'
                    WHEN
                        location_type = '��.'
                    OR
                        location_type = '��'
                    THEN '�����������'
                    WHEN
                        location_type = '�.'
                    OR
                        location_type = '�'
                    THEN '�������'
                    WHEN
                        location_type = '�.'
                    OR
                        location_type = '�'
                    THEN '�������'
                    WHEN
                        location_type = '��.'
                    OR
                        location_type = '��'
                    THEN '������� �������'
                    WHEN
                        location_type = '��'
                    OR
                        location_type = '��.'
                    THEN '��������� �������'
                    WHEN
                        location_type = '��'
                    OR
                        location_type = '��.'
                    THEN '��������� �������'
                    WHEN
                        location_type = '���'
                    OR
                        location_type = '���.'
                    THEN '������� ���������� ����'
                    WHEN
                        location_type = '���'
                    OR
                        location_type = '���.'
                    THEN '�������� ���������� �����'
                    WHEN
                        location_type = '�'
                    OR
                        location_type = '�.'
                    THEN '����'
                    WHEN
                        location_type = '�'
                    OR
                        location_type = '�.'
                    THEN '�����'
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