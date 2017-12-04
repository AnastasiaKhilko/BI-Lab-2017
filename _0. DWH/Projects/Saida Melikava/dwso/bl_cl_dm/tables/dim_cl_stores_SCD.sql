DROP TABLE Dim_Cl_Stores_SCD CASCADE CONSTRAINTS;
CREATE TABLE Dim_Cl_Stores_SCD
  (
    Store_3nf_id          NUMBER(8) ,
    Store_code            VARCHAR2(15) ,
    Store_name            VARCHAR2(35) ,
    Store_phone           VARCHAR2(30) ,
    Store_manager_sur_id  NUMBER(8) ,
    Store_manager_name    VARCHAR2(70) ,
    Store_manager_surname VARCHAR2(70) ,
    Store_district_id     NUMBER(8) ,
    Store_district        VARCHAR2(60) ,
    Store_region_id       NUMBER(8) ,
    Store_region          VARCHAR2(60) ,
    Store_city_id         NUMBER(8) ,
    Store_city            VARCHAR2(60) ,
    Store_address_id      NUMBER(8) ,
    Store_address_street  VARCHAR2(70),
    Store_address_house   VARCHAR2(60),
    start_dt              DATE,
    end_dt                DATE
  );