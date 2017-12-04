CREATE OR REPLACE PACKAGE pkg_etl_load_wrk_tables
AS
  PROCEDURE load_wrk_cars;
  PROCEDURE load_wrk_customers;
  PROCEDURE load_wrk_seller;
  PROCEDURE load_wrk_shops;
  PROCEDURE load_wrk_fact;
END pkg_etl_load_wrk_tables;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_wrk_tables
AS
PROCEDURE load_wrk_cars
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_cars';
  INSERT
  INTO wrk_cars
    (
      car_number,
      car_name,
      reg_date,
      vehicle_type,
      engine_type ,
      gearbox_type,
      model,
      brand,
      repaired_status,
      powerps,
      km
    )
  SELECT car_number,
    car_name,
    to_date(registration_date, 'MM/DD/YYYY'),
    vehicle_type,
    fueltype,
    gearbox,
    CONCAT( CONCAT(model,'_'), brand),
    brand,
    repairedstatus,
    powerps,
    km
  FROM sa_src.cars;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_wrk_cars;
----------------------------------
PROCEDURE load_wrk_customers
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_customers';
  INSERT
  INTO wrk_customers
    (
      customer_id,
      name,
      surname,
      age,
      gender,
      phone,
      email
    )
  SELECT customer_id,
    first_name,
    last_name,
    age,
    gender,
    phone,
    email
  FROM sa_src.customer;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_wrk_customers;
------------------------------------------
PROCEDURE load_wrk_seller
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_seller';
  INSERT
  INTO wrk_seller
    (
      seller_id,
      name,
      surname,
      address,
      city,
      state,
      country,
      email,
      phone
    )
  SELECT seller_id,
    name,
    surname,
    address,
    CONCAT( CONCAT(city,'_'), country),
    state,
    country,
    email,
    phone
  FROM sa_src.seller;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_wrk_seller;
---------------------------------------------
PROCEDURE load_wrk_shops
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_shops';
  INSERT
  INTO wrk_shops
    (
      shop_id,
      shop_name,
      phone,
      email,
      address,
      country,
      city
    )
  SELECT shop_id,
    shop_name,
    phone,
    email,
    address,
    country,
    city
  FROM sa_src.shops;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_wrk_shops;
---------------------------------------------
PROCEDURE load_wrk_fact
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_fact';
  INSERT
  INTO wrk_fact
    (
      order_code,
      cost,
      minPrice,
      maxPrice,
      avgPrice,
      sdPrice,
      start_dt,
      end_dt
    )
  SELECT order_code,
      to_number(cost),
      to_number(minPrice),
      to_number(maxPrice),
      to_number(avgPrice),
      to_number(sdPrice),
      to_date(start_dt, 'MM/DD/YYYY'),
      to_date( end_dt, 'MM/DD/YYYY')
      FROM sa_src.orders;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_wrk_fact;
---------------------------------------------
END pkg_etl_load_wrk_tables;
/
