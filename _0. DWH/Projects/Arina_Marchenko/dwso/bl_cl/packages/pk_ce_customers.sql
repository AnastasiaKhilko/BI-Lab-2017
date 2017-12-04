CREATE OR REPLACE PACKAGE pkg_etl_load_ce_customers
AS
  PROCEDURE load_ce_country;
  PROCEDURE load_ce_customers;
END pkg_etl_load_ce_customers;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_ce_customers
AS
PROCEDURE load_ce_customers
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_customers';
        MERGE INTO bl_3nf.ce_customers cc
USING ( SELECT customer_code, name, surname, age, gender, phone, email, trunc(sysdate) update_dt 
FROM cl_customers ) clc
ON (cc.customer_code = clc.customer_code )
WHEN MATCHED THEN
  UPDATE SET cc.name=clc.name, cc.surname=clc.name, cc.age=clc.age, cc.gender=clc.gender, 
  cc.phone=clc.phone, cc.email=clc.email, update_dt = sysdate
   WHERE DECODE(cc.name,clc.name,0,1)+DECODE(cc.surname,clc.name,0,1)+ 
  DECODE(cc.age,clc.age,0,1)+DECODE(cc.gender,clc.gender,0,1)+DECODE(cc.phone,clc.phone,0,1)
  +DECODE(cc.email,clc.email,0,1)>0 
WHEN NOT MATCHED THEN 
INSERT (cc.customer_id, cc.customer_code, cc.name,cc.surname, cc.age, cc.gender, cc.phone, cc.email,cc.update_dt)
values (bl_3nf.seq_customers.nextval,clc.customer_code, clc.name,clc.surname, clc.age, clc.gender, clc.phone, clc.email,sysdate)  ;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_ce_customers;
  --------------------------------------------------------------------------------
  PROCEDURE load_ce_country
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_country';
    MERGE INTO bl_3nf.ce_country cegt
USING ( SELECT country_name, trunc(sysdate) update_dt FROM cl_country ) clgt
ON (cegt.country_name = clgt.country_name)
WHEN MATCHED THEN
  UPDATE SET update_dt = sysdate
WHEN NOT MATCHED THEN 
INSERT (cegt.country_id, cegt.country_name, cegt.update_dt )
VALUES (bl_3nf.seq_country.nextval, clgt.country_name, sysdate);
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_ce_country;
  
END pkg_etl_load_ce_customers;
/