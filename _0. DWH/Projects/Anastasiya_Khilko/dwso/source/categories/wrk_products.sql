drop table wrk_products;
create table wrk_products
   (product varchar2(250 char), 
	category_name varchar2(250 char),
    category_code varchar2(20 char),
    subcategory_name varchar2(250 char),
    subcategory_code varchar2(20 char),
    vendor_code varchar2(20 char),
    code varchar2(20 char),
    main_provider varchar2(100 char),
    manufacturer varchar2(100 char),
    tax varchar2(20 char),
    country_provider varchar2(100 char),
    discount varchar2(20 char),
    price varchar2(20 char)
   ) ;