BEGIN
  pkg_drop.drop_proc(object_name => 'dim_stores_scd', object_type => 'table');
END;

CREATE TABLE dim_stores_scd
  (
    store_surr_id NUMBER(38) NOT NULL,
    store_id      VARCHAR2(50 BYTE) NOT NULL,
    store_desc    VARCHAR2(50 BYTE) NOT NULL,
    phone         VARCHAR2(50 BYTE) NOT NULL,
    address       VARCHAR2(50 BYTE) NOT NULL,
    city          VARCHAR2(100 BYTE) NOT NULL,
    country       VARCHAR2(100 BYTE) NOT NULL,
    region        VARCHAR2(100 BYTE) NOT NULL,
    insert_dt     DATE DEFAULT '01-JAN-1990',
    update_dt     DATE DEFAULT SYSDATE,
    CONSTRAINT store_surr_id_pk PRIMARY KEY (store_surr_id)
  );