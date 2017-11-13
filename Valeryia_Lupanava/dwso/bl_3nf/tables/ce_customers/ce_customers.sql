CREATE TABLE customers (
    customer_id       NUMBER(10) NOT NULL,
    first_name        VARCHAR2(40 BYTE) NOT NULL,
    last_name         VARCHAR2(40 BYTE) NOT NULL,
    age               NUMBER(2),
    age_category_id   NUMBER(10),
    email             VARCHAR2(40 BYTE) NOT NULL,
    phone             VARCHAR2(40 BYTE) NOT NULL,
    address           VARCHAR2(40 BYTE),
    city_id           NUMBER(10),
    CONSTRAINT customer_id_pk PRIMARY KEY ( customer_id ),
    CONSTRAINT city_id_fk FOREIGN KEY ( city_id )
        REFERENCES cities ( city_id ),
    CONSTRAINT age_category_id_fk FOREIGN KEY ( age_category_id )
        REFERENCES age_categories ( age_category_id )
);