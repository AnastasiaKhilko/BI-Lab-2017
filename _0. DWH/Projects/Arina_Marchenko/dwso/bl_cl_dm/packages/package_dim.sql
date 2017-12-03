CREATE OR REPLACE PACKAGE pkg_etl_load_dim_cars
AS
  PROCEDURE load_dim_date;
  PROCEDURE load_dim_seller;
  PROCEDURE load_dim_customer;
  PROCEDURE load_dim_cars;
  PROCEDURE load_dim_shop;
  PROCEDURE load_fct_orders;
  
END pkg_etl_load_dim_cars;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_dim_cars
AS
PROCEDURE load_dim_cars
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_dm.dim_cars';
        MERGE INTO bl_dm.dim_cars cc
USING ( SELECT car_id, car_number, car_name, vehicle_type_name, engine_type_name,
gearbox_type_name, model, repaired_status_name, start_dt, end_dt FROM cl_dim_cars ) clc
ON (cc.car_id = clc.car_id and cc.start_dt = clc.start_dt and
cc.end_dt = clc.end_dt )
WHEN MATCHED THEN
  UPDATE SET cc.car_number = clc.car_number, cc.car_name=clc.car_name , 
cc.vehicle_type_name=clc.vehicle_type_name,cc.engine_type_name = clc.engine_type_name  ,
cc.gearbox_type_name= clc.gearbox_type_name ,cc.model= clc.model ,
cc.repaired_status_name=clc.repaired_status_name
   WHERE DECODE(cc.car_number,clc.car_number,0,1)
   +DECODE(cc.car_name,clc.car_name,0,1)
   +DECODE(cc.vehicle_type_name,clc.vehicle_type_name,0,1)
   +DECODE(cc.engine_type_name, clc.engine_type_name,0,1)+DECODE(cc.gearbox_type_name,clc.gearbox_type_name,0,1)
   +DECODE(cc.model,clc.model,0,1)+DECODE(cc.repaired_status_name,clc.repaired_status_name,0,1)>0 
WHEN NOT MATCHED THEN 
INSERT (cc.car_did,cc.car_id, cc.car_number, cc.car_name, cc.vehicle_type_name, cc.engine_type_name,
cc.gearbox_type_name, cc.model, cc.repaired_status_name, cc.start_dt, cc.end_dt)
values (bl_dm.seq_cars_dim.nextval, clc.car_id, clc.car_number, clc.car_name, clc.vehicle_type_name, clc.engine_type_name,
clc.gearbox_type_name, clc.model, clc.repaired_status_name, clc.start_dt, clc.end_dt)  ;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_dim_cars;
  -------------------------------------------
  PROCEDURE load_dim_date
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_dm.dim_date';
	INSERT INTO  bl_dm.dim_date
SELECT SYSDATE+rownum-365*1018 as Date_id, 
    to_number(to_char(SYSDATE+rownum-365*1018-7*1, 'D'))as Day_per_week,
    to_number(to_char(extract(day from SYSDATE+rownum-365*1018)))as Day_per_month,
    to_number(to_char(SYSDATE+rownum-365*1018, 'DDD')) AS Day_per_year,
    to_number(to_char(SYSDATE+rownum-365*1018, 'W')) AS Week_per_month,
    to_number(to_char(SYSDATE+rownum-365*1018, 'IW')) AS Week_per_year,
    to_number(to_char(extract(month from SYSDATE+rownum-365*1018))) as Month_number,
    to_char(SYSDATE+rownum-365*1018, 'MONTH', 'NLS_DATE_LANGUAGE=English') AS Month_name,
    to_number(to_char(extract(year from SYSDATE+rownum-365*1018))) as Year,
    to_char(extract(day from SYSDATE+rownum-365*1018) || '-'|| to_char(extract(month from (SYSDATE+rownum-365*1018)))) as Day_Month,
    to_char(extract(year from SYSDATE+rownum-365*1018) || '-'|| to_char(extract(month from (SYSDATE+rownum-365*1018)))) as Year_Month
FROM dual CONNECT BY rownum <=365*1018;
	commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_dim_date;
  ---------------------------------------------
  PROCEDURE load_dim_seller
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_dm.dim_seller';
        MERGE INTO bl_dm.dim_seller cem
USING ( SELECT seller_id, seller_code, name, surname, phone, email, city_name, country_name, trunc(sysdate) update_dt FROM cl_dim_seller 
) clm
ON (cem.seller_id= clm.seller_id)
WHEN MATCHED THEN
  UPDATE SET cem.seller_code= clm.seller_code, cem.name = clm.name, cem.surname=clm.surname, cem.phone=clm.phone, cem.email = clm.email, 
  cem.city_name = clm.city_name, cem.country_name = clm.country_name, update_dt = sysdate
   WHERE DECODE(cem.seller_code, clm.seller_code,0,1)+DECODE(cem.name, clm.name,0,1)+DECODE(cem.surname,clm.surname,0,1)+DECODE(cem.phone,clm.phone,0,1)
   +DECODE(cem.email, clm.email,0,1)+DECODE(cem.city_name,clm.city_name,0,1)+DECODE(cem.country_name,clm.country_name,0,1)>0 
