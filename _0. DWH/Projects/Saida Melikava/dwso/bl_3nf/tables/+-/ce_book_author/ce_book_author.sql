CREATE TABLE ce_book_author
  (
    Book_author_id NUMBER(8) PRIMARY KEY,
    Book_id        NUMBER(8) NOT NULL,
    Author_code    VARCHAR2(25) NOT NULL,
    IsAuthor       VARCHAR2(10) NOT NULL,
    insert_DT      DATE NOT NULL,
    update_DT      DATE NOT NULL,
    --CONSTRAINT fk_book_id FOREIGN KEY (product_id) REFERENCES dim_products (product_id),
    CONSTRAINT fk_auth_id FOREIGN KEY (author_code) REFERENCES ce_authors (author_code)
  );