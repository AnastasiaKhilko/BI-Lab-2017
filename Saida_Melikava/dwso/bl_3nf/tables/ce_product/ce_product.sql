CREATE TABLE ce_product
  (
    Product_id          VARCHAR2(25) PRIMARY KEY,
    Category_id         VARCHAR2(8) NOT NULL,
    Product_description VARCHAR2(250) NOT NULL,
    Product_genre_id    NUMBER(8)NOT NULL,
    Product_genre       VARCHAR2(65) NOT NULL,
    Product_name        VARCHAR2(150) NOT NULL,
    Product_author      VARCHAR2(65) NOT NULL,
    Product_weight      NUMBER(3,3) NOT NULL,
    Product_weight_MB   NUMBER(5,3) NOT NULL,
    Product_symb_num    NUMBER(8) NOT NULL,
    Product_durability  NUMBER(8) NOT NULL,
    Product_reader      VARCHAR2(65) NOT NULL,
    CONSTRAINT fk_prod_cat FOREIGN KEY ( Category_id) REFERENCES ce_category(Category_id),
    CONSTRAINT fk_prod_genre FOREIGN KEY ( Product_genre_id) REFERENCES ce_genre(genre_id)
  );
