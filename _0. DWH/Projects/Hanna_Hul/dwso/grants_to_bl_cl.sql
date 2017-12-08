create or replace procedure grants_to_bl_cl
is begin
FOR x IN (SELECT * FROM user_tables)
LOOP   
 EXECUTE IMMEDIATE 'GRANT SELECT ON ' || x.table_name || ' TO BL_CL'; 
 EXECUTE IMMEDIATE 'GRANT ALL ON ' || x.table_name || ' TO BL_CL';
END LOOP;

end;
/
exec GRANTS_TO_BL_CL;
commit;

