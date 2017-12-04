DROP TABLE ce_stores CASCADE CONSTRAINTS;

CREATE TABLE ce_stores (
    store_id           NUMBER(8) PRIMARY KEY,
    store_code         VARCHAR2(30) NOT NULL,
    store_name         VARCHAR2(30) NOT NULL,
    store_phone        VARCHAR2(30) NOT NULL,
    store_manager_id   NUMBER(8) NOT NULL,
    store_address_id   NUMBER(8) NOT NULL,
    start_DT              DATE DEFAULT(to_date('01-JAN-1900','dd-mon-yyyy')) NOT NULL,
    end_DT                DATE DEFAULT(to_date('31-DEC-9999','dd-mon-yyyy')) NOT NULL,
    is_active AS (
    CASE
      WHEN end_dt=to_date('31-DEC-9999','dd-mon-yyyy')
      THEN 'Y'
      ELSE 'N'
    END) ,
    insert_dt          DATE DEFAULT ( SYSDATE ) NOT NULL
);