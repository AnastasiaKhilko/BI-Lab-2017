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
    
         select count(*) from   ext_geo_cities
--==============================================================
-- Table: t_ext_airlines
--==============================================================

CREATE TABLE ext_airlines (
    airline_name varchar2(60),
    icao_iata_codes     VARCHAR2(8),
    airline_country   VARCHAR2(60 CHAR)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                 airline_name CHAR(60),
                icao_iata_codes     CHAR ( 8 ),
                airline_country   CHAR ( 60 )
            )
        ) LOCATION ( 'airlines.txt' )
    ) REJECT LIMIT UNLIMITED;   
    
    
--==============================================================
-- Table: t_ext_airports
--==============================================================    

CREATE TABLE ext_airports (
    airport_name varchar2(150),
    airport_city     VARCHAR2(50),
    airport_country varchar2(50),
    airport_iata varchar2(3),
    airport_icao varchar2(4),
    airport_faa varchar2(5)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                airport_name CHAR ( 150 ),
                airport_city     CHAR ( 50 ),
                airport_country CHAR ( 50 ),
                airport_iata CHAR ( 3 ),
                airport_icao CHAR ( 4 ),
                airport_faa CHAR ( 5 )
            )
        ) LOCATION ( 'airports.txt' )
    ) REJECT LIMIT UNLIMITED;     
    
    
--==============================================================
-- Table: t_ext_aircrafts
--==============================================================    

CREATE TABLE ext_aircrafts (
    aircraft_type varchar2(50),
    aircraft_country     VARCHAR2(50),
    engines_num number,
    first_flight_year number(4),
    entry_year number(4),
    end_prod varchar2(20),
    amount varchar2(30),
    amount_in_service varchar2(20)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                aircraft_type CHAR(50),
                aircraft_country     CHAR(50),
                engines_num INTEGER EXTERNAL,
                first_flight_year INTEGER EXTERNAL(4),
                entry_year INTEGER EXTERNAL (4),
                end_prod CHAR(20),
                amount CHAR(30),
                amount_in_service CHAR(20)
            )
        ) LOCATION ( 'aircrafts.txt' )
    ) REJECT LIMIT UNLIMITED;     
    
    
--==============================================================
-- Table: t_ext_passengers
--==============================================================    

CREATE TABLE ext_passengers (
    num_pass varchar2(10),
    give_name     VARCHAR2(100),
    middle_name VARCHAR2(30),
    last_name VARCHAR2(100),
    city varchar2(100),
    country_abbr varchar2(6),
    email varchar2(150),
    phone varchar2(50),
    birthday varchar2(30)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL (
                num_pass CHAR(10),
                give_name     CHAR(100),
                middle_name CHAR(30),
                last_name CHAR(100),
                city CHAR(100),
                country_abbr CHAR(6),
                email CHAR(150),
                phone CHAR(50),
                birthday CHAR(30)
            )
        ) LOCATION ( 'FakeName1.csv', 'FakeName1.csv' )
    ) REJECT LIMIT UNLIMITED;   

--==============================================================
-- Table: t_ext_serv_classes
--==============================================================    

CREATE TABLE ext_serv_classes (
    class_name     VARCHAR2(20),
    seat_letter VARCHAR2(1),
    menu VARCHAR2(50),
    max_luggage varchar2(3),
    class_desc varchar2(100)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                class_name     CHAR(20),
                seat_letter CHAR(1),
                menu CHAR(50),
                max_luggage CHAR(3),
                class_desc CHAR(100)
            )
        ) LOCATION ( 'serv_classes.txt' )
    ) REJECT LIMIT UNLIMITED;  