--explain plan for
alter session enable parallel dml;
commit;
select hotel_id,
       c.name,     
       age
from fct_orders f left join dim_customers c
on f.customer_id = c.customer_dwh_id
where f.customer_id > 1000;

alter session enable parallel ddl;
commit;
select --+ parallel(f, 4)
       f.hotel_id,
       c.name,     
       c.age
from bl_dwh.fct_orders f left join bl_dwh.dim_customers c
on f.customer_id = c.customer_dwh_id
where f.customer_id > 1000;
-------------------------------------
EXPLAIN PLAN FOR
UPDATE /*+ PARALLEL(c) */
bl_dwh.fct_orders c
set c.customer_id = -99
where c.hotel_id = 1;

select * from table (dbms_xplan.display);
rollback;