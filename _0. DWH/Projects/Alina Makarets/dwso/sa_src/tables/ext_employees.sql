-- EXT_EMPLOYEES.
DROP TABLE EXT_EMPLOYEES;

CREATE TABLE EXT_EMPLOYEES
        (employee_code        NUMBER   ( 30 ),
         first_name           VARCHAR2 ( 200 CHAR ),
         last_name            VARCHAR2 ( 200 CHAR ),
         middle_name          VARCHAR2 ( 200 CHAR ),
         phone                VARCHAR2 ( 200 CHAR ),
         email                VARCHAR2 ( 200 CHAR ),
         age                  NUMBER   ( 38 ),
         passport_code        VARCHAR2 ( 100 CHAR ),
         active               NUMBER   ( 10 ),
         start_date           VARCHAR2 ( 100 CHAR ),
         end_date             VARCHAR2 ( 100 CHAR ),
         passport_letter      VARCHAR2 ( 100 CHAR )
         )
    ORGANIZATION EXTERNAL
        (TYPE oracle_loader DEFAULT DIRECTORY external_employees_tables
                            ACCESS PARAMETERS (fields terminated BY ';')
                            LOCATION 
                                  ('employees.csv'
                                  )
    )
    REJECT LIMIT UNLIMITED;
    