WHEN NOT MATCHED THEN 
INSERT ( cem.seller_did, cem.seller_id, cem.seller_code, cem.name, cem.surname, cem.phone, cem.email, cem.city_name, cem.country_name, cem.update_dt )
VALUES ( bl_dm.seq_seller_dim.nextval ,clm.seller_id , clm.seller_code, clm.name, clm.surname, clm.phone, clm.email, clm.city_name, clm.country_name,  sysdate);
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_dim_seller;
  -----------------------------------------------------------------------------------------
   PROCEDURE load_dim_customer
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_dm.dim_customers';
        MERGE INTO bl_dm.dim_customers cem
USING ( SELECT customer_id, customer_code, name, surname, age, gender, phone, email, trunc(sysdate) update_dt FROM cl_dim_customers
) clm
ON (cem.customer_id= clm.customer_id)
WHEN MATCHED THEN
  UPDATE SET cem.customer_code= clm.customer_code, cem.name = clm.name, cem.surname=clm.surname, 
  cem.age=clm.age, cem.gender = clm.gender, cem.phone=clm.phone, cem.email = clm.email, 
  update_dt = sysdate
   WHERE DECODE(cem.customer_code, clm.customer_code,0,1)+DECODE(cem.name, clm.name,0,1)+DECODE(cem.surname,clm.surname,0,1)
    +DECODE(cem.age,clm.age,0,1) +DECODE(cem.gender,clm.gender,0,1)+DECODE(cem.phone,clm.phone,0,1)
   +DECODE(cem.email, clm.email,0,1)>0 
WHEN NOT MATCHED THEN 
INSERT ( cem.customer_did, cem.customer_id, cem.customer_code, cem.name, cem.surname, cem.age, cem.gender, cem.phone, cem.email,cem.update_dt )
VALUES ( bl_dm.seq_customers_dim.nextval ,clm.customer_id , clm.customer_code, clm.name, clm.surname, clm.age, clm.gender, clm.phone, clm.email, sysdate);
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_dim_customer;
  -----------------------------------------------------------------------------------------
     PROCEDURE load_dim_shop
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_dm.dim_shop';
        MERGE INTO bl_dm.dim_shop cem
USING ( SELECT shop_id, shop_code, shop_name, phone, email, address_name, city_name,
country_name, trunc(sysdate) update_dt FROM cl_dim_shop
) clm
ON (cem.shop_id= clm.shop_id)
WHEN MATCHED THEN
  UPDATE SET cem.shop_code= clm.shop_code, cem.shop_name = clm.shop_name, cem.phone=clm.phone, 
  cem.email = clm.email, cem.address_name = clm.address_name, cem.city_name = clm.city_name,
  cem.country_name = clm.country_name, update_dt = sysdate
   WHERE DECODE(cem.shop_code, clm.shop_code,0,1)+DECODE(cem.shop_name, clm.shop_name,0,1)
   +DECODE(cem.phone,clm.phone,0,1)+DECODE(cem.email, clm.email,0,1)+DECODE(cem.address_name,clm.address_name,0,1)
   +DECODE(cem.city_name,clm.city_name,0,1) +DECODE(cem.country_name,clm.country_name,0,1)>0 
WHEN NOT MATCHED THEN 
INSERT ( cem.shop_did, cem.shop_id, cem.shop_code, cem.shop_name, cem.phone, cem.email, cem.address_name,
cem.city_name, cem.country_name, cem.update_dt )
VALUES ( bl_dm.seq_shop_dim.nextval ,clm.shop_id, clm.shop_code, clm.shop_name, clm.phone, clm.email, clm.address_name,
clm.city_name, clm.country_name, sysdate);
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_dim_shop;
  -----------------------------------------------------------------------------------------
  PROCEDURE load_fct_orders
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_dm.fct_orders';
   INSERT
INTO bl_dm.fct_orders
  (
    car_id,
    customer_id,
    shop_id,
    seller_id,
    order_code,
    cost,
    minPrice,
    maxPrice,
    avgPrice,
    sdPrice,
    start_dt
  )
SELECT car_id,
    customer_id,
    shop_id,
    seller_id,
    order_code,
    cost,
    minPrice,
    maxPrice,
    avgPrice,
    sdPrice,
    start_dt
FROM cl_fct_orders;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_fct_orders;
END pkg_etl_load_dim_cars;
/