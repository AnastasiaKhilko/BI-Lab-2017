drop table ext_employees;
create table ext_employees(
    emp_code varchar2(10 char),
    last_name varchar2(100 char),
    first_name varchar2(50 char),
    addr_id varchar2(50 char),
    email varchar2(200 char),
    phone varchar2(100 char),
    manager_code varchar2(10 char),
    store_code varchar2(10 char)
)
organization external 
    ( type oracle_loader
      default directory source_table
      access parameters
      ( records delimited by 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are null 
                (emp_code,
                 last_name,
                 first_name,
                 addr_id,
                 email,
                 phone,
                 manager_code,
                 store_code
                  )
                 )
      location
       ( 'employees.csv'
       )
    )
   reject limit unlimited ;
   
select * from ext_employees;
