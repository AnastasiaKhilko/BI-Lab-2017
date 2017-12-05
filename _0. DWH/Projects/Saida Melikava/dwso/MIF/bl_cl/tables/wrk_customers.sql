EXECUTE pckg_drop.drop_proc(object_name=>'wrk_customers', object_type=>'table');
CREATE TABLE wrk_customers
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
  ); 