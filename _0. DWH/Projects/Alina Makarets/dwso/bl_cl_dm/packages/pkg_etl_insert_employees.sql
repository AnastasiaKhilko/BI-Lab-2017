CREATE OR REPLACE PACKAGE pkg_etl_insert_employees
AUTHID CURRENT_USER
AS
    PROCEDURE insert_table_employees;
    PROCEDURE merge_table_dim_employees;    
END pkg_etl_insert_employees;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_employees
AS
----------------------------------------------------
    PROCEDURE insert_table_employees
    IS 
        BEGIN
            EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_dim_employees');
            INSERT INTO cls_dim_employees
                       SELECT DISTINCT employee_surr_id as employee_id,
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
                    FROM ce_employees;

            COMMIT;
            EXCEPTION
                WHEN OTHERS 
            THEN RAISE;  
    END insert_table_employees;
----------------------------------------------------
PROCEDURE merge_table_dim_employees
    IS 
        BEGIN
        MERGE INTO dim_employees t USING
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
              FROM cls_dim_employees
              MINUS
              SELECT employee_surr_id,
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
              FROM dim_employees  
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
                    (  employee_id, 
                       employee_surr_id,
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
                   (dim_employees_seq.nextval,
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
        

    END merge_table_dim_employees;
----------------------------------------------------
END pkg_etl_insert_employees;