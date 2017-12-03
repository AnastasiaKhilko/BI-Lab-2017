drop table cls2_product_scd;
create table cls2_product_scd
  (
    PROD_surr_ID          NUMBER(8) ,
    PROD_id number(8),
    PROD_NAME        VARCHAR2(100),
    CATEG_NAME       VARCHAR2(25),
    SUBCAT_NAME      VARCHAR2(25),
    PROD_PRICE       NUMBER(8),
    prod_package     varchar2(100),
    START_DT         DATE ,
    END_DT           DATE ,
    IS_ACTIVE        VARCHAR2(15) 
  );
  --------------------------------
  drop table cls2_dim_payment;
create table cls2_dim_payment 
  (payment_id number(8),
  payment_type varchar2(20),
  start_dt date,
  end_dt date
  ); 
  ---------------------------------
  DROP TABLE cls2_supplier_scd;
CREATE TABLE cls2_supplier_scd
  (
    sup_surr_ID NUMBER(8) ,
    sup_id      NUMBER(8),
    sup_NAME    VARCHAR2(100),
    sup_phone   VARCHAR2(50),
    SUp_email   VARCHAR2(100),
    address     VARCHAR2(100),
    city        VARCHAR2(100),   
    ate         VARCHAR2(100),
    COUNTRY     VARCHAR2(100),
    START_DT    DATE ,
    END_DT      DATE ,
    IS_ACTIVE   VARCHAR2(15)
  );