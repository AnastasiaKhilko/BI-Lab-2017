DROP TABLE Dim_Stores_SCD CASCADE CONSTRAINTS;
CREATE TABLE Dim_Stores_SCD
  (
    Store_sur_id          NUMBER(8) PRIMARY KEY,
    Store_3nf_id          NUMBER(8) NOT NULL,
    Store_code            VARCHAR2(15) NOT NULL,
    Store_name            VARCHAR2(35) NOT NULL,
    Store_phone           VARCHAR2(30) NOT NULL,
    Store_manager_sur_id      NUMBER(8) NOT NULL,
    Store_manager_name    VARCHAR2(70) NOT NULL,
    Store_manager_surname VARCHAR2(70) NOT NULL,
    Store_district_id     NUMBER(8) NOT NULL,
    Store_district        VARCHAR2(60) NOT NULL,
    Store_region_id       NUMBER(8) NOT NULL,
    Store_region          VARCHAR2(60) NOT NULL,
    Store_city_id         NUMBER(8) NOT NULL,
    Store_city            VARCHAR2(60) NOT NULL,
    Store_address_id      NUMBER(8) NOT NULL,
    Store_address_street  VARCHAR2(70) NOT NULL,
    Store_address_house   VARCHAR2(60) NOT NULL,
    start_DT              DATE DEFAULT(to_date('01-JAN-1900','dd-mon-yyyy')) NOT NULL,
    end_DT                DATE DEFAULT(to_date('31-DEC-9999','dd-mon-yyyy')) NOT NULL,
    is_active AS (
    CASE
      WHEN end_dt=to_date('31-DEC-9999','dd-mon-yyyy')
      THEN 'Y'
      ELSE 'N'
    END) ,
    insert_DT DATE DEFAULT(sysdate) NOT NULL
  );
COMMENT ON TABLE Dim_Stores_SCD
IS
  'Table Content: All information about stores is contained here.   
Refresh Cycle/Window: Data is loaded rarely and for a long period of time.  
';
  COMMENT ON column Dim_Stores_SCD.Store_sur_id
IS
  'Dimension surrogate key';
  COMMENT ON column Dim_Stores_SCD.Store_code
IS
  'Dimension business key, comes from external system.';
  COMMENT ON column Dim_Stores_SCD.Store_manager_sur_id
IS
  'Employee_id of a manager if additional join is needed.';
  COMMENT ON column Dim_Stores_SCD.Store_manager_name
IS
  'Name+Surname of manager';
  COMMENT ON column Dim_Stores_SCD.Store_Region_id
IS
  'ID on region if additional join is needed.';
  COMMENT ON column Dim_Stores_SCD.Store_district_id
IS
  'ID on country if additional join  is needed.';
  COMMENT ON column Dim_Stores_SCD.Store_City_id
IS
  'ID on city if additional join  is needed.';
  COMMENT ON column Dim_Stores_SCD.Store_Address_id
IS
  'ID on address if additional join  is needed.';
  COMMENT ON column Dim_Stores_SCD.Start_DT
IS
  'When started to function.';
  COMMENT ON column Dim_Stores_SCD.End_DT
IS
  'IWhen ended to function.';
  COMMENT ON column Dim_Stores_SCD.Is_Active
IS
  'Active(Y) or Not(Y).';
  COMMENT ON column Dim_Stores_SCD.Insert_DT
IS
  'When data was loaded';
