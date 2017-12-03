CREATE OR REPLACE PACKAGE pkg_etl_load_cl_tables AS
     PROCEDURE load_cl_dim_cars;
     PROCEDURE load_cl_dim_customers;
     PROCEDURE load_cl_dim_date;
     PROCEDURE load_cl_dim_seller;
     PROCEDURE load_cl_dim_shop;
     PROCEDURE load_cl_fct_table;
END pkg_etl_load_cl_tables;
/


CREATE OR REPLACE PACKAGE BODY pkg_etl_load_cl_tables
AS
  PROCEDURE load_cl_dim_cars
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_dim_cars';
    INSERT INTO cl_dim_cars
  (
    car_id,
      car_number,
      car_name,
      vehicle_type_name,
      engine_type_name,
      gearbox_type_name,
      model,
      repaired_status_name,
      start_dt,
      end_dt
  )
    SELECT c.car_id,
      c.car_number,
      c.car_name,
      vt.vehicle_type_name,
      et.engine_type_name,
      gt.gearbox_type_name,
      m.model_name,
      rs.repaired_status_name,
      c.start_dt,
      c.end_dt
	FROM bl_3nf.ce_cars c
  left join bl_3nf.ce_vehicle_type vt on c.vehicle_type_id = vt.vehicle_type_id
  left join bl_3nf.ce_engine_type et on c.engine_type_id=et.engine_type_id
  left join bl_3nf.ce_gearbox_type gt on c.gearbox_type_id = gt.gearbox_type_id
  left join bl_3nf.ce_model m on c.model_id=m.model_id
  left join bl_3nf.ce_repaired_status rs on c.repaired_status_id = rs.repaired_status_id;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_dim_cars;
  -----------------
   PROCEDURE load_cl_dim_customers
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_dim_customers';
    INSERT INTO cl_dim_customers
  (
	  customer_id,
      customer_code,
      name,
      surname,
      age,
      gender,
      phone,
      email,
      update_dt
  )
    SELECT  customer_id,
      customer_code,
      name,
      surname,
      age,
      gender,
      phone,
      email,
      update_dt
	FROM bl_3nf.ce_customers;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_dim_customers;
  ------------------------------
  PROCEDURE load_cl_dim_date
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_dim_date';
    INSERT INTO  cl_dim_date
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
  END load_cl_dim_date; 
  ------------------------------
  PROCEDURE load_cl_dim_seller
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_dim_seller';
    INSERT INTO cl_dim_seller
  (
    seller_id,
      seller_code,
      name,
      surname,
      phone,
      email,
      city_name,
      country_name,
      update_dt
  )
    SELECT distinct s.seller_id,
      s.seller_code,
      s.name,
      s.surname,
      s.phone,
      s.email,
      ct.city_name,
      cnt.country_name,
      s.update_dt
	FROM bl_3nf.ce_seller s
  left join bl_3nf.ce_city ct on s.city_id = ct.city_id 
  left join bl_3nf.ce_country cnt on ct.country_id =cnt.country_id ;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_dim_seller; 
  -------------------------------
  PROCEDURE load_cl_dim_shop
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_dim_shop';
   INSERT
INTO cl_dim_shop
  (
      shop_id,
      shop_code,
      shop_name,
      phone ,
      email,
      address_name,
      city_name,
      country_name,
      update_dt
  )
SELECT s.shop_id,
      s.shop_code,
      s.shop_name,
      s.phone ,
      s.email,
      ad.address_name,
      cit.city_name,
      con.country_name,
      s.update_dt
FROM bl_3nf.ce_shop s
left join bl_3nf.ce_address ad on s.address_id = ad.address_id
left join bl_3nf.ce_city cit on ad.city_id = cit.city_id
left join bl_3nf.ce_country con on cit.country_id = con.country_id;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_dim_shop;
  -------------------------------------------
    PROCEDURE load_cl_fct_table
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_fct_orders';
   INSERT
INTO cl_fct_orders
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
FROM bl_3nf.ce_orders;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_fct_table;

  -------------------------------------------
END pkg_etl_load_cl_tables;
/
