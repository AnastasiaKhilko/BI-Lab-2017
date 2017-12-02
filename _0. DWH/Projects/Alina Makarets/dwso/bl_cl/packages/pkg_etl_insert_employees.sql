CREATE OR REPLACE PACKAGE pkg_etl_insert_employees
AUTHID CURRENT_USER
AS
    PROCEDURE insert_table_employees;
    PROCEDURE merge_table_ce_employees;    
END pkg_etl_insert_employees;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_employees
AS
----------------------------------------------------
PROCEDURE insert_table_employees
        IS
    CURSOR emp_cursor
    IS
    SELECT TO_NUMBER(employee_code) as employee_id,
       first_name,
       last_name,
       middle_name,
       phone,
       email,
       age,
       CASE
        WHEN substr (middle_name,-1) = 'à' 
          THEN 'Æ'
        ELSE 'Ì'
          END AS gender,
        passport_code || passport_letter as passport,
        NVL(to_date(start_date, 'DD-MM-YYYY'),'01-ßÍÂ-1990') as start_dt,
        NVL(to_date(end_date, 'DD-MM-YYYY'),'31-ÄÅÊ-9999') as end_dt,
        CASE 
            WHEN active = 1
                THEN 'Y'
            WHEN active = 0
                THEN 'N' 
            END as is_active        
    FROM wrk_employees
    WHERE first_name IS NOT NULL
    AND last_name IS NOT NULL
    AND middle_name IS NOT NULL
    AND email IS NOT NULL;    
    rt_emp_cursor cls_employees%rowtype;
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_employees';
        
        OPEN emp_cursor;
          LOOP
            FETCH emp_cursor INTO rt_emp_cursor;
            IF emp_cursor%found THEN
              INSERT INTO cls_employees 
              (
                       employee_id,
                       last_name,
                       first_name,
                       middle_name,
                       phone,
                       email,
                       age,
                       gender,
                       passport,
                       start_dt,
                       end_dt,
                       is_active
              )
              VALUES 
              (
                       rt_emp_cursor.employee_id,
                       rt_emp_cursor.last_name,
                       rt_emp_cursor.first_name,
                       rt_emp_cursor.middle_name,
                       rt_emp_cursor.phone,
                       rt_emp_cursor.email,
                       rt_emp_cursor.age,
                       rt_emp_cursor.gender,
                       rt_emp_cursor.passport,
                       rt_emp_cursor.start_dt,
                       rt_emp_cursor.end_dt,
                       rt_emp_cursor.is_active
              )
              ;
            END IF;
            EXIT WHEN emp_cursor%notfound;
          END LOOP;
          COMMIT;
          CLOSE emp_cursor;
        COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END insert_table_employees;
----------------------------------------------------
PROCEDURE merge_table_ce_employees
IS
    BEGIN
        MERGE INTO ce_employees t USING
            ( SELECT employee_id,
                    last_name,
                    first_name,
                    middle_name,
                    phone,
                    email,
                    age,
                    gender,
                    passport,
                    start_dt,
                    end_dt,
                    is_active
              FROM cls_employees
              MINUS
              SELECT employee_id ,
                   last_name,
                   first_name,
                   middle_name,
                   phone,
                   email,
                   age,
                   gender,
                   passport,
                   start_dt,
                   end_dt,
                   is_active
            FROM ce_employees bl 
              ) c
              ON ( c.employee_id=t.employee_id )
              WHEN matched THEN
              UPDATE SET 
                         t.last_name=c.last_name,
                         t.first_name=c.first_name,
                         t.middle_name=c.middle_name,
                         t.phone=c.phone,
                         t.email=c.email,
                         t.age=c.age,
                         t.gender=c.gender,
                         t.passport=c.passport,
                         t.start_dt=c.start_dt,
                         t.end_dt=c.end_dt,
                         t.is_active=c.is_active
              WHEN NOT matched THEN
              INSERT 
                    (  employee_surr_id, 
                       employee_id,
                       last_name,
                       first_name,
                       middle_name,
                       phone,
                       email,
                       age,
                       gender,
                       passport,
                       start_dt,
                       end_dt,
                       is_active)
             VALUES 
                   (ce_employees_seq.nextval,
                    c.employee_id,
                    c.last_name,
                    c.first_name,
                    c.middle_name,
                    c.phone,
                    c.email,
                    c.age,
                    c.gender,
                    c.passport,
                    c.start_dt,
                    c.end_dt,
                    c.is_active) ;
            COMMIT ;
             EXCEPTION
                WHEN OTHERS 
                     THEN RAISE;
END merge_table_ce_employees;
----------------------------------------------------
END pkg_etl_insert_employees;