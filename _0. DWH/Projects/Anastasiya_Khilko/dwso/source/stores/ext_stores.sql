drop table ext_stores;
create table ext_stores(
    store_code varchar2(10 char),
    store_name varchar2(50 char),
    address_id varchar2(15 char),
    email varchar2(150 char),
    phone varchar2(10 char)
)
organization external 
    ( type oracle_loader
      default directory source_table
      access parameters
      ( records delimited by 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are null 
                (store_code,
                 store_name,
                 address_id,
                 email,
                 phone
                  )
                 )
      location
       ( 'stores.csv'
       )
    )
   reject limit unlimited ;
   
--select * from ext_stores;
