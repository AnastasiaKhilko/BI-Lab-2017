--CLS_PRODUCT_INFO_INSERT
TRUNCATE TABLE cls_product_info;
INSERT INTO cls_product_info (
                                   product_info_id,
                                   product_id,
                                   price,
                                   raiting,
                                   balance,
                                   insert_dt,
                                   update_dt
                                 )
  SELECT concat(substr(product_id,1,4),' Info') AS product_info_id, 
         product_id,
         raiting,
         price,
         balance,
         SYSDATE AS insert_dt,
         SYSDATE AS update_dt
  FROM   wrk_products;

  COMMIT;