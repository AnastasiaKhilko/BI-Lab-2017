CREATE TABLE ce_payments
  (
    Payment_id               NUMBER(8) PRIMARY KEY,
    Payment_type_group       VARCHAR2(25) NOT NULL,
    Payment_type_description VARCHAR2(25) NOT NULL,
    Prepayment               VARCHAR2(25) NOT NULL,
    insert_DT                DATE NOT NULL,
    update_DT                DATE NOT NULL
  );
