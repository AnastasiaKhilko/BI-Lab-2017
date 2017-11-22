-- ext_geo_countries_iso3166.
    create table EXT_CUSTOMERS
        (passport_number varchar2 ( 200 char ),
         first_name varchar2 ( 200 char ),
         last_name varchar2 ( 200 char ),
         gender varchar2 ( 200 char ),
         age number ( 38 ),
         email varchar2 ( 200 char ),
         phone varchar2 ( 200 char ),
         address varchar2 ( 200 char ),
         city varchar2 ( 200 char ),
         country_code varchar2 ( 200 char ),
         country varchar2 ( 200 char ),
         is_active varchar2 ( 200 char )
         )
    organization external
        (TYPE ORACLE_LOADER DEFAULT DIRECTORY external_cust_tables
                         ACCESS PARAMETERS (FIELDS TERMINATED BY ',')
                         LOCATION ('customers_1.csv',  'customers_2.csv',
                                   'customers_3.csv',  'customers_4.csv',
                                   'customers_5.csv',  'customers_6.csv',
                                   'customers_7.csv',  'customers_8.csv',
                                   'customers_9.csv',  'customers_10.csv',
                                   'customers_11.csv', 'customers_12.csv',
                                   'customers_13.csv', 'customers_14.csv',
                                   'customers_15.csv', 'customers_16.csv',
                                   'customers_17.csv', 'customers_18.csv',
                                   'customers_19.csv', 'customers_20.csv',
                                   'customers_21.csv', 'customers_22.csv',
                                   'customers_23.csv', 'customers_24.csv',
                                   'customers_25.csv', 'customers_26.csv',
                                   'customers_27.csv', 'customers_28.csv',
                                   'customers_29.csv', 'customers_30.csv',
                                   'customers_31.csv', 'customers_32.csv',
                                   'customers_33.csv', 'customers_34.csv',
                                   'customers_35.csv', 'customers_36.csv',
                                   'customers_37.csv', 'customers_38.csv',
                                   'customers_39.csv', 'customers_40.csv',
                                   'customers_41.csv', 'customers_42.csv',
                                   'customers_43.csv', 'customers_44.csv',
                                   'customers_45.csv', 'customers_46.csv',
                                   'customers_47.csv', 'customers_48.csv',
                                   'customers_49.csv', 'customers_50.csv'
                                  )
    )
    reject limit unlimited;