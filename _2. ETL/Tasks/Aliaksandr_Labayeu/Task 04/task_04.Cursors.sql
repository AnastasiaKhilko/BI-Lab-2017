-----------------------------
-- CURSORS
-- Implicit

BEGIN
FOR cat IN (
  SELECT seq_product_category.nextval AS prod_category_id, prod_category FROM (
  SELECT prod_category 
  FROM wrk_products 
  WHERE PROD_category IS NOT NULL
  GROUP BY prod_category))
LOOP 
  INSERT INTO cls_product_category (
    CATEGORY_id,
    CATEGORY_NAME)
  VALUES (
    cat.prod_category_id,
    cat.prod_category);
  END LOOP;
END;
/

--SELECT * FROM cls_product_category;

-- Explicit
   DECLARE
    cursor subcat is select unique subcategory from ext_products;
    sc varchar2(20);

    BEGIN
      open subcat;
      LOOP
        FETCH subcat into sc;
        exit when subcat %notfound;
        insert into cls_PRODUCT_SUBCATEGORY (
                        SUBCATEGORY_ID,
                        SUBCATEGORY_NAME,
                        CATEGORY_ID)
                  SELECT seq_product_subcategory.nextval, subcategory, category_id FROM (
                        SELECT DISTINCT subcategory, category_id
                        FROM ext_products e_p
                        LEFT JOIN cls_product_category c_pc ON e_p.prod_category = c_pc.category_name
                        WHERE subcategory IS NOT NULL
                        );
      END LOOP;
      close subcat;
      commit;
    END;
/

-- SELECT * FROM cls_product_subcategory;
-------------------------------------------------
