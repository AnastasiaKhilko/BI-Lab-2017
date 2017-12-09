-- EXT_STORES.
    DROP TABLE ext_manufacturers;
    CREATE TABLE ext_manufacturers
  (
    manufacturer_code VARCHAR2 ( 200 CHAR ),
    manufacturer_name VARCHAR2 ( 200 BYTE ),
    phone      VARCHAR2 ( 200 BYTE ),
    address    VARCHAR2 ( 200 BYTE ),
    city       VARCHAR2 ( 200 BYTE ),
    country_id VARCHAR2 ( 200 BYTE ),
    insert_dt  DATE
  )
    ORGANIZATION EXTERNAL
        (TYPE oracle_loader DEFAULT DIRECTORY ext_sources
                            ACCESS PARAMETERS (fields terminated BY ',')
                            LOCATION ('manufacturers.csv')
    )
    REJECT LIMIT UNLIMITED;