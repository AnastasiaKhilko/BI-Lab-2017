/*drop table wrk_products1;
create table wrk_products1
   (product_code varchar2(30 char),
    product_desc varchar2(250 char),
    subcategory_id number(2)
    --main_provider varchar2(50 char)
   ) ;*/

drop table wrk_products1;
create table wrk_products1
   (product_code varchar2(30 char),
    product_desc varchar2(400 char),
    subcategory_id number(2),
    main_provider varchar2(200 char),
    country_provider varchar2(200 char),
    discount varchar2(20 char),
    price varchar2(20 char)

    /*discount varchar2(10 char),
    price varchar2(10 char)*/
   ) ;