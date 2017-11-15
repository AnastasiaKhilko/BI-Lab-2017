CREATE TABLE dim_stores (
    store_id     NUMBER(10) NOT NULL,
    store_desc   VARCHAR2(40 BYTE) NOT NULL,
    manager_id   NUMBER(10) NOT NULL,
    phone        VARCHAR2(40 BYTE) NOT NULL,
    address      VARCHAR2(20 BYTE) NOT NULL,
    city         VARCHAR2(20 BYTE) NOT NULL,
    country      VARCHAR2(20 BYTE) NOT NULL,
    region       VARCHAR2(20 BYTE) NOT NULL,
    insert_dt    DATE NOT NULL,
    update_dt    DATE NOT NULL,
    CONSTRAINT store_id_pk PRIMARY KEY ( store_id )
);