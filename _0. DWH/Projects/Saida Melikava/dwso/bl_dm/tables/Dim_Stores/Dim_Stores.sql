DROP TABLE Dim_Stores;
CREATE TABLE Dim_Stores
  (
    Store_id           NUMBER(8) PRIMARY KEY,
    Store_code         VARCHAR2(15) NOT NULL,
    Store_name         VARCHAR2(35) NOT NULL,
    Store_email        VARCHAR2(65) NOT NULL,
    Store_phone        VARCHAR2(30) NOT NULL,
    Store_manager_id   NUMBER(8) NOT NULL,
    Store_manager_name VARCHAR2(70) NOT NULL,
    Store_region_id    NUMBER(8) NOT NULL,
    Store_region       VARCHAR2(60) NOT NULL,
    Store_country_id   NUMBER(8) NOT NULL,
    Store_country      VARCHAR2(60) NOT NULL,
    Store_city_id      NUMBER(8) NOT NULL,
    Store_city         VARCHAR2(60) NOT NULL,
    Store_address_id   NUMBER(8) NOT NULL,
    Store_address      VARCHAR2(60) NOT NULL,
    Insert_DT          DATE NOT NULL,
    Update_DT          DATE NOT NULL
  );
COMMENT ON TABLE Dim_Stores
IS
  'Table Content: All information about stores is contained here.   
Refresh Cycle/Window: Data is loaded rarely and for a long period of time.  
';
  COMMENT ON column Dim_Stores.Store_id
IS
  'Dimension surrogate key';
  COMMENT ON column Dim_Stores.Store_code
IS
  'Dimension business key, comes from external system.';
  COMMENT ON column Dim_Stores.Store_manager_id
IS
  'Employee_id of a manager if additional join is needed.';
  COMMENT ON column Dim_Stores.Store_manager_name
IS
  'Name+Surname of manager';
  COMMENT ON column Dim_Stores.Store_Region_id
IS
  'ID on region if additional join is needed.';
  COMMENT ON column Dim_Stores.Store_Country_id
IS
  'ID on country if additional join  is needed.';
  COMMENT ON column Dim_Stores.Store_City_id
IS
  'ID on city if additional join  is needed.';
  COMMENT ON column Dim_Stores.Store_Address_id
IS
  'ID on address if additional join  is needed.';
  COMMENT ON column Dim_Stores.Insert_DT
IS
  'When data was loaded';
  COMMENT ON column Dim_Stores.Update_DT
IS
  'When data was updated';
  /*
  GRANT SELECT ON dim_template TO some_user;*/
