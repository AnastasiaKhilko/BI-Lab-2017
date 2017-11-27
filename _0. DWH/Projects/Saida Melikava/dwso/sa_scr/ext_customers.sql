--table1

EXECUTE pckg_drop.drop_proc(object_name=>'ext_customers_2', object_type=>'table');
CREATE TABLE ext_customers_2
  (
    code        VARCHAR2 ( 200 CHAR ),
    status      VARCHAR2 ( 200 CHAR ),
    when_filled VARCHAR2 ( 200 CHAR ),
    type        VARCHAR2 ( 200 CHAR ),
    visitor     VARCHAR2 ( 200 CHAR ),
    session_num VARCHAR2 ( 200 CHAR ),
    surname     VARCHAR2 ( 200 CHAR ),
    name        VARCHAR2 ( 200 CHAR ),
    patronymic  VARCHAR2 ( 200 CHAR ),
    born        VARCHAR2 ( 200 CHAR ),
    credit      VARCHAR2 ( 200 CHAR ),
    city        VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ';' ) location ('cust2.csv')
  )
  reject limit unlimited;
/
SELECT *FROM ext_customers_2;

--table2
EXECUTE pckg_drop.drop_proc(object_name=>'ext_customers_3', object_type=>'table');
CREATE TABLE ext_customers_3
  (
    code        VARCHAR2 ( 200 CHAR ),
    status      VARCHAR2 ( 200 CHAR ),
    when_filled VARCHAR2 ( 200 CHAR ),
    type        VARCHAR2 ( 200 CHAR ),
    visitor     VARCHAR2 ( 200 CHAR ),
    session_num VARCHAR2 ( 200 CHAR ),
    surname     VARCHAR2 ( 200 CHAR ),
    name        VARCHAR2 ( 200 CHAR ),
    patronymic  VARCHAR2 ( 200 CHAR ),
    born        VARCHAR2 ( 200 CHAR ),
    phone      VARCHAR2 ( 200 CHAR ),
    city        VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ';' ) location ('cust3.csv')
  )
  reject limit unlimited;
/
SELECT *FROM ext_customers_3;

--table3
EXECUTE pckg_drop.drop_proc(object_name=>'ext_customers_4', object_type=>'table');
CREATE TABLE ext_customers_4
  (
    code        VARCHAR2 ( 200 CHAR ),
    gender      VARCHAR2 ( 200 CHAR ),
    lang        VARCHAR2 ( 200 CHAR ),
    name        VARCHAR2 ( 200 CHAR ),
    mid_name    VARCHAR2 ( 200 CHAR ),
    sur         VARCHAR2 ( 200 CHAR ),
    addr        VARCHAR2 ( 200 CHAR ),
    city        VARCHAR2 ( 200 CHAR ),
    state       VARCHAR2 ( 200 CHAR ),
    statefull   VARCHAR2 ( 200 CHAR ),
    postal_code VARCHAR2 ( 200 CHAR ),
    coun        VARCHAR2 ( 200 CHAR ),
    coun_full   VARCHAR2 ( 200 CHAR ),
    email       VARCHAR2 ( 200 CHAR ),
    phone       VARCHAR2 ( 200 CHAR ),
    phone_code  VARCHAR2 ( 200 CHAR ),
    moth        VARCHAR2 ( 200 CHAR ),
    birth       VARCHAR2 ( 200 CHAR ),
    card_type   VARCHAR2 ( 200 CHAR ),
    card_num    VARCHAR2 ( 200 CHAR ),
    cvv         VARCHAR2 ( 200 CHAR ),
    expires     VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ',' ) location ('cust4.csv')
  )
  reject limit unlimited;
/
SELECT * FROM ext_customers_4;


