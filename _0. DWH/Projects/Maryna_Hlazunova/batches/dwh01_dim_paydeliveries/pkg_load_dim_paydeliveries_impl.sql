CREATE OR REPLACE PACKAGE BODY pkg_load_dim_paydeliveries AS
  /**===============================================*\
  Name...............:   pkg_load_dim_paydeliveries
  Contents...........:   Package body description
  Author.............:   Maryna Hlazunova
  Date...............:   01-Dec-2017
  \*=============================================== */
 /****************************************************/

    PROCEDURE load_cls2_paydeliveries IS

        CURSOR c_paydev IS
            SELECT
                d.del_id AS delivery_srcid,
                nvl(d.delivery,'N/D in 3NF') AS delivery_desc,
                p.pay_id AS payoption_srcid,
                nvl(p.payoption,'N/D in 3NF') AS payoption_desc
            FROM
                bl_3nf.ce_deliveries d
                CROSS JOIN bl_3nf.ce_payoptions p;

        TYPE fetch_array IS
            TABLE OF c_paydev%rowtype;
        paydev_array   fetch_array;
    BEGIN
        EXECUTE IMMEDIATE 'truncate table cls2_paydeliveries';
        OPEN c_paydev;
        LOOP
            FETCH c_paydev BULK COLLECT INTO paydev_array;
            FORALL i IN 1..paydev_array.count
                INSERT INTO cls2_paydeliveries VALUES paydev_array ( i );

            EXIT WHEN c_paydev%notfound;
        END LOOP;

        CLOSE c_paydev;
        COMMIT;
        dbms_output.put_line('The data in the table CLS2_PAYDELIVERIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_cls2_paydeliveries;
    
/****************************************************/

    PROCEDURE load_dim_paydeliveries
        IS
    BEGIN
        MERGE INTO bl_dwh.dim_paydeliveries d USING
            ( SELECT
                delivery_srcid,
                delivery_desc,
                payoption_srcid,
                payoption_desc
            FROM
                cls2_paydeliveries
            MINUS
            SELECT
                delivery_srcid,
                delivery_desc,
                payoption_srcid,
                payoption_desc
            FROM
                bl_dwh.dim_paydeliveries
            )
        cls ON (
                cls.delivery_srcid = d.delivery_srcid
            AND
                cls.payoption_srcid = d.payoption_srcid
        ) WHEN MATCHED THEN
            UPDATE
        SET d.delivery_desc = cls.delivery_desc,
            d.payoption_desc = cls.payoption_desc,
            d.ta_update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( paydelivery_surrid,delivery_srcid,delivery_desc,payoption_srcid,payoption_desc,ta_insert_dt,ta_update_dt
) VALUES ( pkg_utl_seq.seq_getvalue('BL_DWH.SEQ_PAYDELIVERIES'),cls.delivery_srcid,cls.delivery_desc,cls.payoption_srcid,cls.payoption_desc
,SYSDATE,SYSDATE );

        COMMIT;
        dbms_output.put_line('The data in the table DIM_PAYDELIVERIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_dim_paydeliveries;
/****************************************************/

END pkg_load_dim_paydeliveries;
/