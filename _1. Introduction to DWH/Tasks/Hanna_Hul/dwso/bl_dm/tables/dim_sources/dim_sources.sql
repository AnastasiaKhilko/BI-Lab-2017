CREATE TABLE dim_sources(
source_id number primary key,
source_name varchar2(10),
source_desc varchar2(10),
source_tax number,
update_dt date
);