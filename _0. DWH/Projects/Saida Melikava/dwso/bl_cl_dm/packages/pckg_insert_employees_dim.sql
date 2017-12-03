create or replace package pckg_insert_employees_dim
as
  procedure insert_bl_cls;
  procedure insert_bl_dim;
end pckg_insert_employees_dim;
/
create or replace package body pckg_insert_employees_dim
as
procedure insert_bl_cls
is
begin
  execute immediate 'TRUNCATE TABLE bl_cl_dm.dim_cl_employees';
  insert into dim_cl_employees
  select ce.employee_id,
    ce.employee_code,
    ce.employee_surname,
    ce.employee_name,
    ce.employee_phone,
    ce.employee_email,
    ce.employee_dep_id,
    department_name,
    man.employee_surname,
    man.employee_name,
    store_name,
    city_id,
    city_desc,
    store_address_id,
    addr_street,
    addr_number_house
  from bl_3nf.ce_employees ce
  inner join bl_3nf.ce_departments dep
  on dep.department_id=ce.employee_dep_id
  inner join bl_3nf.ce_employees man
  on man.employee_id=ce.employee_id
  inner join bl_3nf.ce_stores st
  on st.store_id=ce.employee_store_id
  inner join bl_3nf.ce_addr ad
  on ad.addr_id=st.store_address_id
  inner join bl_3nf.ce_cities cit
  on ad.addr_city_id=cit.city_id
  inner join bl_3nf.ce_regions reg
  on cit.region_id=reg.region_id
  inner join bl_3nf.ce_districts dis
  on dis.district_id=reg.district_id
where ce.employee_id>0;
  dbms_output.put_line('Data in the table is successfully loaded: '||sql%rowcount|| ' rows were inserted.');
exception
when others then
  raise;
  commit;
end;
procedure insert_bl_dim
is
begin
  merge into bl_dm.dim_employees dim using
  (select employee_3nf_id,
    employee_code,
    employee_surname,
    employee_name,
    employee_phone,
    employee_email,
    employee_dep_id,
    employee_department_name,
    employee_manager_surname,
    employee_manager_name,
    employee_store_name,
    employee_store_city_id,
    employee_store_city,
    employee_store_address_id,
    employee_store_address_street,
    employee_store_address_house
  from dim_cl_employees
  minus
  select employee_3nf_id,
    employee_code,
    employee_surname,
    employee_name,
    employee_phone,
    employee_email,
    employee_dep_id,
    employee_department_name,
    employee_manager_surname,
    employee_manager_name,
    employee_store_name,
    employee_store_city_id,
    employee_store_city,
    employee_store_address_id,
    employee_store_address_street,
    employee_store_address_house
  from bl_dm.dim_employees
  ) cls on ( cls.employee_3nf_id = dim.employee_3nf_id )
when matched then
  update
  set dim.employee_surname           =cls.employee_surname,
    dim.employee_name                = cls.employee_name,
    dim.employee_phone               = cls.employee_phone,
    dim.employee_email               =cls.employee_email,
    dim.employee_dep_id              = cls.employee_dep_id,
    dim.employee_department_name     =cls.employee_department_name,
    dim.employee_manager_surname     = cls.employee_manager_surname,
    dim.employee_manager_name        =cls.employee_manager_name,
    dim.employee_store_name          =cls.employee_store_name,
    dim.employee_store_city_id       = cls.employee_store_city_id,
    dim.employee_store_city          =cls.employee_store_city,
    dim.employee_store_address_id    = cls.employee_store_address_id,
    dim.employee_store_address_street= cls.employee_store_address_street,
    dim.employee_store_address_house =cls.employee_store_address_house,
    dim.update_dt                    =trunc(sysdate) when not matched then
  insert
    (
      employee_sur_id,
      employee_3nf_id,
      employee_code,
      employee_surname,
      employee_name,
      employee_phone,
      employee_email,
      employee_dep_id,
      employee_department_name,
      employee_manager_surname,
      employee_manager_name,
      employee_store_name,
      employee_store_city_id,
      employee_store_city,
      employee_store_address_id,
      employee_store_address_street,
      employee_store_address_house
    )
    values
    (
      seq_emp_dim.nextval,
      cls.employee_3nf_id,
      cls.employee_code,
      cls.employee_surname,
      cls.employee_name,
      cls.employee_phone,
      cls.employee_email,
      cls.employee_dep_id,
      cls.employee_department_name,
      cls.employee_manager_surname,
      cls.employee_manager_name,
      cls.employee_store_name,
      cls.employee_store_city_id,
      cls.employee_store_city,
      cls.employee_store_address_id,
      cls.employee_store_address_street,
      cls.employee_store_address_house
    ) ;
  dbms_output.put_line('Data in the tables is successfully merged: '||sql%rowcount|| ' rows were inserted.');
exception
when others then
  raise;
  commit;
end;
end pckg_insert_employees_dim;
/
