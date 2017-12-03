CREATE OR REPLACE PACKAGE BODY pkg_load_dim_customers AS
  /**===============================================*\
  Name...............:   pkg_load_dim_customers
  Contents...........:   Package body description
  Author.............:   Maryna Hlazunova
  Date...............:   02-Dec-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_cls2_customers IS

        CURSOR c_cust IS
            SELECT
                customer_id AS customer_srcid,
                nvl(c.last_name,'N/D in 3NF') AS customer_last_name,
                nvl(c.first_name,'N/D in 3NF') AS customer_first_name,
                nvl(c.middle_name,'N/D in 3NF') AS customer_middle_name,
                c.birthdate AS customer_birthdate,
                nvl(c.gender,'N/D in 3NF') AS customer_gender,
                personal_discount AS customer_personal_discount,
                nvl(c.cust_loc_id,-98) AS customer_loc_srcid,
                nvl(l.location_name,'N/D in 3NF') AS location_name,
                nvl(c.locality_address,'N/D in 3NF') AS address,
                nvl(l.loc_type_id,-98) AS loc_type_srcid,
                nvl(lt.loc_type_short,'N/D in 3NF') AS loc_type_short,
                nvl(lt.loc_type_full,'N/D in 3NF') AS loc_type_full,
                nvl(l.dis_id,-98) AS dis_srcid,
                nvl(d.district,'N/D in 3NF') AS district,
                nvl(d.reg_id,-98) AS reg_srcid,
                nvl(r.region,'N/D in 3NF') AS region,
                start_dt,
                end_dt,
                is_active
            FROM
                bl_3nf.ce_customers c
                LEFT JOIN bl_3nf.ce_localities l ON c.cust_loc_id = l.loc_id
                LEFT JOIN bl_3nf.ce_loc_types lt ON l.loc_type_id = lt.loc_type_id
                LEFT JOIN bl_3nf.ce_districts d ON l.dis_id = d.dis_id
                LEFT JOIN bl_3nf.ce_regions r ON d.reg_id = r.reg_id;

        rec_cust   cls2_customers%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls2_customers';
        OPEN c_cust;
        LOOP
            FETCH c_cust INTO rec_cust;
            IF
                c_cust%found
            THEN
                INSERT INTO cls2_customers (
                    customer_srcid,
                    customer_last_name,
                    customer_first_name,
                    customer_middle_name,
                    customer_birthdate,
                    customer_gender,
                    customer_personal_discount,
                    customer_loc_srcid,
                    customer_location_name,
                    customer_address,
                    customer_loc_type_srcid,
                    customer_loc_type_short,
                    customer_loc_type_full,
                    customer_dis_srcid,
                    customer_district,
                    customer_reg_srcid,
                    customer_region,
                    start_dt,
                    end_dt,
                    is_active
                ) VALUES (
                    rec_cust.customer_srcid,
                    rec_cust.customer_last_name,
                    rec_cust.customer_first_name,
                    rec_cust.customer_middle_name,
                    rec_cust.customer_birthdate,
                    rec_cust.customer_gender,
                    rec_cust.customer_personal_discount,
                    rec_cust.customer_loc_srcid,
                    rec_cust.customer_location_name,
                    rec_cust.customer_address,
                    rec_cust.customer_loc_type_srcid,
                    rec_cust.customer_loc_type_short,
                    rec_cust.customer_loc_type_full,
                    rec_cust.customer_dis_srcid,
                    rec_cust.customer_district,
                    rec_cust.customer_reg_srcid,
                    rec_cust.customer_region,
                    rec_cust.start_dt,
                    rec_cust.end_dt,
                    rec_cust.is_active
                );

            END IF;

            EXIT WHEN c_cust%notfound;
        END LOOP;

        CLOSE c_cust;
        COMMIT;
        COMMIT;
        dbms_output.put_line('The data in the table CLS2_CUSTOMERS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls2_customers;
/****************************************************/

    PROCEDURE load_dim_customers_scd
        IS
    BEGIN
        MERGE INTO bl_dwh.dim_customers_scd d USING
            ( SELECT
                customer_srcid,
                customer_last_name,
                customer_first_name,
                customer_middle_name,
                customer_birthdate,
                customer_gender,
                customer_personal_discount,
                customer_loc_srcid,
                customer_location_name,
                customer_address,
                customer_loc_type_srcid,
                customer_loc_type_short,
                customer_loc_type_full,
                customer_dis_srcid,
                customer_district,
                customer_reg_srcid,
                customer_region,
                start_dt,
                end_dt,
                is_active
            FROM
                cls2_customers
            MINUS
            SELECT
                customer_srcid,
                customer_last_name,
                customer_first_name,
                customer_middle_name,
                customer_birthdate,
                customer_gender,
                customer_personal_discount,
                customer_loc_srcid,
                customer_location_name,
                customer_address,
                customer_loc_type_srcid,
                customer_loc_type_short,
                customer_loc_type_full,
                customer_dis_srcid,
                customer_district,
                customer_reg_srcid,
                customer_region,
                start_dt,
                end_dt,
                is_active
            FROM
                bl_dwh.dim_customers_scd
            )
        cls ON (
            d.customer_srcid = cls.customer_srcid
        ) WHEN MATCHED THEN
            UPDATE
        SET d.customer_last_name = cls.customer_last_name,
            d.customer_first_name = cls.customer_first_name,
            d.customer_middle_name = cls.customer_middle_name,
            d.customer_birthdate = cls.customer_birthdate,
            d.customer_gender = cls.customer_gender,
            d.customer_personal_discount = cls.customer_personal_discount,
            d.customer_loc_srcid = cls.customer_loc_srcid,
            d.customer_location_name = cls.customer_location_name,
            d.customer_address = cls.customer_address,
            d.customer_loc_type_srcid = cls.customer_loc_type_srcid,
            d.customer_loc_type_short = cls.customer_loc_type_short,
            d.customer_loc_type_full = cls.customer_loc_type_full,
            d.customer_dis_srcid = cls.customer_dis_srcid,
            d.customer_district = cls.customer_district,
            d.customer_reg_srcid = cls.customer_reg_srcid,
            d.customer_region = cls.customer_region,
            d.start_dt = cls.start_dt,
            d.end_dt = cls.end_dt,
            d.is_active = cls.is_active,
            d.ta_update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( customer_surrid,customer_srcid,customer_last_name,customer_first_name,customer_middle_name,customer_birthdate
,customer_gender,customer_personal_discount,customer_loc_srcid,customer_location_name,customer_address,customer_loc_type_srcid,customer_loc_type_short
,customer_loc_type_full,customer_dis_srcid,customer_district,customer_reg_srcid,customer_region,start_dt,end_dt,is_active,ta_insert_dt
,ta_update_dt ) VALUES ( pkg_utl_seq.seq_getvalue('BL_DWH.SEQ_CUSTOMERS'),cls.customer_srcid,cls.customer_last_name,cls.customer_first_name
,cls.customer_middle_name,cls.customer_birthdate,cls.customer_gender,cls.customer_personal_discount,cls.customer_loc_srcid,cls.customer_location_name
,cls.customer_address,cls.customer_loc_type_srcid,cls.customer_loc_type_short,cls.customer_loc_type_full,cls.customer_dis_srcid,cls
.customer_district,cls.customer_reg_srcid,cls.customer_region,cls.start_dt,cls.end_dt,cls.is_active,SYSDATE,SYSDATE );

        COMMIT;
        dbms_output.put_line('The data in the table DIM_CUSTOMERS_SCD is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_dim_customers_scd;
/****************************************************/

END pkg_load_dim_customers;
/