-- 3NF
explain plan for 
SELECT EXTRACT(YEAR FROM ORDER_DATE),
  sum(quantity),
  SUM(price * quantity) AS fct_item_sum,
  SUM(price * quantity * discount / 100) AS fct_discount_sum,
  SUM(price * quantity - price * quantity * discount / 100) AS fct_total_sum
FROM CE_FCT_ITEMS fct
join CE_FCT_ORDERS fcto
on fct.ORDER_ID=fcto.ORDER_ID
JOIN CE_PRODUCTS p
ON fct.PRODUCT_ID=p.PROD_ID
JOIN CE_TYPES t
ON p.TYPE_ID    =t.TYPE_ID
WHERE t.TYPE_name ='Валенки'
and p.IS_ACTIVE='Y'
group by EXTRACT(YEAR FROM ORDER_DATE)
order by 1;

select * from table(dbms_xplan.display);



-- Star

explain plan for
SELECT 
 EXTRACT(YEAR FROM DIM_ORDER_DATE),
  sum(FCT_QUANTITY),
  sum(FCT_ITEM_SUM),
  sum(FCT_DISCOUNT_SUM),
  sum(FCT_TOTAL_SUM)
FROM BL_DWH.FCT_SALESITEMS fs join DIM_PRODUCTS_SCD dp
on fs.DIM_PRODUCT_SURRID=dp.PRODUCT_SURRID
where dp.IS_ACTIVE='Y'
and dp.PRODUCT_TYPE ='Валенки'
group by EXTRACT(YEAR FROM DIM_ORDER_DATE)
order by 1;

select * from table(dbms_xplan.display);