BEGIN
  pkg_drop.DROP_Proc(Object_Name => 'ce_stores', Object_Type => 'table');
END;

CREATE TABLE ce_stores (
    store_srcid     NUMBER(10) NOT NULL,
    manager_srcid   NUMBER(10) NOT NULL,
    phone           VARCHAR2(40 BYTE) NOT NULL,
    address         VARCHAR2(40 BYTE) NOT NULL,
    city_srcid      NUMBER(10) NOT NULL,
    start_dt        DATE NOT NULL,
    end_dt          DATE NOT NULL,
    is_active       VARCHAR2(4) NOT NULL,
    CONSTRAINT store_srcid_pk PRIMARY KEY ( store_srcid ),
    CONSTRAINT st_city_srcid_fk FOREIGN KEY ( city_srcid )
        REFERENCES ce_cities ( city_srcid )
);

ALTER TABLE ce_stores
    ADD CONSTRAINT manager_srcid_fk FOREIGN KEY ( manager_srcid )
        REFERENCES ce_employees ( employee_id );