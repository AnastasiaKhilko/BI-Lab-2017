drop table ext_addresses;
create table ext_addresses(
    postal_code varchar2(15 char),
    address varchar2(150 char),
    city varchar2(50 char),
    country varchar2(10 char)
)
organization external 
    ( type oracle_loader
      default directory ext_tables
      access parameters
      ( records delimited by 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are null 
                (postal_code,
                 address,
                 city,
                 country
                  )
                 )
      location
       ( 'addresses.csv'
       )
    )
   reject limit unlimited ;
   
select * from ext_addresses;
