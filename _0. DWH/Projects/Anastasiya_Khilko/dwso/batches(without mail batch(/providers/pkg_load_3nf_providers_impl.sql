CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_providers AS
    PROCEDURE load_wrk_providers
    IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_providers';
        INSERT INTO wrk_providers SELECT
            *
        FROM
            sa_src.ext_providers;
        COMMIT;
        --dbms_output.put_line('The data in the table WRK_DELIVERIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_providers;
/****************************************************/

PROCEDURE load_cls_providers
    IS
CURSOR c_prov
IS
SELECT DISTINCT
    provider_code,
    provider_name,
    city,
    country,
    address,
    email
FROM
    wrk_providers;
rec_prov cls_providers%rowtype;

BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_providers'; 
OPEN c_prov;
  LOOP
    FETCH c_prov INTO rec_prov;
    IF c_prov%found THEN
      INSERT INTO cls_providers (provider_code, provider_name,city,country, address, email)
      values (rec_prov.provider_code, rec_prov.provider_name, rec_prov.city, rec_prov.country, rec_prov.address, rec_prov.email);      
    END IF;
    EXIT WHEN c_prov%notfound;
  END LOOP;
  COMMIT;
  CLOSE c_prov;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END load_cls_providers;


    
/****************************************************/
PROCEDURE load_ce_providers
    IS
    BEGIN
       MERGE INTO bl_3nf.ce_providers d USING 
        ( SELECT 
            provider_code,
            provider_name,
            city,
            country, 
            address,
            email
        FROM cls_providers
        MINUS 
        SELECT 
            provider_code,
            provider_name,
            city,
            country, 
            address,
            email
        FROM bl_3nf.ce_providers) cls ON (
        cls.provider_code = d.provider_code)
        WHEN MATCHED THEN
            UPDATE 
        SET d.provider_name = cls.provider_name, d.city = cls.city, d.country = cls.country, d.address = cls.address, d.email = cls.email
        WHEN NOT MATCHED 
            THEN INSERT (provider_id, provider_code, provider_name, city, country, address, email, insert_dt, update_dt)
            VALUES (bl_3nf.seq_providers.nextval, cls.provider_code, cls.provider_name, cls.city, cls.country, cls.address, cls.email, sysdate, sysdate);
            
            COMMIT;
            
        EXCEPTION
    WHEN OTHERS THEN 
        RAISE;
    
END load_ce_providers;


/****************************************************/

END pkg_load_3nf_providers;
/