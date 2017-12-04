drop table cls_products;
create table cls_products
   (product_code varchar2(30 char),
    product_desc varchar2(250 char),
    subcategory_id number(2),
    start_dt date,
    end_dt date,
    isactive varchar2(3 char)
    --main_provider varchar2(50 char)
   ) ;