create or replace procedure do_truncate
as
begin
    execute immediate 'truncate table bl_3nf.ce_orders';
end;