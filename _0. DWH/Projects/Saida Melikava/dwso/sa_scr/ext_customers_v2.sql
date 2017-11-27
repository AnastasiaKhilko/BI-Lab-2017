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
/
SELECT COUNT(*) FROM ext_customers;
