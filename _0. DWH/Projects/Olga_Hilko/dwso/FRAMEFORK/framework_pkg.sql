--PKG_UTL.TRUNC_TAB
--PKG_UTL.get_row_count
CREATE OR REPLACE PACKAGE PKG_UTL AUTHID CURRENT_USER as
  PROCEDURE TRUNC_TAB(table_name in VARCHAR2);--(table_name IN VARCHAR2,error_table IN VARCHAR2);
  FUNCTION  get_row_count(table_name in VARCHAR2) return number;
 --PROCEDURE WRK_TO_CL_Org ;
END PKG_UTL;
/

create or replace PACKAGE BODY PKG_UTL AS
procedure TRUNC_TAB (table_name VARCHAR2)
 is
 sql_stat varchar(400);
 before_cnt NUMBER;
 begin
     --select * from wrk_AZS;
     sql_stat:='truncate table ' || table_name;
     execute IMMEDIATE sql_stat;
     dbms_output.put_line('Lola: Table '||table_name ||' was truncated.');
 --exeption;    
 end TRUNC_TAB;
 
function get_row_count(table_name VARCHAR2) return number
 is
 sql_stat varchar(400);
 before_cnt NUMBER;
 begin
     sql_stat := 'begin SELECT COUNT(*) INTO :before_cnt FROM '|| table_name||'  ; end;'     ;
     EXECUTE IMMEDIATE sql_stat USING out before_cnt;
     return before_cnt;
 end get_row_count;
END PKG_UTL;

/*


DECLARE
   TYPE ids_t IS TABLE OF cl_AZS %ROWTYPE;

   l_ids   ids_t := ids_t (100, 200, 300);
BEGIN
   FORALL indx IN 1 .. l_ids.COUNT
   LOOP
      UPDATE plch_employees
         SET last_name = UPPER (last_name)
       WHERE employee_id = l_ids (indx);
   END LOOP;       
END;



PROCEDURE process_all_rows
IS
   TYPE employees_aat 
   IS TABLE OF employees%ROWTYPE
      INDEX BY PLS_INTEGER;
   l_employees employees_aat;
BEGIN
   SELECT *
   BULK COLLECT INTO l_employees
      FROM employees;
     
   FOR indx IN 1 .. l_employees.COUNT 
   LOOP
       analyze_compensation 
      (l_employees(indx));
   END LOOP;
END process_all_rows;




 CREATE OR REPLACE Function TotalIncome
   ( dep_id IN number ) return cursor
   IS
   total_val number(6);
   cursor c1 is (select * from HR.EMPLOYEES where DEPARTMENT_ID=dep_id);
 begin
   total_val := 0;

   FOR employee_rec in c1
   LOOP
      total_val := total_val + employee_rec.monthly_income;
   END LOOP;

   RETURN total_val;
 end;
 
 */