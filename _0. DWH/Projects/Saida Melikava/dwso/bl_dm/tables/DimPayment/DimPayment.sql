CREATE TABLE DimPayment
  (
    Payment_key              NUMBER(8) PRIMARY KEY,
    Payment_type_group       VARCHAR2(50) NOT NULL,
    Payment_type_description VARCHAR2(50) NOT NULL,
    Prepayment               VARCHAR2(10) NOT NULL
  );
