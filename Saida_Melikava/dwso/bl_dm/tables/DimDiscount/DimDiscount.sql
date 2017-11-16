CREATE TABLE DimDiscount_SCD
  (
    Discount_key               NUMBER(8) PRIMARY KEY,
    Discount_id                VARCHAR2(25) NOT NULL,
    Discount_description       VARCHAR2(250) NOT NULL,
    Discount_terms_description VARCHAR2(250) NOT NULL,
    Start_DT                    DATE NOT NULL,
    End_DT                     DATE NOT NULL,
    Current_flag               VARCHAR2(10) NOT NULL
  );