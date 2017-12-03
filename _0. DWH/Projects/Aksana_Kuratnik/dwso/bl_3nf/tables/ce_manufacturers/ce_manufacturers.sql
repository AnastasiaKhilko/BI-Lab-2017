--CE_MANUFACTURERS.
DROP TABLE ce_manufacturers;
CREATE TABLE ce_manufacturers
  (
    manufacturer_id    NUMBER(10) NOT NULL,
    manufacturer_srcid VARCHAR2(100 BYTE) NOT NULL,
    manufacturer_code  VARCHAR2(100 BYTE) NOT NULL,
    manufacturer_name  VARCHAR2(100 BYTE) NOT NULL,
    phone              VARCHAR2(100 BYTE) NOT NULL,
    address            VARCHAR2(100 BYTE) NOT NULL,
    city_srcid         VARCHAR2(100 BYTE) NOT NULL,
    insert_dt          DATE DEFAULT '01-JAN-1990',
    update_dt          DATE DEFAULT '31-DEC-9999',
    CONSTRAINT manufacturer_id_pk PRIMARY KEY ( manufacturer_id ),
    CONSTRAINT manufacturer_srcid_unq UNIQUE ( manufacturer_srcid ),
    CONSTRAINT man_city_srcid_fk FOREIGN KEY ( city_srcid ) REFERENCES ce_cities ( city_srcid )
  );