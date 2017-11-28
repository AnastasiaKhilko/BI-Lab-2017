--drop table ext_products;
create table ext_products(
    product varchar2(80 char),
    vendor_code varchar2(10 char),
    code varchar2(5 char),
    group_code varchar2(10 char),
    main_provider varchar2 (50 char),
    manufacturer varchar2(50 char),
    tax varchar2(5 char),
    country_provider varchar2(50 char),
    discount varchar2(5 char),
    price varchar2(10 char)
)
organization external 
    ( type oracle_loader
      default directory ext_dir
      access parameters
      ( records delimited by 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are null 
                (product,
                 vendor_code,
                 code,
                 group_code,
                 main_provider,
                 manufacturer,
                 tax,
                 country_provider,
                 discount,
                 price)
                 )
      location
       ( 'products.csv'
       )
    )
   reject limit unlimited ;
   
--select * from ext_products;
