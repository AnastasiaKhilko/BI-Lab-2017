drop table wrk_providers;
create table wrk_providers(
    provider_code varchar2(10 char),
    provider_name varchar2(100 char),
    city varchar2(50 char),
    country varchar2(50 char),
    address varchar2(200 char),
    email varchar2(100 char)
);