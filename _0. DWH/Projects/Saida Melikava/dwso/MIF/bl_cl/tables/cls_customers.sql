EXECUTE pckg_drop.drop_proc(object_name=>'cls_customers', object_type=>'table');
CREATE TABLE cls_customers
  (
    cust_code     VARCHAR2 ( 200 CHAR ),
    cust_name     VARCHAR2 ( 200 CHAR ),
    cust_surname  VARCHAR2 ( 200 CHAR ),
    cust_email    VARCHAR2 ( 200 CHAR ),
    cust_phone    VARCHAR2 ( 200 CHAR ),
    cust_city_id  NUMBER(8),
    cust_card_num VARCHAR2 ( 200 CHAR )
  );