/**===============================================*\Name...............:   External tables wrk_ BL_CL layer
Contents...........:   Create tables description
Author.............:   Maryna Hlazunova
Date...............:   22-Nov-2017
\*=============================================== */
--==============================================================
-- Table: wrk_prod_types
--==============================================================
DROP TABLE wrk_prod_types;
--**********************************************
CREATE TABLE wrk_prod_types
  (
    num_code         NUMBER(5),
    type_desc        VARCHAR2 ( 100 CHAR ),
    subcategory_desc VARCHAR2 ( 100 CHAR ),
    category_desc    VARCHAR2 ( 100 CHAR )
  );
--==============================================================
-- Table: wrk_brands
--==============================================================
DROP TABLE wrk_brands;
--**********************************************
CREATE TABLE wrk_brands
  (
    num_code   NUMBER(6),
    brand_desc VARCHAR2 ( 100 CHAR )
  );
--==============================================================
-- Table: wrk_products
--==============================================================
DROP TABLE wrk_products;
--**********************************************
CREATE TABLE wrk_products
  (
    num_code      NUMBER(6),
    product_name  VARCHAR2 (100 CHAR) ,
    product_code  VARCHAR2 (8 CHAR) ,
    product_color VARCHAR2 (20 CHAR) ,
    brand_id      NUMBER(5) ,
    category_id   NUMBER (3)
  );
--==============================================================
-- Table: wrk_delivery_payment
--==============================================================
DROP TABLE wrk_delivery_payment;
--**********************************************
CREATE TABLE wrk_delivery_payment
  (
    num_code  NUMBER(5),
    delivery  VARCHAR2 (100 CHAR),
    payoption VARCHAR2 (100 CHAR)
  );
--==============================================================
-- Table: wrk_locations
--==============================================================
DROP TABLE wrk_locations;
--**********************************************
CREATE TABLE wrk_locations
  (
    num_code      NUMBER(12),
    location_name VARCHAR2 (100 CHAR),
    location_type VARCHAR2 (100 CHAR),
    district      VARCHAR2 (100 CHAR),
    region        VARCHAR2 (100 CHAR)
  );
--==============================================================
-- Table: wrk_pickuppoints
--==============================================================
DROP TABLE wrk_pickuppoints;
--**********************************************
CREATE TABLE wrk_pickuppoints
  (
    num_code NUMBER(2),
    address  VARCHAR2 (300 CHAR)
  );
--==============================================================
-- Table: wrk_customers
--==============================================================
DROP TABLE wrk_customers;
--**********************************************
CREATE TABLE wrk_customers
  (
    num_code      NUMBER(8),
    customer_name VARCHAR2 (200 CHAR),
    birthdate     VARCHAR2 (10 CHAR),
    location      VARCHAR2 (100 CHAR),
    street        VARCHAR2 (100 CHAR),
    house         NUMBER(2),
    appartment    NUMBER(3),
    discount      NUMBER(2)
  );