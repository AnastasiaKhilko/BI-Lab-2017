CREATE TABLE DimStore
  (
    Store_key          NUMBER(8) PRIMARY KEY,
    Store_id           VARCHAR2(15) NOT NULL,
    Store_name         VARCHAR2(35) NOT NULL,
    Store_email        VARCHAR2(65) NOT NULL,
    Store_phone        VARCHAR2(30) NOT NULL,
    Store_manager_key  NUMBER(8) NOT NULL,
    Store_Manager_name VARCHAR2(70) NOT NULL,
    Store_region_id    NUMBER(8) NOT NULL,
    Store_region       VARCHAR2(60) NOT NULL,
    Store_country_id   NUMBER(8) NOT NULL,
    Store_country      VARCHAR2(60) NOT NULL,
    Store_city_id      NUMBER(8) NOT NULL,
    Store_city         VARCHAR2(60) NOT NULL,
    Store_address_id   NUMBER(8) NOT NULL,
    Store_address      VARCHAR2(60) NOT NULL
  );
