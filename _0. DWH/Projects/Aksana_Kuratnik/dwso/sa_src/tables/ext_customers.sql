-- EXT_CUSTOMERS.
DROP TABLE ext_customers;
    CREATE TABLE ext_customers
        (
         CC_number VARCHAR2 (250),
         first_name      VARCHAR2 (250),
         last_name       VARCHAR2 (250),
         gender          VARCHAR2 (100),
         age             NUMBER (38),
         email           VARCHAR2 (250),
         phone           VARCHAR2 (250),
         address         VARCHAR2 (250),
         city            VARCHAR2 (250),
         country_id      VARCHAR2 (250),
         start_dt        DATE,
         end_dt          DATE,
         is_active       VARCHAR2 (50)
         )
    ORGANIZATION EXTERNAL
        (TYPE oracle_loader DEFAULT DIRECTORY ext_sources
                            ACCESS PARAMETERS (fields terminated BY ',')
                            LOCATION ('customers.csv')
    )
    REJECT LIMIT UNLIMITED;
    