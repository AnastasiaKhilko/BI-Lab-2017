create or replace procedure grants_to_bl_cl2
is begin
FOR x IN (SELECT * FROM user_tables)
LOOP   
  EXECUTE IMMEDIATE 'GRANT INSERT ON ' || x.table_name || ' TO BL_CL2';
  EXECUTE IMMEDIATE 'GRANT UPDATE ON ' || x.table_name || ' TO BL_CL2';
  EXECUTE IMMEDIATE 'GRANT SELECT ON ' || x.table_name || ' TO BL_CL2';
END LOOP;

end;
/

exec GRANTS_TO_BL_CL2;
commit;
