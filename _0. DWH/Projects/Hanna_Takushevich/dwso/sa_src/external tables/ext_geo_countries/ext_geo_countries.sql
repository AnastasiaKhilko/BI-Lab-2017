--==============================================================
-- Table: t_ext_geodatasource_countries
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ext_geo_countries', Object_Type=>'TABLE');

CREATE TABLE ext_geo_countries
  (
    cc_fips               VARCHAR2(4),
    cc_iso                VARCHAR2(4),
    tld                   VARCHAR2(5),
    country_name          VARCHAR2(200),
    subregion_country_key VARCHAR2(4)
  )
  ORGANIZATION EXTERNAL( TYPE oracle_loader 
    DEFAULT DIRECTORY ext_references ACCESS PARAMETERS ( 
      RECORDS DELIMITED BY NEWLINE 
        NOBADFILE 
        NODISCARDFILE 
        NOLOGFILE 
      FIELDS TERMINATED BY ' ' MISSING FIELD VALUES ARE NULL ( 
        cc_fips CHAR ( 4 ), 
        cc_iso CHAR ( 4 ), 
        tld CHAR ( 5 ), 
        country_name CHAR ( 200 ), 
        subregion_country_key CHAR ( 4 ) 
      ) 
    ) LOCATION ( 'GEODATASOURCE-COUNTRY.TXT' )
  )REJECT LIMIT UNLIMITED;