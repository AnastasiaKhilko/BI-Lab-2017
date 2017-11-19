CREATE TABLE ce_discounts
  (
    Discount_code              VARCHAR2(25) PRIMARY KEY,
    Discount_description       VARCHAR2(250) NOT NULL,
    Discount_terms_description VARCHAR2(250) NOT NULL,
    start_DT                   DATE NOT NULL,
    end_DT                     DATE NOT NULL,
    is_active                  VARCHAR2(4) NOT NULL,
    insert_DT                  DATE NOT NULL
  );
