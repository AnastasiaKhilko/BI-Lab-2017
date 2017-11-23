create TABLE dim_payment_methods
        (
      payment_method_id     NUMBER(10) NOT NULL,
      payment_method_name   VARCHAR2(20 BYTE) NOT NULL,
      bank_name             VARCHAR2(40 BYTE),
      credit_card_name NUMBER(8));