CREATE MATERIALIZED VIEW large_prod REFRESH ON DEMAND 
AS 
  SELECT product_id, product_code, product_category, product_subcategory, product_name, item_size
  FROM dim_PRODUCTS
  WHERE ITEM_SIZE >4;

SELECT * FROM large_prod;

UPDATE DIM_products 
SET PRODUCT_NAME = 'Mini DV'
WHERE PRODUCT_CODE = 88866;

SELECT * FROM DIM_products WHERE product_code = 88866;
SELECT * FROM large_prod WHERE product_code = 88866;

execute DBMS_MVIEW.REFRESH('large_prod');
SELECT * FROM large_prod WHERE product_code = 88866;

------------------------------------------------------
-- ON COMMIT
------------------------------------------------------
CREATE MATERIALIZED VIEW small_prod REFRESH ON COMMIT 
AS 
  SELECT product_id, product_code, product_category, product_subcategory, product_name, item_size
  FROM dim_PRODUCTS
  WHERE ITEM_SIZE <2;

SELECT * FROM small_prod;

UPDATE DIM_products 
SET PRODUCT_NAME = 'Player'
WHERE PRODUCT_CODE = 385;
COMMIT;

