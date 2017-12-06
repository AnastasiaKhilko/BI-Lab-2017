select 
    pr.product_id,
    pr.product_desc,
    sub.subcategory_id,
    sub.subcategory_desc,
    cat.category_id,
    cat.category_desc
from
    ce_products pr,
    CE_PRODUCT_SUBCATEGORIES sub,
    CE_PRODUCT_CATEGORIES cat
where pr.subcategory_id = sub.subcategory_id and sub.category_id = cat.category_id
and subcategory_code = '00000001131';

create materialized view pr1131
    refresh
        fast
        on commit
 as
    select 
    pr.product_id,
    pr.product_desc,
    sub.subcategory_id,
    sub.subcategory_desc,
    cat.category_id,
    cat.category_desc
from
    ce_products pr,
    CE_PRODUCT_SUBCATEGORIES sub,
    CE_PRODUCT_CATEGORIES cat
where pr.subcategory_id = sub.subcategory_id and sub.category_id = cat.category_id
and subcategory_code = '00000001131';

select * from pr1131;