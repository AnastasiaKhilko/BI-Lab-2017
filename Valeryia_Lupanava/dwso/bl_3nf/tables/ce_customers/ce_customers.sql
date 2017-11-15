CREATE TABLE ce_customers (
    customer_srcid       NUMBER(10) NOT NULL,
    first_name           VARCHAR2(40 BYTE) NOT NULL,
    last_name            VARCHAR2(40 BYTE) NOT NULL,
    age                  NUMBER(2) NOT NULL,
    age_category_srcid   NUMBER(10) NOT NULL,
    email                VARCHAR2(40 BYTE) NOT NULL,
    phone                VARCHAR2(40 BYTE) NOT NULL,
    address              VARCHAR2(40 BYTE),
    city_srcid           NUMBER(10) NOT NULL,
    start_dt             DATE NOT NULL,
    end_dt               DATE NOT NULL,
    is_active            VARCHAR2(4) NOT NULL,
    CONSTRAINT customer_scrid_pk PRIMARY KEY ( customer_srcid ),
    CONSTRAINT city_srcid_fk FOREIGN KEY ( city_srcid )
        REFERENCES ce_cities ( city_srcid ),
    CONSTRAINT age_category_srcid_fk FOREIGN KEY ( age_category_srcid )
        REFERENCES ce_age_categories ( age_category_srcid )
);