drop table ext_providers;
create table ext_providers(
    provider_code varchar2(10 char),
    provider_name varchar2(100 char),
    city varchar2(50 char),
    country varchar2(50 char),
    address varchar2(200 char),
    email varchar2(100 char)
)
organization external 
    ( type oracle_loader
      default directory source_table
      access parameters
      ( records delimited by 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are null 
                (provider_code,
                 provider_name,
                 city,
                 country,
                 address,
                 email
                  )
                 )
      location
       ( 'providers.csv'
       )
    )
   reject limit unlimited ;
   
--select * from ext_providers;
