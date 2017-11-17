CREATE TABLE ce_discount
  (
    Discount_id                VARCHAR2(25) PRIMARY KEY,
    Discount_description       VARCHAR2(250) NOT NULL,
    Discount_terms_description VARCHAR2(250) NOT NULL,
    Discount_change_id VARCHAR2(8),
    CONSTRAINT fk_disk_change FOREIGN KEY (Discount_change_id) REFERENCES ce_Discount_change(discount_change_id)
  );
