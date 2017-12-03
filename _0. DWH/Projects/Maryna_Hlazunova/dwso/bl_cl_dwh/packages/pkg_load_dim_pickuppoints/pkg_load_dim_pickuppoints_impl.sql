CREATE OR REPLACE PACKAGE BODY pkg_load_dim_pickuppoints AS
  /**===============================================*\
  Name...............:   pkg_load_dim_pickuppoints
  Contents...........:   Package body description
  Author.............:   Maryna Hlazunova
  Date...............:   01-Dec-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_cls2_pickuppoints
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls2_pickuppoints';
        FOR item IN (
            SELECT
                point_id AS pickuppoint_srcid,
                nvl(p.point_loc_id,-98) AS loc_srcid,
                nvl(p.point_address,'N/D in 3NF') AS address,
                nvl(l.location_name,'N/D in 3NF') AS location_name,
                nvl(l.loc_type_id,-98) AS loc_type_srcid,
                nvl(lt.loc_type_short,'N/D in 3NF') AS loc_type_short,
                nvl(lt.loc_type_full,'N/D in 3NF') AS loc_type_full,
                nvl(l.dis_id,-98) AS dis_srcid,
                nvl(d.district,'N/D in 3NF') AS district,
                nvl(d.reg_id,-98) AS reg_srcid,
                nvl(r.region,'N/D in 3NF') AS region
            FROM
                bl_3nf.ce_pickuppoints p
                LEFT JOIN bl_3nf.ce_localities l ON p.point_loc_id = l.loc_id
                LEFT JOIN bl_3nf.ce_loc_types lt ON l.loc_type_id = lt.loc_type_id
                LEFT JOIN bl_3nf.ce_districts d ON l.dis_id = d.dis_id
                LEFT JOIN bl_3nf.ce_regions r ON d.reg_id = r.reg_id
        ) LOOP
            INSERT INTO cls2_pickuppoints (
                pickuppoint_srcid,
                address,
                loc_srcid,
                location_name,
                loc_type_srcid,
                loc_type_short,
                loc_type_full,
                dis_srcid,
                district,
                reg_srcid,
                region
            ) VALUES (
                item.pickuppoint_srcid,
                item.address,
                item.loc_srcid,
                item.location_name,
                item.loc_type_srcid,
                item.loc_type_short,
                item.loc_type_full,
                item.dis_srcid,
                item.district,
                item.reg_srcid,
                item.region
            );

        END LOOP;

        COMMIT;
        dbms_output.put_line('The data in the table CLS2_PICKUPPOINTS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls2_pickuppoints;
    
/****************************************************/

    PROCEDURE load_dim_pickuppoints
        IS
    BEGIN
        MERGE INTO bl_dwh.dim_pickuppoints d USING
            ( SELECT
                pickuppoint_srcid,
                address,
                loc_srcid,
                location_name,
                loc_type_srcid,
                loc_type_short,
                loc_type_full,
                dis_srcid,
                district,
                reg_srcid,
                region
            FROM
                cls2_pickuppoints
            MINUS
            SELECT
                pickuppoint_srcid,
                address,
                loc_srcid,
                location_name,
                loc_type_srcid,
                loc_type_short,
                loc_type_full,
                dis_srcid,
                district,
                reg_srcid,
                region
            FROM
                bl_dwh.dim_pickuppoints
            )
        cls ON (
            cls.pickuppoint_srcid = d.pickuppoint_srcid
        ) WHEN MATCHED THEN
            UPDATE
        SET d.address = cls.address,
            d.loc_srcid = cls.loc_srcid,
            d.location_name = cls.location_name,
            d.loc_type_srcid = cls.loc_type_srcid,
            d.loc_type_short = cls.loc_type_short,
            d.loc_type_full = cls.loc_type_full,
            d.dis_srcid = cls.dis_srcid,
            d.district = cls.district,
            d.reg_srcid = cls.reg_srcid,
            d.region = cls.region,
            d.ta_update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( pickuppoint_surrid,pickuppoint_srcid,address,loc_srcid,location_name,loc_type_srcid,loc_type_short,loc_type_full
,dis_srcid,district,reg_srcid,region,ta_insert_dt,ta_update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_DWH.SEQ_PICKUPPOINTS'),cls.pickuppoint_srcid
,cls.address,cls.loc_srcid,cls.location_name,cls.loc_type_srcid,cls.loc_type_short,cls.loc_type_full,cls.dis_srcid,cls.district,cls
.reg_srcid,cls.region,SYSDATE,SYSDATE );

        COMMIT;
        dbms_output.put_line('The data in the table DIM_PICKUPPOINTS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_dim_pickuppoints;
/****************************************************/

END pkg_load_dim_pickuppoints;
/