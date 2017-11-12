CREATE TABLE dim_products (
    product_details_id       NUMBER(10) NOT NULL,
    product_id               NUMBER(10) NOT NULL,
    product_name             VARCHAR2(10 BYTE),
    product_description      VARCHAR2(40 BYTE),
    line_id                  NUMBER(10),
    line_name                VARCHAR2(10 BYTE),
    line_description         VARCHAR2(40 BYTE),
    collection_id            NUMBER(10) NOT NULL,
    season_id                NUMBER(10) NOT NULL,
    season                   VARCHAR2(10 BYTE) NOT NULL,
    collection_description   VARCHAR2(40 BYTE),
    collection_date          DATE NOT NULL,
    product_type_id          NUMBER(10) NOT NULL,
    product_type             VARCHAR2(10 BYTE),
    height                   VARCHAR2(10 BYTE),
    hip_girth                NUMBER(10),
    bra_size_uk              VARCHAR2(10 BYTE),
    bra_size_usa             VARCHAR2(10 BYTE),
    bra_size_eu              VARCHAR2(10 BYTE),
    bra_size_fr              VARCHAR2(10 BYTE),
    bra_size_uie             VARCHAR2(10 BYTE),
    panties_size_uk          VARCHAR2(10 BYTE),
    panties_size_usa         VARCHAR2(10 BYTE),
    panties_size_eu          VARCHAR2(10 BYTE),
    panties_size_fr          VARCHAR2(10 BYTE),
    panties_size_uie         VARCHAR2(10 BYTE),
    color                    VARCHAR2(40 BYTE),
    price                    NUMBER(10),
    CONSTRAINT product_details_id_pk PRIMARY KEY ( product_details_id )
);