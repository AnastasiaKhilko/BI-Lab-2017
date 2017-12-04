drop table cls_employees;
create table cls_employees(
    emp_code varchar2(10 char),
    last_name varchar2(100 char),
    first_name varchar2(50 char),
    addr_id varchar2(50 char),
    email varchar2(200 char),
    phone varchar2(100 char),
    manager_code varchar2(10 char),
    store_code varchar2(10 char),
    insert_dt date,
    update_dt date
);