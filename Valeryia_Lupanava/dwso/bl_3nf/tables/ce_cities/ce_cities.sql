CREATE TABLE cities (
    city_id      NUMBER(10) NOT NULL,
    country_id   NUMBER(10) NOT NULL,
    city         VARCHAR2(20 BYTE) NOT NULL,
    CONSTRAINT city_id_pk PRIMARY KEY ( city_id ),
    CONSTRAINT country_id_fk FOREIGN KEY ( country_id )
        REFERENCES countries ( country_id )
);