CREATE TABLE stores (
    store_id     NUMBER(10) NOT NULL,
    manager_id   NUMBER(10),
    phone        VARCHAR2(40 BYTE) NOT NULL,
    address      VARCHAR2(40 BYTE) NOT NULL,
    city_id      NUMBER(10),
    CONSTRAINT store_id_pk PRIMARY KEY ( store_id ),
    CONSTRAINT city_st_id_fk FOREIGN KEY ( city_id )
        REFERENCES cities ( city_id )
);

ALTER TABLE stores
    ADD CONSTRAINT manager_id_fk FOREIGN KEY ( manager_id )
        REFERENCES employees ( employee_id );
