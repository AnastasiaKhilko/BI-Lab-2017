DROP TABLE ce_payment_type;
CREATE TABLE ce_payment_type
  (
    Payment_type_group       VARCHAR2(50) NOT NULL,
    Payment_type_description VARCHAR2(50) NOT NULL,
    Payment_code VARCHAR2(8) NOT NULL,
    CONSTRAINT fk_paytype_payment FOREIGN KEY (Payment_code) REFERENCES ce_payment(Payment_code)
  );