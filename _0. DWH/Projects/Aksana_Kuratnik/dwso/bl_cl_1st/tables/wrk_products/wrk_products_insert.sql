--INSERT TO WRK_PRODUCTS.
TRUNCATE TABLE WRK_PRODUCTS;
INSERT INTO WRK_PRODUCTS
SELECT * FROM SA_SRC.EXT_PRODUCTS;
commit;