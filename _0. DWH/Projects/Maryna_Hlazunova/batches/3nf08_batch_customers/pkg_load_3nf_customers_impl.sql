CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_customers AS
  /**===============================================*\
  Name...............:   pkg_load_3nf_customers
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   29-Nov-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_wrk_customers IS

        CURSOR c_cust IS
            SELECT
                nat_code,
                customer_name,
                birthdate,
                locality,
                street,
                house,
                appartment,
                discount
            FROM
                sa_src.ext_customers;

        rec_cust   wrk_customers%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_customers';
        OPEN c_cust;
        LOOP
            FETCH c_cust INTO rec_cust;
            IF
                c_cust%found
            THEN
                INSERT INTO wrk_customers (
                    nat_code,
                    customer_name,
                    birthdate,
                    locality,
                    street,
                    house,
                    appartment,
                    discount
                ) VALUES (
                    rec_cust.nat_code,
                    rec_cust.customer_name,
                    rec_cust.birthdate,
                    rec_cust.locality,
                    rec_cust.street,
                    rec_cust.house,
                    rec_cust.appartment,
                    rec_cust.discount
                );

            END IF;

            EXIT WHEN c_cust%notfound;
        END LOOP;

        COMMIT;
        CLOSE c_cust;
        COMMIT;
        dbms_output.put_line('The data in the table WRK_CUSTOMERS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_customers;
/****************************************************/

    PROCEDURE load_wrk_customers2 IS

        CURSOR c_cust IS
            SELECT
                nat_code AS customer_code,
                initcap(substr(
                    customer_name,
                    1,
                    instr(
                        customer_name,
                        ' ',
                        1,
                        1
                    ) - 1
                ) ) AS last_name,
                initcap(substr(
                    customer_name,
                    instr(customer_name,' ') + 1,
                    instr(
                        customer_name,
                        ' ',
                        1,
                        2
                    ) - instr(customer_name,' ') - 1
                ) ) AS first_name,
                initcap(substr(
                    customer_name,
                    instr(
                        customer_name,
                        ' ',
                        1,
                        2
                    ) + 1
                ) ) AS middle_name,
                TO_DATE(
                    substr(birthdate,1,6)
                     || TO_CHAR(1900 + to_number(substr(birthdate,-2,2) ) ),
                    'DD.MM.YYYY'
                ) AS birthdate,
                (
                    CASE
                        WHEN lower(substr(customer_name,-3,3) ) IN (
                            'вна','чна'
                        ) THEN 'Ж'
                        WHEN lower(substr(customer_name,-3,3) ) IN (
                            'вич','ьич','кич','мич','тич'
                        ) THEN 'М'
                        ELSE 'N/A'
                    END
                ) AS gender,
                nvl(discount,0) AS personal_discount,
                substr(
                    locality,
                    instr(locality,' ') + 1
                ) AS locality_desc,
                street
                 || ' '
                 || house
                 || ' '
                 || appartment AS locality_address
            FROM
                wrk_customers;

        rec_cust   wrk_customers2%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_customers2';
        OPEN c_cust;
        LOOP
            FETCH c_cust INTO rec_cust;
            IF
                c_cust%found
            THEN
                INSERT INTO wrk_customers2 (
                    customer_code,
                    last_name,
                    first_name,
                    middle_name,
                    birthdate,
                    gender,
                    personal_discount,
                    locality_desc,
                    locality_address
                ) VALUES (
                    rec_cust.customer_code,
                    rec_cust.last_name,
                    rec_cust.first_name,
                    rec_cust.middle_name,
                    rec_cust.birthdate,
                    rec_cust.gender,
                    rec_cust.personal_discount,
                    rec_cust.locality_desc,
                    rec_cust.locality_address
                );

            END IF;

            EXIT WHEN c_cust%notfound;
        END LOOP;

        COMMIT;
        CLOSE c_cust;
        COMMIT;
        dbms_output.put_line('The data in the table WRK_CUSTOMERS2 is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_customers2;

/****************************************************/

    PROCEDURE load_cls_customers IS

        CURSOR c_cust IS
            SELECT
                src.customer_code,
                src.last_name,
                src.first_name,
                src.middle_name,
                src.birthdate,
                src.gender,
                src.personal_discount,
                l.loc_id AS loc_id,
                src.locality_address,
                nvl2(
                    tgt.customer_code,
                    trunc(SYSDATE),
                    TO_DATE('01/01/1900','DD/MM/YYYY')
                ) start_dt,
                TO_DATE('31/12/9999','DD/MM/YYYY') end_dt,
                'Y' is_active
            FROM
                wrk_customers2 src
                LEFT JOIN bl_3nf.ce_customers tgt ON (
                        tgt.start_dt <= trunc(SYSDATE)
                    AND
                        tgt.end_dt > trunc(SYSDATE)
                    AND
                        tgt.customer_code = src.customer_code
                )
                JOIN bl_3nf.ce_localities l ON l.location_name = src.locality_desc
            WHERE
                ( DECODE(
                    src.last_name,
                    tgt.last_name,
                    0,
                    1
                ) + DECODE(
                    src.first_name,
                    tgt.first_name,
                    0,
                    1
                ) + DECODE(
                    src.middle_name,
                    tgt.middle_name,
                    0,
                    1
                ) + DECODE(
                    src.birthdate,
                    tgt.birthdate,
                    0,
                    1
                ) + DECODE(
                    src.gender,
                    tgt.gender,
                    0,
                    1
                ) + DECODE(
                    src.personal_discount,
                    tgt.personal_discount,
                    0,
                    1
                ) + DECODE(
                    l.loc_id,
                    tgt.cust_loc_id,
                    0,
                    1
                ) + DECODE(
                    src.locality_address,
                    tgt.locality_address,
                    0,
                    1
                ) ) > 0
            UNION ALL
            SELECT
                tgt.customer_code,
                tgt.last_name,
                tgt.first_name,
                tgt.middle_name,
                tgt.birthdate,
                tgt.gender,
                tgt.personal_discount,
                tgt.cust_loc_id,
                tgt.locality_address,
                tgt.start_dt,
                trunc(SYSDATE) end_dt,
                'N' is_active
            FROM
                wrk_customers2 src
                JOIN bl_3nf.ce_customers tgt ON (
                        tgt.start_dt <= trunc(SYSDATE)
                    AND
                        tgt.end_dt > trunc(SYSDATE)
                    AND
                        tgt.customer_code = src.customer_code
                )
                JOIN bl_3nf.ce_localities l ON l.location_name = src.locality_desc
            WHERE
                ( DECODE(
                    src.last_name,
                    tgt.last_name,
                    0,
                    1
                ) + DECODE(
                    src.first_name,
                    tgt.first_name,
                    0,
                    1
                ) + DECODE(
                    src.middle_name,
                    tgt.middle_name,
                    0,
                    1
                ) + DECODE(
                    src.birthdate,
                    tgt.birthdate,
                    0,
                    1
                ) + DECODE(
                    src.gender,
                    tgt.gender,
                    0,
                    1
                ) + DECODE(
                    src.personal_discount,
                    tgt.personal_discount,
                    0,
                    1
                ) + DECODE(
                    l.loc_id,
                    tgt.cust_loc_id,
                    0,
                    1
                ) + DECODE(
                    src.locality_address,
                    tgt.locality_address,
                    0,
                    1
                ) ) > 0;

        rec_cust   cls_customers%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls_customers';
        OPEN c_cust;
        LOOP
            FETCH c_cust INTO rec_cust;
            IF
                c_cust%found
            THEN
                INSERT INTO cls_customers (
                    customer_code,
                    last_name,
                    first_name,
                    middle_name,
                    birthdate,
                    gender,
                    personal_discount,
                    cust_loc_id,
                    locality_address,
                    start_dt,
                    end_dt,
                    is_active
                ) VALUES (
                    rec_cust.customer_code,
                    rec_cust.last_name,
                    rec_cust.first_name,
                    rec_cust.middle_name,
                    rec_cust.birthdate,
                    rec_cust.gender,
                    rec_cust.personal_discount,
                    rec_cust.cust_loc_id,
                    rec_cust.locality_address,
                    rec_cust.start_dt,
                    rec_cust.end_dt,
                    rec_cust.is_active
                );

            END IF;

            EXIT WHEN c_cust%notfound;
        END LOOP;

        COMMIT;
        CLOSE c_cust;
        dbms_output.put_line('The data in the table CLS_CUSTOMERS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls_customers;

/****************************************************/

    PROCEDURE load_ce_customers
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_customers tgt USING
            ( SELECT
                customer_code,
                last_name,
                first_name,
                middle_name,
                birthdate,
                gender,
                personal_discount,
                cust_loc_id,
                locality_address,
                start_dt,
                end_dt,
                is_active
            FROM
                cls_customers
            )
        src ON (
                src.customer_code = tgt.customer_code
            AND
                src.start_dt = tgt.start_dt
        ) WHEN MATCHED THEN
            UPDATE
        SET tgt.end_dt = src.end_dt,
            tgt.is_active = src.is_active
        WHEN NOT MATCHED THEN INSERT ( customer_id,customer_code,last_name,first_name,middle_name,birthdate,gender,personal_discount,cust_loc_id
,locality_address,start_dt,end_dt,is_active ) VALUES ( pkg_utl_seq.seq_getvalue('BL_3NF.SEQ_CUSTOMERS'),src.customer_code,src.last_name
,src.first_name,src.middle_name,src.birthdate,src.gender,src.personal_discount,src.cust_loc_id,src.locality_address,src.start_dt,
src.end_dt,src.is_active );

        COMMIT;
        dbms_output.put_line('The data in the table CE_CUSTOMERS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_customers;
/****************************************************/

END pkg_load_3nf_customers;
/