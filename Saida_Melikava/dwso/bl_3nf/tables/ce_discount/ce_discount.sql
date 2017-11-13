CREATE TABLE ce_discount
  (
    Discount_id                VARCHAR2(25) PRIMARY KEY,
    Discount_description       VARCHAR2(250) NOT NULL,
    Discount_terms_description VARCHAR2(250) NOT NULL,
    Discount_begin_date        DATE NOT NULL,
    Discount_end_date          DATE NOT NULL
  );
