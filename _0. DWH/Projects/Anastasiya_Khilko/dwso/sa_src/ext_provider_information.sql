create table ext_provider_information(
    guid varchar2(100 char),
    email varchar2(10 char),
    zipcode varchar2(5 char),
    address varchar2(10 char),
    city varchar2 (50 char)
)
organization external 
    ( type oracle_loader
      default directory ext_dir
      access parameters
      ( records delimited by 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are null 
                (guid,
                 email,
                 zipcode,
                 address,
                 city
                  )
                 )
      location
       ( 'provider.csv'
       )
    )
   reject limit unlimited ;
   
select * from ext_provider_information;
drop table ext_provider_information;