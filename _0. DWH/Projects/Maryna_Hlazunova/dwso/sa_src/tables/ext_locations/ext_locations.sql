/**===============================================*\
Name...............:   External table ext_locations SA_SRC layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   24-Nov-2017
\*=============================================== */
DROP TABLE ext_locations;
--**********************************************
   CREATE TABLE ext_locations
        ( loc_code VARCHAR2 (6 CHAR),
         location_type VARCHAR2 (5 CHAR),
         location_name   VARCHAR2 (100 CHAR),
         dis_code VARCHAR2 (4 CHAR),
         district VARCHAR2 (100 CHAR),
         reg_code VARCHAR2 (3 CHAR),
         region VARCHAR2 (100 CHAR)
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_sources_dwh
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL 
                (loc_code,
                 location_type,
                 location_name,
                 dis_code,
                 district,
                 reg_code,
                 region)
             )
         LOCATION ('wb_locations.txt')
    )
    reject LIMIT unlimited;
--**********************************************    
--select * from ext_locations;