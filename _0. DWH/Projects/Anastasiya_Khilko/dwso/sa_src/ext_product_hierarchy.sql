create table ext_product_hierarchy(
    product varchar2(350 char),
    category_name varchar2(100 char),
    category_code varchar2(10 char),
    subcategory_name varchar2(100 char),
    subcategory_code varchar2 (50 char)
)
organization external 
    ( type oracle_loader
      default directory ext_tables
      access parameters
      ( records delimited by 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are null 
                (product,
                 category_name,
                 category_code,
                 subcategory_name,
                 subcategory_code
                  )
                 )
      location
       ( 'hierarchy.csv'
       )
    )
   reject limit unlimited ;
   
select * from ext_product_hierarchy;
drop table ext_product_hierarchy;