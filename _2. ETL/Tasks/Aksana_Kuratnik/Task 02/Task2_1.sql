SELECT concat(p.first_name,' '
  ||p.last_name)                                   AS seller,
  extract(YEAR FROM fct.order_dt)                  AS YEAR ,
  TO_CHAR(SUM(fct.sum_of_payment),'9,999,999,999') AS Sales
FROM bl_3nf.ce_sellers p,
  cls_orders fct
WHERE p.seller_id = fct.seller_id
GROUP BY CUBE(concat(p.first_name,' '
  ||p.last_name), extract(YEAR FROM fct.order_dt))
ORDER BY concat(p.first_name,' '
  ||p.last_name) NULLS LAST;