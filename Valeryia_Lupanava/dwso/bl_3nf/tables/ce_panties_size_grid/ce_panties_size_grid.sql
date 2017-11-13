CREATE TABLE panties_size_grid (
    panties_size_id    NUMBER(10) NOT NULL,
    panties_size_uk    VARCHAR2(10 BYTE),
    panties_size_usa   VARCHAR2(10 BYTE),
    panties_size_eu    VARCHAR2(10 BYTE),
    panties_size_fr    VARCHAR2(10 BYTE),
    panties_size_uie   VARCHAR2(10 BYTE),
    CONSTRAINT panties_size_id_pk PRIMARY KEY ( panties_size_id )
);