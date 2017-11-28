CREATE TABLE ce_product_printed
  (
    Printed_id          VARCHAR2(25) PRIMARY KEY,
    Printed_category_id VARCHAR2(8) NOT NULL,
    Printed_description VARCHAR2(500) NOT NULL,
    Printed_name        VARCHAR2(150) NOT NULL,
    Printed_genre       VARCHAR2(65) NOT NULL,
    Printed_weight_kg   NUMBER(3,3) NOT NULL,
    insert_DT           DATE NOT NULL,
    update_DT           DATE NOT NULL,
    CONSTRAINT fk_prin_cat FOREIGN KEY (Printed_category_id) REFERENCES ce_categories(Category_id)
  );
