create or replace PACKAGE pkg_etl_insert_banks
AUTHID CURRENT_USER
AS
  PROCEDURE insert_banks;
  --PROCEDURE merge_table_ce_customers;
						
END pkg_etl_insert_banks;
/
create or replace PACKAGE BODY pkg_etl_insert_banks
AS
---------------------------------------------------  
 PROCEDURE insert_banks
   IS
begin
 DECLARE
cursor bank_cur is SELECT * from sa_src.ext_banks;

  -- rec_bank   ext_banks%ROWTYPE;
begin
FOR rec
   IN bank_cur
   LOOP
      select * into wrk_banks(bank_id, bank_name)from rec;
      --select * from wrk_banks;
   END LOOP;

--end;
END; 
  --EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_cards');
  
  --COMMIT;
  
EXCEPTION

  WHEN OTHERS THEN 
  RAISE;

END insert_banks;
end pkg_etl_insert_banks;