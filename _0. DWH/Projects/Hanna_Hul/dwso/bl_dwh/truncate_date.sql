create or replace procedure do_truncate
as
begin
execute immediate 'truncate table bl_dwh.dim_date';
end;
/

grant execute on do_truncate to bl_cl2;