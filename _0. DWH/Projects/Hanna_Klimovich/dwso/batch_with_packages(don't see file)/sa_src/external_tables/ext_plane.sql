--==============================================================
-- Table: ext_plane
--==============================================================
--select * from ext_plane;
--drop table ext_plane;
execute pckg_drop.DROP_Proc('ext_plane','TABLE');
    CREATE TABLE ext_plane
        (
         AC_TYPEID	NUMBER,
         SSD_NAME	VARCHAR2 ( 200 CHAR ),
         MANUFACTURER	VARCHAR2 ( 200 CHAR ),
         LONG_NAME	VARCHAR2 ( 200 CHAR ),
         SHORT_NAME	VARCHAR2 ( 200 CHAR ),
         BEGIN_DATE	VARCHAR2 ( 200 CHAR ),
         END_DATE VARCHAR2 ( 200 CHAR )
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY external_plane_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are NULL 
                (
                 AC_TYPEID	integer external,
                 SSD_NAME	char(200),
                 MANUFACTURER	char(200),
                 LONG_NAME	char(200),
                 SHORT_NAME	char(200),
                 BEGIN_DATE	char(200),
                 END_DATE char(200)
                 )
             )
         LOCATION ('plane.csv')
    )
    reject LIMIT unlimited;
