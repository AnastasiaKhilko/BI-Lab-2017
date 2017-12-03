DROP TABLE ce_payments CASCADE CONSTRAINTS;
CREATE TABLE ce_payments
  (
    Payment_id               NUMBER(8) PRIMARY KEY,
    Payment_code             NUMBER(8),
    Payment_type_group       VARCHAR2(250) NOT NULL,
    Payment_type_description VARCHAR2(250) NOT NULL,
    Prepayment               VARCHAR2(250) NOT NULL,
    insert_DT                DATE DEFAULT(sysdate) NOT NULL ,
    update_DT                DATE DEFAULT(sysdate) NOT NULL
  ); 