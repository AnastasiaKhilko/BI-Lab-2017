CREATE TABLE regions (
    region_id   NUMBER(10) NOT NULL,
    region      VARCHAR2(20 BYTE) NOT NULL,
    CONSTRAINT region_id_pk PRIMARY KEY ( region_id )
);