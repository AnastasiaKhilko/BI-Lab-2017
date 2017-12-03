--==============================================================
-- Table: ext_state
--==============================================================
--select * from ext_state;
--drop table ext_state;
execute pckg_drop.DROP_Proc('ext_state','TABLE');
    CREATE TABLE ext_state
        (
         state_num	NUMBER,
         DEST_STATE_NM VARCHAR2 ( 200 CHAR ),
         country_num NUMBER

         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY external_geo_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are NULL 
                (
                state_num	integer external,
                 DEST_STATE_NM char(200),
                 country_num integer external
                 )
             )
         LOCATION ('states.csv')
    )
    reject LIMIT unlimited;
