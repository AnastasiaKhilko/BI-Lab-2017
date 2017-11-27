CREATE OR REPLACE PACKAGE pkg_etl_insert_employees
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_employees;
  PROCEDURE merge_table_employees;
  
END pkg_etl_insert_employees;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_employees
AS
---------------------------------------------------  
PROCEDURE insert_table_employees
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_employees_scd');
  INSERT INTO cls_employees_scd
SELECT DISTINCT
      employee_srcid AS employee_surr_id,
      employee_number AS employee_id,
      first_name,
      last_name,
      store_number,
      position_name,
      position_grade_desc AS position_grade,
      ce.work_experience,
      email,
      phone,
      start_dt,
      end_dt,
      is_active
FROM  bl_3nf.ce_employees ce left join bl_3nf.ce_position_grades pg
                                     on ce.position_grade_srcid = pg.position_grade_srcid;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_employees;
---------------------------------------------------  
PROCEDURE merge_table_employees
IS
BEGIN
  MERGE INTO bl_dm.dim_employees_scd t USING
    ( SELECT *
      FROM   cls_employees_scd
    MINUS
      SELECT *          
      FROM   bl_dm.dim_employees_scd
    ) c ON ( c.employee_surr_id = t.employee_surr_id )
    WHEN matched THEN
    UPDATE SET t.employee_id = c.employee_id,
               t.first_name = c.first_name,
               t.last_name = c.last_name,
               t.store_number = c.store_number,
               t.position_name = c.position_name,
               t.position_grade = c.position_grade,
               t.work_experience = c.work_experience,
               t.email = c.email,
               t.phone = c.phone,
               t.start_dt = c.start_dt,
               t.end_dt = c.end_dt,
               t.is_active = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
       employee_surr_id,
       employee_id,
       first_name,
       last_name,
       store_number,
       position_name,
       position_grade,
       work_experience,
       email,
       phone,
       start_dt,
       end_dt,
       is_active
      )
      VALUES
      (
       c.employee_surr_id,
       c.employee_id,
       c.first_name,
       c.last_name,
       c.store_number,
       c.position_name,
       c.position_grade,
       c.work_experience,
       c.email,
       c.phone,
       c.start_dt,
       c.end_dt,
       c.is_active
      ) ;
    COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END merge_table_employees;
---------------------------------------------------
END pkg_etl_insert_employees;