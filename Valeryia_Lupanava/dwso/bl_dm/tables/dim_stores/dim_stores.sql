CREATE TABLE dim_stores (
    store_id     NUMBER(10) NOT NULL,
    manager_id   NUMBER(10),
    phone        VARCHAR2(40 BYTE) NOT NULL,
    address      VARCHAR2(20 BYTE),
    city         VARCHAR2(20 BYTE),
    country      VARCHAR2(20 BYTE),
    region       VARCHAR2(20 BYTE),
    CONSTRAINT store_id_pk PRIMARY KEY ( store_id )
);