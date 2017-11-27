CREATE TABLE ce_all_books
  (
    Book_id      NUMBER(8) PRIMARY KEY,
    All_books_id NUMBER(8) NOT NULL,
    category_id  VARCHAR2(8) NOT NULL,
    insert_DT    DATE NOT NULL,
    update_DT    DATE NOT NULL,
    CONSTRAINT fk_book_cat FOREIGN KEY(category_id) REFERENCES ce_categories(category_id)
  );