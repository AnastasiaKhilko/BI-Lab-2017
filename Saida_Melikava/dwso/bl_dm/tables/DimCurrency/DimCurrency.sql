CREATE TABLE DimCurrency
  (
    Currency_key       NUMBER(8) PRIMARY KEY,
    Currency_id        VARCHAR2(10) NOT NULL,
    Currency_full_name VARCHAR2(50) NOT NULL
  );
