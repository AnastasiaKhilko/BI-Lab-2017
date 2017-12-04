drop table ext_customers;
create table ext_customers(
    code varchar2(100 char),
    first_name varchar2(10 char),
    last_name varchar2(5 char),
    age varchar2(10 char),
    email varchar2 (50 char),
    phone varchar2 (50 char),
    address_id varchar2(50 char)
)
organization external 
    ( type oracle_loader
      default directory source_table
      access parameters
      ( records delimited by 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are null 
                (code,
                 first_name,
                 last_name,
                 age,
                 email,
                 phone,
                 address_id
                  )
                 )
      location
       ( 'customers.csv'
       )
    )
   reject limit unlimited ;
   
--select * from ext_customers;
