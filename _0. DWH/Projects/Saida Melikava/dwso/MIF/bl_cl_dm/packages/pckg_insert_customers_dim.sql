create or replace package pckg_insert_customers_dim
as
  procedure insert_bl_cls;
  procedure insert_bl_dim;
end pckg_insert_customers_dim;
/
create or replace package body pckg_insert_customers_dim
as
procedure insert_bl_cls
is
  begin
EXECUTE IMMEDIATE 'TRUNCATE TABLE bl_cl_dm.dim_cl_customers';
  insert
  into dim_cl_customers
  select customer_id,
    customer_code,
    customer_name,
    customer_surname,
    customer_email,
    customer_phone,
    customer_card,
    dis.district_id,
    district_desc,
    reg.region_id,
    region_desc,
    customer_city_id,
    city_desc
  from bl_3nf.ce_customers ce
  inner join bl_3nf.ce_cities cit
  on ce.customer_city_id=cit.city_id
  inner join bl_3nf.ce_regions reg
  on cit.region_id=reg.region_id
  inner join bl_3nf.ce_districts dis
  on dis.district_id=reg.district_id
where customer_id>0;
  dbms_output.put_line('Data in the table is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  exception
  when others then raise;
  commit;
end;
procedure insert_bl_dim
is
  begin
  merge into bl_dm.dim_customers dim using
(select 
  customer_3nf_id,
  customer_code,
  customer_name,
  customer_surname,
  customer_email,
  customer_phone,
  customer_card,
  customer_district_id,
  customer_district,
  customer_region_id,
  customer_region,
  customer_city_id,
  customer_city
from dim_cl_customers
minus
select 
  customer_3nf_id,
  customer_code,
  customer_name,
  customer_surname,
  customer_email,
  customer_phone,
  customer_card,
  customer_district_id,
  customer_district,
  customer_region_id,
  customer_region,
  customer_city_id,
  customer_city
from bl_dm.dim_customers
) cls on ( cls.customer_3nf_id = dim.customer_3nf_id )
when matched then
  update 
  set 
    dim.customer_name     =cls.customer_name,
    dim.customer_surname    =cls.customer_surname,
    dim.customer_email      = cls.customer_email,
    dim.customer_phone      =cls.customer_phone,
    dim.customer_card       = cls.customer_card,
    dim.customer_district_id=cls.customer_district_id,
    dim.customer_district   =cls.customer_district,
    dim.customer_region_id  =cls.customer_region_id,
    dim.customer_region     =cls.customer_region,
    dim.customer_city_id    =cls.customer_city_id,
    dim.customer_city       =cls.customer_city,
    dim.update_dt           =trunc(sysdate) 
    when not matched then
  insert 
    (
      customer_sur_id,
      customer_3nf_id,
      customer_code,
      customer_name,
      customer_surname,
      customer_email,
      customer_phone,
      customer_card,
      customer_district_id,
      customer_district,
      customer_region_id,
      customer_region,
      customer_city_id,
      customer_city
    )
    values
    (
      seq_cust_dim.nextval,
      cls.customer_3nf_id,
      cls.customer_code,
      cls.customer_name,
      cls.customer_surname,
      cls.customer_email,
      cls.customer_phone,
      cls.customer_card,
      cls.customer_district_id,
      cls.customer_district,
      cls.customer_region_id,
      cls.customer_region,
      cls.customer_city_id,
      cls.customer_city
      );
  dbms_output.put_line('Data in the tables is successfully merged: '||SQL%ROWCOUNT|| ' rows were inserted.');
  exception
  when others then raise;
  commit;
  end;
  
end pckg_insert_customers_dim;
/