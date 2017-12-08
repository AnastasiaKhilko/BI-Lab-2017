create or replace procedure truncate_fact_dwh
as
begin
execute immediate 'truncate table bl_dwh.fct_orders';
end;
/

grant execute on truncate_fact_dwh to bl_cl2;