select sale_code, sale_date, fct.product_id, 
 customer_id, store_id, employee_id, quantity, pr.price as unit_cost, (pr.price * quantity) as cost, (pr.discount * quantity) as discount_sum, ((pr.price * quantity)-(pr.discount * quantity)) as total_cost
from CLS_FCT_SALES fct
join BL_3NF.CE_PRODUCTS pr on fct.product_id = pr.product_id;

select * from CLS_FCT_SALES;

select * from WRK_FCT_SALES;