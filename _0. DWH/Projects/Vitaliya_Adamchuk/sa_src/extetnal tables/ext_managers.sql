-- ext_geo_countries_iso3166.
    create table EXT_EMPLOYEES
        (
		region varchar2 ( 100 char ),
        last_name varchar2 ( 100 char )
         )
    organization external
        (TYPE ORACLE_LOADER DEFAULT DIRECTORY external_manag_tables
                         ACCESS PARAMETERS (FIELDS TERMINATED BY ',')
                         LOCATION ('managers_by_regions.csv'                              )
    )
    reject limit unlimited;
    
COMMIT;