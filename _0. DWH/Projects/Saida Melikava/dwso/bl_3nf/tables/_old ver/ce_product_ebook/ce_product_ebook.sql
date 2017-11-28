CREATE TABLE ce_product_ebook
  (
    Ebook_id          VARCHAR2(25) PRIMARY KEY,
    Ebook_category_id VARCHAR2(8) NOT NULL,
    Ebook_description VARCHAR2(500) NOT NULL,
    Ebook_name        VARCHAR2(150) NOT NULL,
    Ebook_genre       VARCHAR2(65) NOT NULL,
    Ebook_weight_mb   NUMBER(8,3) NOT NULL,
    Ebook_durability  NUMBER(4) NOT NULL,
    Ebook_reader      VARCHAR2(70) NOT NULL,
    insert_DT         DATE NOT NULL,
    update_DT         DATE NOT NULL,
    CONSTRAINT fk_ebook_cat FOREIGN KEY (Ebook_category_id) REFERENCES ce_categories(Category_id)
  );
