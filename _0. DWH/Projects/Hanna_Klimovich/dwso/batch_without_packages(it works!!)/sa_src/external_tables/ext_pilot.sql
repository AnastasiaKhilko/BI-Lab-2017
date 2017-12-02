--==============================================================
-- Table: ext_pilot
--==============================================================
--select * from ext_pilot;
--drop table ext_pilot;
 execute pckg_drop.DROP_Proc('ext_pilot','TABLE');
   CREATE TABLE ext_pilot
        (
         Pilot_Id	NUMBER,
         National_ID	VARCHAR2 ( 200 CHAR ),
         Name	VARCHAR2 ( 200 CHAR ),
         Surname	VARCHAR2 ( 200 CHAR ),
         Gender	VARCHAR2 ( 200 CHAR ),
         Age	NUMBER,
         City	VARCHAR2 ( 200 CHAR ),
         Country	VARCHAR2 ( 200 CHAR ),
         Hours_in_air NUMBER,
         begin_date varchar2 (200 char),
         end_date varchar2 (200 char)
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY external_pilot_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are NULL 
                (
                Pilot_Id integer external,
                National_ID		char(200),
                Name		char(200),
                Surname		char(200),
                Gender		char(200),
                Age	integer external,
                City		char(200),
                Country		char(200),
                Hours_in_air integer external,
                begin_date char(200),
                end_date char(200)
                 )
             )
         LOCATION ('pilot.csv')
    )
    reject LIMIT unlimited;
