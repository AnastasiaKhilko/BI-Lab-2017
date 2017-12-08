
CREATE OR REPLACE PROCEDURE load_to_wrk(ext_table IN varchar2, wrk_table IN varchar2)
     IS
  begin
     EXECUTE IMMEDIATE 'truncate table ' || wrk_table;
     EXECUTE IMMEDIATE 'insert into ' ||wrk_table|| ' select * from '||ext_table;
  commit;

END;
