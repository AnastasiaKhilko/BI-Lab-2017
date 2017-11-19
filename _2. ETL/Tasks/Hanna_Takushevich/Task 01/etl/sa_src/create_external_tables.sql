--==============================================================
-- Table: t_ext_geodatasource_regions
--==============================================================
CREATE TABLE ext_geo_regions (
    region_id     NUMBER(10),
    region_name   VARCHAR2(200 CHAR)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                region_id INTEGER EXTERNAL ( 10 ),
                region_name CHAR ( 200 )
            )
        ) LOCATION ( 'GEODATASOURCE-REGION.TXT' )
    ) REJECT LIMIT UNLIMITED;

--==============================================================
-- Table: t_ext_geodatasource_subregions
--==============================================================

CREATE TABLE ext_geo_subregions (
    subregion_id            VARCHAR2(2),
    subregion_name          VARCHAR2(200 CHAR),
    subregion_country_key   NUMBER(2)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                subregion_id CHAR ( 2 ),
                subregion_name CHAR ( 200 ),
                subregion_country_key INTEGER EXTERNAL ( 2 )
            )
        ) LOCATION ( 'GEODATASOURCE-SUBREGION.TXT' )
    ) REJECT LIMIT UNLIMITED;
    
--==============================================================
-- Table: t_ext_geodatasource_countries
--==============================================================

CREATE TABLE ext_geo_countries (
    cc_fips                 VARCHAR2(2),
    cc_iso                  VARCHAR2(2),
    tld                     VARCHAR2(3),
    country_name            VARCHAR2(200 CHAR),
    subregion_country_key   NUMBER(2)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                cc_fips CHAR ( 2 ),
                cc_iso CHAR ( 2 ),
                tld CHAR ( 3 ),
                country_name CHAR ( 200 ),
                subregion_country_key INTEGER EXTERNAL ( 2 )
            )
        ) LOCATION ( 'GEODATASOURCE-COUNTRY.TXT' )
    ) REJECT LIMIT UNLIMITED;
    
--==============================================================
-- Table: t_ext_geodatasource_cities
--==============================================================

CREATE TABLE ext_geo_cities (
    cc_fips     VARCHAR2(2),
    city_name   VARCHAR2(200 CHAR)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                cc_fips CHAR ( 2 ),
                city_name CHAR ( 200 )
            )
        ) LOCATION ( 'GEODATASOURCE-CITIES-FREE.TXT' )
    ) REJECT LIMIT UNLIMITED;