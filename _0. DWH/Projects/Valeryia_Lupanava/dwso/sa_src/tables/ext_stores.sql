-- EXT_STORES.
    CREATE TABLE ext_stores
  (
    store_code VARCHAR2 ( 200 CHAR ),
    store_name VARCHAR2 ( 200 BYTE ),
    manager_id VARCHAR2 ( 200 BYTE ),
    phone      VARCHAR2 ( 200 BYTE ),
    address    VARCHAR2 ( 200 BYTE ),
    city       VARCHAR2 ( 200 BYTE ),
    country_id VARCHAR2 ( 200 BYTE )
  )
    ORGANIZATION EXTERNAL
        (TYPE oracle_loader DEFAULT DIRECTORY external_ext_tables
                            ACCESS PARAMETERS (fields terminated BY ',')
                            LOCATION ('stores.csv')
    )
    REJECT LIMIT UNLIMITED;