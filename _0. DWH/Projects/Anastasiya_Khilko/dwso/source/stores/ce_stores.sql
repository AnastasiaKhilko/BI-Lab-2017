drop table ce_stores;
create table ce_stores
   (store_id number(10),
    store_code varchar2(10 char),
    store_name varchar2(20 char),
    address_id varchar2(15 char),
    email varchar2(150 char),
    phone varchar2(10 char),
    insert_dt date,
    update_dt date
   ) ;