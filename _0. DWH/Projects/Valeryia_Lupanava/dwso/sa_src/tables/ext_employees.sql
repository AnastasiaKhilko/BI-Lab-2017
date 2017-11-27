-- EXT_EMPLOYEES.
    CREATE TABLE ext_employees
        (employee_code        VARCHAR2 ( 100 CHAR ),
         first_name           VARCHAR2 ( 100 CHAR ),
         last_name            VARCHAR2 ( 100 CHAR ),
         age                  NUMBER ( 38 ),
         store_srcid          VARCHAR2 ( 100 CHAR ),
         position_name        VARCHAR2 ( 100 CHAR ),
         position_grade_srcid VARCHAR2 ( 100 CHAR ),
         work_experience      NUMBER ( 38 ),
         email                VARCHAR2 ( 100 CHAR ),
         phone                VARCHAR2 ( 100 CHAR ),
         personal_address     VARCHAR2 ( 100 CHAR ),
         currency             VARCHAR2 ( 100 CHAR ),
         currency_code        VARCHAR2 ( 100 CHAR ),
         month_salary         NUMBER ( 38,3 ),
         credit_card          NUMBER ( 38 ),
         start_date           DATE,
         end_date             VARCHAR2 ( 100 CHAR ),
         is_active            VARCHAR2 ( 100 CHAR )
         )
    ORGANIZATION EXTERNAL
        (TYPE oracle_loader DEFAULT DIRECTORY external_emp_tables
                            ACCESS PARAMETERS (fields terminated BY ',')
                            LOCATION 
                                  ('employees_1.csv',  'employees_2.csv',
                                   'employees_3.csv',  'employees_4.csv',
                                   'employees_5.csv',  'employees_6.csv',
                                   'employees_7.csv',  'employees_8.csv',
                                   'employees_9.csv',  'employees_10.csv',
                                   'employees_11.csv', 'employees_12.csv',
                                   'employees_13.csv', 'employees_14.csv',
                                   'employees_15.csv', 'employees_16.csv',
                                   'employees_17.csv', 'employees_18.csv',
                                   'employees_19.csv', 'employees_20.csv'
                                  )
    )
    REJECT LIMIT UNLIMITED;
    
COMMIT;