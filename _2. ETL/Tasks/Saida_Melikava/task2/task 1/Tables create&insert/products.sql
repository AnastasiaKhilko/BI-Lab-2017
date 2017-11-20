CREATE TABLE products
  (
    product_id   NUMBER(8) NOT NULL,
    product_name VARCHAR2(25) NOT NULL,
    category_id  NUMBER(2) NOT NULL
  );
CREATE SEQUENCE seq_products INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  INSERT INTO products
  SELECT seq_products.nextval,
    product,
    category_id
  FROM
    (SELECT dbms_random.string ( 'L', 20) AS product,
      dbms_random.value(
      (SELECT MIN(category_id) FROM category
      ),
      (SELECT MAX(category_id) FROM category
      )) AS category_id
    FROM
      ( SELECT level n FROM dual CONNECT BY level <= 5
      )
    );
  COMMIT;
  SELECT * FROM products;
