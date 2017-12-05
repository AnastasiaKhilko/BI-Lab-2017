EXPLAIN PLAN FOR
SELECT CASE
    WHEN GROUPING_id(dis.district_desc,g.genre_name)=2
    THEN 'Total by all Stores'
    WHEN GROUPING_id(dis.district_desc,g.genre_name)=3
    THEN 'GRAND TOTAL'
    ELSE dis.district_desc
  END AS district_desc,
  CASE
    WHEN GROUPING_id(dis.district_desc,g.genre_name)=1
    THEN 'Total by all Products'
    WHEN GROUPING_id(dis.district_desc,g.genre_name)=3
    THEN ' '
    ELSE g.genre_name
  END           AS genre_name,
  SUM(fct_sales_amount_byn)    AS price,
  SUM(fct_quantity) AS quantity
FROM ce_fct_sales f
INNER JOIN ce_stores s
ON f.fct_store_id=s.store_id
INNER JOIN ce_addr ad
ON ad.addr_city_id=s.store_address_id
INNER JOIN ce_cities cit
ON cit.city_id=ad.addr_city_id
INNER JOIN ce_regions reg
ON reg.region_id=cit.region_id
INNER JOIN ce_districts dis
ON dis.district_id=reg.district_id
INNER JOIN ce_catalog p
ON f.fct_product_id=p.prod_id
INNER JOIN ce_genres g
on g.genre_id=p.prod_genre_id
GROUP BY cube(district_desc, genre_name);
SELECT * FROM TABLE(dbms_xplan.display);
select count(*) from ce_fct_sales;