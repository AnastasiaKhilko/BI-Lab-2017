drop table ce_product_subcategories;
create table ce_product_subcategories
   (subcategory_id number(2),
    subcategory_code varchar2(30 char),
    subcategory_desc varchar2(250 char),
    category_id number(3),
    insert_dt   DATE,
    update_dt   DATE
   ) ;