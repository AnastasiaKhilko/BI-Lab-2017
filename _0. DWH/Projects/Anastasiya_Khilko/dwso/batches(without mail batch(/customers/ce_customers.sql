drop table ce_customers;
create table ce_customers
   (customer_id number(10),
    code varchar2(25 char),
    last_name varchar2(100 char),
    first_name varchar2(100 char),
    age varchar2(10 char),
    email varchar2 (100 char),
    phone varchar2 (50 char),
    address_id varchar2(10 char),
    start_dt date,
    end_dt date,
    isActive varchar2(5 char)
   ) ;