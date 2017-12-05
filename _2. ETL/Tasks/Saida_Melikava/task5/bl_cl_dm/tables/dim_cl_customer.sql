DROP TABLE Dim_CL_Customers CASCADE CONSTRAINTS;
CREATE TABLE Dim_CL_Customers
  (
    Customer_3nf_id      NUMBER(8) NOT NULL,
    Customer_code        VARCHAR2(15) NOT NULL,
    Customer_name        VARCHAR2(35) NOT NULL,
    Customer_surname     VARCHAR2(35) NOT NULL,
    Customer_email       VARCHAR2(65) NOT NULL,
    Customer_phone       VARCHAR2(30) NOT NULL,
    Customer_card        VARCHAR2(30) NOT NULL,
    Customer_district_id NUMBER(8) NOT NULL,
    Customer_district    VARCHAR2(60) NOT NULL,
    Customer_region_id   NUMBER(8) NOT NULL,
    Customer_region      VARCHAR2(60) NOT NULL,
    Customer_city_id     NUMBER(8) NOT NULL,
    Customer_city        VARCHAR2(60) NOT NULL
  );