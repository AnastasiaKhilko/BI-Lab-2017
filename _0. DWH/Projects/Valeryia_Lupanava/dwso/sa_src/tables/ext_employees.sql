-- ext_geo_countries_iso3166.
    create table EXT_EMPLOYEES
        (employee_code varchar2 ( 100 char ),
         first_name varchar2 ( 100 char ),
         last_name varchar2 ( 100 char ),
         age number ( 38 ),
         store_srcid varchar2 ( 100 char ),
         position_name varchar2 ( 100 char ),
         position_grade_srcid varchar2 ( 100 char ),
         work_experience number ( 38 ),
         email varchar2 ( 100 char ),
         phone varchar2 ( 100 char ),
         personal_address varchar2 ( 100 char ),
         currency varchar2 ( 100 char ),
         currency_code varchar2 ( 100 char ),
         month_salary number ( 38,3 ),
         credit_card number ( 38 ),
         start_date date,
         end_date varchar2 ( 100 char ),
         is_active varchar2 ( 100 char )
         )
    organization external
        (TYPE ORACLE_LOADER DEFAULT DIRECTORY external_emp_tables
                         ACCESS PARAMETERS (FIELDS TERMINATED BY ',')
                         LOCATION ('employees_1.csv',  'employees_2.csv',
                                   'employees_3.csv',  'employees_4.csv',
                                   'employees_5.csv',  'employees_6.csv',
                                   'employees_7.csv',  'employees_8.csv',
                                   'employees_9.csv',  'employees_10.csv',
                                   'employees_11.csv', 'employees_12.csv',
                                   'employees_13.csv', 'employees_14.csv',
                                   'employees_15.csv', 'employees_16.csv',
                                   'employees_17.csv', 'employees_18.csv',
                                   'employees_19.csv', 'employees_20.csv',
                                   'employees_21.csv', 'employees_22.csv',
                                   'employees_23.csv', 'employees_24.csv',
                                   'employees_25.csv', 'employees_26.csv',
                                   'employees_27.csv', 'employees_28.csv',
                                   'employees_29.csv', 'employees_30.csv',
                                   'employees_31.csv', 'employees_32.csv',
                                   'employees_33.csv', 'employees_34.csv',
                                   'employees_35.csv', 'employees_36.csv',
                                   'employees_37.csv', 'employees_38.csv',
                                   'employees_39.csv', 'employees_40.csv',
                                   'employees_41.csv', 'employees_42.csv',
                                   'employees_43.csv', 'employees_44.csv',
                                   'employees_45.csv', 'employees_46.csv',
                                   'employees_47.csv', 'employees_48.csv',
                                   'employees_49.csv', 'employees_50.csv'
                                  )
    )
    reject limit unlimited;
    
COMMIT;