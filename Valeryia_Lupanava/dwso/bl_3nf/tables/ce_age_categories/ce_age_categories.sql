CREATE TABLE ce_age_categories (
    age_category_srcid   NUMBER(10) NOT NULL,
    age_category         VARCHAR2(20 BYTE) NOT NULL,
    CONSTRAINT age_category_srcid_pk PRIMARY KEY ( age_category_srcid )
);