----------------------------------------------
EXECUTE pckg_drop.drop_proc(object_name=>'ext_catalog', object_type=>'table');
CREATE TABLE ext_catalog
  (
    code             NUMBER(8),
    quantity         NUMBER(8),
    book_name        VARCHAR2 ( 200 CHAR ),
    author_name      VARCHAR2 ( 200 CHAR ),
    ISBN             VARCHAR2 ( 200 CHAR ),
    weight           VARCHAR2 ( 200 CHAR ),
    description      VARCHAR2 ( 200 CHAR ),
    genre            VARCHAR2 ( 200 CHAR ),
    links            VARCHAR2 ( 200 CHAR ),
    price            VARCHAR2 ( 200 CHAR ),
    disc_price       VARCHAR2 ( 200 CHAR ),
    corp_disc_price  VARCHAR2 ( 200 CHAR ),
    final_disc_price VARCHAR2 ( 200 CHAR ),
    price_amount     VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ';' ) location ('price_full.csv')
  )
  reject limit unlimited;
--------------------------------------------------
EXECUTE pckg_drop.drop_proc(object_name=>'ext_customers', object_type=>'table');
CREATE TABLE ext_customers
  (
    code        VARCHAR2 ( 200 CHAR ),
    gender      VARCHAR2 ( 200 CHAR ),
    lang        VARCHAR2 ( 200 CHAR ),
    name        VARCHAR2 ( 200 CHAR ),
    mid_name    VARCHAR2 ( 200 CHAR ),
    sur         VARCHAR2 ( 200 CHAR ),
    addr        VARCHAR2 ( 200 CHAR ),
    city        VARCHAR2 ( 200 CHAR ),
    postal_code VARCHAR2 ( 200 CHAR ),
    email       VARCHAR2 ( 200 CHAR ),
    phone       VARCHAR2 ( 200 CHAR ),
    phone_code  VARCHAR2 ( 200 CHAR ),
    birth       VARCHAR2 ( 200 CHAR ),
    card_type   VARCHAR2 ( 200 CHAR ),
    card_num    VARCHAR2 ( 200 CHAR ),
    cvv         VARCHAR2 ( 200 CHAR ),
    expires     VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ';' ) location ('cust_1.csv','cust_2_msq.csv','cust_3_spb.csv')
  )
  reject limit unlimited;
-----------------------------------------------
EXECUTE pckg_drop.drop_proc(object_name=>'ext_departments', object_type=>'table');
CREATE TABLE ext_departments
  (
    dep_code  NUMBER(8),
    dep__name VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ';' ) location ('dep_csv.csv')
  )
  reject limit unlimited;
------------------------------------------------------
EXECUTE pckg_drop.drop_proc(object_name=>'ext_employee',object_type=>'table');
CREATE TABLE ext_employee
  (
    code       NUMBER(8),
    surname    VARCHAR2 ( 200 CHAR ),
    name       VARCHAR2 ( 200 CHAR ),
    patronymic VARCHAR2 ( 200 CHAR ),
    sex        VARCHAR2 ( 200 CHAR ),
    phone      VARCHAR2 ( 200 CHAR ),
    emai       VARCHAR2 ( 200 CHAR ),
    city       VARCHAR2 ( 200 CHAR ),
    born       VARCHAR2 ( 200 CHAR ),
    n_passport VARCHAR2 ( 200 CHAR ),
    when_pas   VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ';' ) location ('zaym1.csv')
  )
  reject limit unlimited;
-----------------------------------------------------------
execute pckg_drop.drop_proc(object_name=>'ext_goroda',object_type=>'table');
CREATE TABLE ext_goroda
        (  geo_id NUMBER(8),
        city_name   VARCHAR2 ( 200 CHAR ),
         region_name   VARCHAR2 ( 200 CHAR ),
           district_name  VARCHAR2 ( 200 CHAR ),
           population    NUMBER ( 10 ),
           years  VARCHAR2( 10 )
         )
    ORGANIZATION EXTERNAL
        (Type oracle_loader
  default directory ETL
  access parameters (fields terminated by ';' )
  location ('goroda.csv')
)
reject limit unlimited;
------------------------------------------------------------------
EXECUTE pckg_drop.drop_proc(object_name=>'ext_payment', object_type=>'table');
CREATE TABLE ext_payment
  (
    code       VARCHAR2 ( 200 CHAR ),
    type       VARCHAR2 ( 200 CHAR ),
    descr      VARCHAR2 ( 200 CHAR ),
    prepayment VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ';' ) location ('payment.csv')
  )
  reject limit unlimited;
-------------------------------------------------------------------
EXECUTE pckg_drop.drop_proc(object_name=>'ext_shop_chit_gorod', object_type=>'table');
CREATE TABLE ext_shop_chit_gorod
  (
    code         VARCHAR2 ( 200 CHAR ),
    names        VARCHAR2 ( 200 CHAR ),
    city         VARCHAR2 ( 200 CHAR ),
    street       VARCHAR2 ( 200 CHAR ),
    number_house VARCHAR2 ( 200 CHAR ),
    phone        VARCHAR2(200 CHAR)
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ';' ) location ('chit_fin.csv')
  )
  reject limit unlimited;
--------------------------------------------------------------------------------




