CREATE OR REPLACE PACKAGE pkg_etl_insert_employees
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_employees;
						
END pkg_etl_insert_employees;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_employees
AS
---------------------------------------------------  
PROCEDURE insert_table_employees
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_employees');
  INSERT INTO cls_employees (
                              employee_id,
                              first_name,
                              last_name,
                              store_srcid,
                              position_name,
                              position_grade_id,
                              work_experience,
                              email,
                              phone
                            )
  SELECT employee_code AS employee_id,
         first_name,
         last_name,
         store_srcid,
         position_name,
         position_grade_srcid,
         work_experience,
         email,
         phone
  FROM wrk_employees;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_employees;
---------------------------------------------------  
END pkg_etl_insert_employees;