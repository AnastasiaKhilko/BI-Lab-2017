--CLS_SELLERS.
DROP TABLE cls_sellers;
CREATE TABLE cls_sellers
  (
    seller_surr_id NUMBER(38) NOT NULL,
    seller_id      VARCHAR2(50 BYTE) NOT NULL,
    first_name     VARCHAR2(50 BYTE) NOT NULL,
    last_name      VARCHAR2(50 BYTE) NOT NULL,
    age            VARCHAR2(50 BYTE) NOT NULL,
    email          VARCHAR2(50 BYTE) NOT NULL,
    phone          VARCHAR2(50 BYTE) NOT NULL,
    address        VARCHAR2(200 BYTE) NOT NULL,
    start_dt       DATE DEFAULT '01-JAN-1990',
    end_dt         DATE DEFAULT '31-DEC-9999',
    is_active      VARCHAR2 ( 200 CHAR ) NOT NULL
  )
 ;