/**===============================================*\
Name...............:   External table ext_pickuppoints SA_SRC layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
--==============================================================
DROP TABLE ext_pickuppoints;
--**********************************************
   CREATE TABLE ext_pickuppoints
        (nat_code VARCHAR2 (3 CHAR),
         address   VARCHAR2 (300 CHAR)
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_sources_dwh
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL 
                (nat_code,
                 address)
             )
         LOCATION ('wb_pickuppoints.txt')
    )
    reject LIMIT unlimited;
--**********************************************     
-- select * from ext_pickuppoints;