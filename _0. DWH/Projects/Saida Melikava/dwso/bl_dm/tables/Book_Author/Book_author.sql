DROP TABLE Book_Author;
CREATE TABLE Book_Author
  (
    Book_author_id NUMBER(8) PRIMARY KEY,
    Product_id     NUMBER(8) NOT NULL,
    Author_id      NUMBER(8) NOT NULL,
    IsAuthor       VARCHAR2(10) NOT NULL,
    insert_DT      DATE NOT NULL,
    update_DT      DATE NOT NULL,
    CONSTRAINT fk_prod_id FOREIGN KEY (product_id) REFERENCES dim_products (product_id),
    CONSTRAINT fk_auth_id FOREIGN KEY (author_id) REFERENCES dim_authors (author_id)
  );
COMMENT ON TABLE Book_Author
IS
  'Table Content: Table is intender as interim table between books and authors. .   
Refresh Cycle/Window: Data is loaded rarely and for a long period of time.  
';
  COMMENT ON column Book_Author.Book_author_id
IS
  'Table surrogate key';
  COMMENT ON column Book_Author.Product_id
IS
  'FK ON Dim_Products';
  COMMENT ON column Book_Author.Author_id
IS
  'FK ON Dim_Authors';
  COMMENT ON column Book_Author.IsAuthor
IS
  'Indicates whether the book was written BY one author OR many.';
  COMMENT ON column Book_Author.Insert_DT
IS
  'WHEN data was loaded';
  COMMENT ON column Book_Author.Update_DT
IS
  ' 
WHEN data was updated';
