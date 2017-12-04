drop table ce_products;
create table ce_products
   (product_id number(8) PRIMARY KEY,
    product_code varchar2(30 char),
    product_desc varchar2(250 char),
    subcategory_id number(3),
    start_dt DATE,
    end_dt  DATE,
    isActive varchar2(3 char)
   ) ;