-- WRK_EMPLOYEES.
DROP TABLE WRK_EMPLOYEES;

CREATE TABLE WRK_EMPLOYEES
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
         );
