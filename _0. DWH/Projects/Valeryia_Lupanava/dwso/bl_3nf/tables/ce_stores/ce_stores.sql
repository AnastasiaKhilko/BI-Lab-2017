BEGIN
  pkg_drop.drop_proc(object_name => 'ce_stores', object_type => 'table');
END;

CREATE TABLE ce_stores
  (
    store_id       NUMBER(10) NOT NULL,
    store_srcid    NUMBER(10) NOT NULL,
    store_number   VARCHAR2(100 BYTE) NOT NULL,
    store_desc     VARCHAR2(100 BYTE) NOT NULL,
    manager_number VARCHAR2(100 BYTE) NOT NULL,
    phone          VARCHAR2(100 BYTE) NOT NULL,
    address        VARCHAR2(100 BYTE) NOT NULL,
    city_srcid     NUMBER(10) NOT NULL,
    start_dt       DATE DEFAULT '01-JAN-1990',
    end_dt         DATE DEFAULT '31-DEC-9999',
    is_active      VARCHAR2 ( 200 CHAR ) NOT NULL,
    CONSTRAINT store_id_pk PRIMARY KEY ( store_id ),
    CONSTRAINT store_srcid_unq UNIQUE ( store_srcid ),
     CONSTRAINT st_city_srcid_fk FOREIGN KEY ( city_srcid ) 
    REFERENCES ce_cities ( city_srcid )
  );