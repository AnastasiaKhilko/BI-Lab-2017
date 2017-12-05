CREATE OR REPLACE PACKAGE pckg_insert_stores_dim
AS
  PROCEDURE insert_bl_cls;
  PROCEDURE insert_bl_dim;
END pckg_insert_stores_dim;
/
CREATE OR REPLACE PACKAGE body pckg_insert_stores_dim
AS
PROCEDURE insert_bl_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE bl_cl_dm.dim_cl_stores_scd';
  INSERT
  INTO dim_cl_stores_scd
  SELECT STORE_ID,
    STORE_CODE,
    STORE_NAME,
    STORE_PHONE,
    employee_sur_ID, --DWH
    employee_name,
    employee_surname,
    dis.DISTRICT_ID,
    DISTRICT_desc,
    reg.REGION_ID,
    REGION_desc,
    cit.CITY_ID,
    CITY_desc,
    ADDR_ID,
    ADDR_STREET,
    ADDR_NUMBER_HOUSE,
    START_DT,
    END_DT
  FROM BL_3NF.CE_STORES ce
  INNER JOIN BL_dm.dim_employees dim
  ON ce.store_manager_id=dim.employee_3nf_id
  INNER JOIN bl_3nf.ce_addr ad
  ON ad.addr_id=ce.store_address_id
  INNER JOIN bl_3nf.ce_cities cit
  ON ad.addr_city_id=cit.city_id
  INNER JOIN bl_3nf.ce_regions reg
  ON cit.region_id=reg.region_id
  INNER JOIN bl_3nf.ce_districts dis
  ON dis.district_id=reg.district_id
WHERE store_id>0;
  dbms_output.put_line('Data in the table is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  raise;

END;
PROCEDURE insert_bl_dim
IS
BEGIN
  merge INTO bl_dm.dim_stores_scd dim USING
  (SELECT *  FROM DIM_CL_STORES_SCD

  ) cls ON ( cls.store_3nf_id = dim.store_3nf_id )
WHEN matched THEN
  UPDATE
  SET DIM.STORE_NAME         =CLS.STORE_NAME,
    DIM.STORE_PHONE          = CLS.STORE_PHONE,
    DIM.STORE_MANAGER_SUR_ID     =CLS.STORE_MANAGER_SUR_ID,
    DIM.STORE_MANAGER_NAME   =CLS.STORE_MANAGER_NAME,
    DIM.STORE_MANAGER_SURNAME= CLS.STORE_MANAGER_SURNAME,
    DIM.STORE_DISTRICT_ID    =CLS.STORE_DISTRICT_ID,
    DIM.STORE_DISTRICT       =CLS.STORE_DISTRICT,
    DIM.STORE_REGION_ID      =CLS.STORE_REGION_ID,
    DIM.STORE_REGION         =CLS.STORE_REGION,
    DIM.STORE_CITY_ID        =CLS.STORE_CITY_ID,
    DIM.STORE_CITY           =CLS.STORE_CITY,
    DIM.STORE_ADDRESS_ID     =CLS.STORE_ADDRESS_ID,
    DIM.STORE_ADDRESS_STREET =CLS.STORE_ADDRESS_STREET,
    DIM.STORE_ADDRESS_HOUSE  = CLS.STORE_ADDRESS_HOUSE WHEN NOT MATCHED THEN
  INSERT
    (
      STORE_SUR_ID,
      STORE_3NF_ID,
      STORE_CODE,
      STORE_NAME,
      STORE_PHONE,
      STORE_MANAGER_SUR_ID,
      STORE_MANAGER_NAME,
      STORE_MANAGER_SURNAME,
      STORE_DISTRICT_ID,
      STORE_DISTRICT,
      STORE_REGION_ID,
      STORE_REGION,
      STORE_CITY_ID,
      STORE_CITY,
      STORE_ADDRESS_ID,
      STORE_ADDRESS_STREET,
      STORE_ADDRESS_HOUSE,
      START_DT,
      END_DT
    )
    VALUES
    (
      seq_store_dim.nextval,
      cls.store_3nf_id,
      cls.store_code,
      CLS.STORE_NAME,
      CLS.STORE_PHONE,
      CLS.STORE_MANAGER_SUR_ID,
      CLS.STORE_MANAGER_NAME,
      CLS.STORE_MANAGER_SURNAME,
      CLS.STORE_DISTRICT_ID,
      CLS.STORE_DISTRICT,
      CLS.STORE_REGION_ID,
      CLS.STORE_REGION,
      CLS.STORE_CITY_ID,
      CLS.STORE_CITY,
      CLS.STORE_ADDRESS_ID,
      CLS.STORE_ADDRESS_STREET,
      CLS.STORE_ADDRESS_HOUSE,
      cls.start_dt,
      cls.end_dt
    );
  dbms_output.put_line('Data in the tables is successfully merged: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  raise;

END;
END pckg_insert_stores_dim;
/

