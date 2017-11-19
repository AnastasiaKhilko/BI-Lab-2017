CREATE TABLE ce_product_audio
  (
    Audio_id           VARCHAR2(25) PRIMARY KEY,
    Audio_category_id        VARCHAR2(8) NOT NULL,
    Audio_description  VARCHAR2(500) NOT NULL,
    Audio_name         VARCHAR2(150) NOT NULL,
    Audio_genre        VARCHAR2(65) NOT NULL,
    Audio_weight_mb  NUMBER(8,3) NOT NULL,
    Audio_durability NUMBER(4) NOT NULL,
    Audio_reader     VARCHAR2(70) NOT NULL,
    insert_DT          DATE NOT NULL,
    update_DT          DATE NOT NULL,
    CONSTRAINT fk_audio_cat FOREIGN KEY (Audio_category_id) REFERENCES ce_categories(Category_id)
  );
