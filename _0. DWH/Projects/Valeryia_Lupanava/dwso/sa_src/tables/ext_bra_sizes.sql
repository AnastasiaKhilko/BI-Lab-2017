-- EXT_BRA_SIZES.
CREATE TABLE ext_bra_sizes
  (
    bra_size_code NUMBER(10 ),
    bra_size_uk   VARCHAR2 ( 200 CHAR ),
    bra_size_usa  VARCHAR2 ( 200 CHAR ),
    bra_size_eu   VARCHAR2 ( 200 CHAR ),
    bra_size_fr   VARCHAR2 ( 200 CHAR ),
    bra_size_uie  VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    TYPE oracle_loader 
    DEFAULT DIRECTORY external_ext_tables 
    ACCESS PARAMETERS (fields terminated BY ',') 
    LOCATION ('bra_size_grid.csv')
  )
  REJECT LIMIT UNLIMITED;