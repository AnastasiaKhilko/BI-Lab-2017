--CE_SEELERS.
DROP TABLE ce_sellers;
CREATE TABLE ce_sellers
  (
    seller_id    NUMBER(10) NOT NULL,
    seller_srcid VARCHAR2(40 BYTE) NOT NULL,
    first_name   VARCHAR2(40 BYTE) NOT NULL,
    last_name    VARCHAR2(40 BYTE) NOT NULL,
    age          VARCHAR2(40 BYTE) NOT NULL,
    email        VARCHAR2(50 BYTE) NOT NULL,
    phone        VARCHAR2(40 BYTE) NOT NULL,
    address      VARCHAR2 ( 200 CHAR ) NOT NULL,
    city_srcid   VARCHAR2 ( 100 BYTE ) ,
    start_dt     DATE DEFAULT '01-JAN-1990',
    end_dt       DATE DEFAULT '31-DEC-9999',
    is_active    VARCHAR2 ( 200 CHAR ) NOT NULL,
    CONSTRAINT seller_id_pk PRIMARY KEY ( seller_id ),
    CONSTRAINT seller_srcid_unq UNIQUE ( seller_srcid ),
    CONSTRAINT city_sell_srcid_fk FOREIGN KEY ( city_srcid ) 
    REFERENCES ce_cities ( city_srcid )
  );