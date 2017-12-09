--CE_CUSTOMERS.
DROP TABLE ce_customers;
CREATE TABLE ce_customers
  (
    customer_id        NUMBER ( 38 ) NOT NULL,
    customer_srcid     VARCHAR2 ( 200 CHAR ) NOT NULL,
    first_name         VARCHAR2 ( 200 CHAR ) NOT NULL,
    last_name          VARCHAR2 ( 200 CHAR ) NOT NULL,
    age                NUMBER ( 38 ) NOT NULL,
    email              VARCHAR2 ( 200 CHAR ) NOT NULL,
    phone              VARCHAR2 ( 200 CHAR ) NOT NULL,
    address            VARCHAR2 ( 200 CHAR ) NOT NULL,
    city_srcid         VARCHAR2 ( 200 CHAR ) NOT NULL,
    start_dt           DATE DEFAULT '01-JAN-1990',
    end_dt             DATE DEFAULT '31-DEC-9999',
    is_active          VARCHAR2 ( 200 CHAR ) NOT NULL,
    CONSTRAINT customer_id_pk PRIMARY KEY ( customer_id ),
    CONSTRAINT city_srcid_fk FOREIGN KEY ( city_srcid ) 
    REFERENCES ce_cities ( city_srcid )
  );