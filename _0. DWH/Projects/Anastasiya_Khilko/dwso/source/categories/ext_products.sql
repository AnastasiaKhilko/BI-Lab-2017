drop table ext_products;
create table ext_products
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
   ) 
   organization external 
    ( type oracle_loader
      default directory source_table
      access parameters
      ( records delimited by 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are null 
                (product,
                 category_name,
                 category_code,
                 subcategory_name,
                 subcategory_code,
                 vendor_code,
                 code,
                 main_provider,
                 manufacturer,
                 tax,
                 country_provider,
                 discount,
                 price
                 )
                 )
      location
       ( 'src_products.csv'
       )
    )
   reject limit unlimited ;

select * from ext_products;
