CREATE TABLE age_categories (
    age_category_id   NUMBER(10) NOT NULL,
    age_category      VARCHAR2(20 BYTE) NOT NULL,
    CONSTRAINT age_category_id_pk PRIMARY KEY ( age_category_id )
);