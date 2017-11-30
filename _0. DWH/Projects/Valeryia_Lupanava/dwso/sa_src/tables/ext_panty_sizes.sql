-- EXT_PANTY_SIZES.
    CREATE TABLE ext_panty_sizes
        (
         panty_size_code NUMBER(20 ),
         panty_size_uk   VARCHAR2 ( 200 CHAR ),
         panty_size_usa  VARCHAR2 ( 200 CHAR ),
         panty_size_eu   VARCHAR2 ( 200 CHAR ),
         panty_size_fr   VARCHAR2 ( 200 CHAR ),
         panty_size_uie  VARCHAR2 ( 200 CHAR )
         )
    ORGANIZATION EXTERNAL
        (TYPE oracle_loader DEFAULT DIRECTORY external_ext_tables
                            ACCESS PARAMETERS (fields terminated BY ',')
                            LOCATION ('panties_size_grid.csv')
    )
    REJECT LIMIT UNLIMITED;