CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_stores AS
    PROCEDURE load_wrk_stores
    IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_stores';
        INSERT INTO wrk_stores SELECT
            *
        FROM
            sa_src.ext_stores;
        COMMIT;
        --dbms_output.put_line('The data in the table WRK_DELIVERIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_stores;
/****************************************************/

PROCEDURE load_cls_stores
    IS
    BEGIN
    EXECUTE IMMEDIATE 'truncate table cls_stores';
    INSERT INTO cls_stores select distinct 
        * from wrk_stores;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN 
        RAISE;
    
END load_cls_stores;

    
/****************************************************/
PROCEDURE load_ce_stores
    IS
    BEGIN
       MERGE INTO bl_3nf.ce_stores d USING 
        ( SELECT 
            store_code,
            store_name,
            address_id,
            email, 
            phone
        FROM cls_stores
        MINUS 
        SELECT 
            store_code,
            store_name,
            address_id,
            email,
            phone
        FROM bl_3nf.ce_stores) cls ON (
        cls.store_code = d.store_code)
        WHEN MATCHED THEN
            UPDATE 
        SET d.store_name = cls.store_name, d.address_id = cls.address_id, d.email = cls.email, d.phone = cls.phone
        WHEN NOT MATCHED 
            THEN INSERT (store_id, store_code, store_name, address_id, email, phone, insert_dt, update_dt)
            VALUES (bl_3nf.seq_stores.nextval, cls.store_code, cls.store_name, cls.address_id, cls.email, cls.phone, sysdate, sysdate);
            
            COMMIT;
            
        EXCEPTION
    WHEN OTHERS THEN 
        RAISE;
    
END load_ce_stores;

/****************************************************/

END pkg_load_3nf_stores;
/