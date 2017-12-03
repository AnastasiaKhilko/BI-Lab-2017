-------------------------------------------------
--ext_banks;
-------------------------------------------------
DROP TABLE ext_banks;
CREATE TABLE ext_banks
  (
    bank_id          VARCHAR2 ( 200 CHAR ),
    Institution_Name VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    TYPE ORACLE_LOADER DEFAULT DIRECTORY ext_source ACCESS PARAMETERS 
    (RECORDS DELIMITED BY 0x'0D0A' 
    skip 1 nobadfile nodiscardfile nologfile 
    fields terminated BY '\t' 
    missing field VALUES are NULL 
    ( bank_id, Institution_Name ) 
    ) LOCATION ('banks.txt')
  )
  reject LIMIT unlimited;
--SELECT * FROM ext_banks;
    
--grants
GRANT SELECT ON ext_banks TO BL_CL;
--commit;
-------------------------------------------------
--ext_customers;
-------------------------------------------------
DROP TABLE ext_customers;
CREATE TABLE ext_customers
  (
    Number_id     VARCHAR2 (250 CHAR),
    Gender        VARCHAR2 (250 CHAR),
    NameSet       VARCHAR2 (250 CHAR),
    Title         VARCHAR2 (250 CHAR),
    GivenName     VARCHAR2 (250 CHAR),
    Surname       VARCHAR2 (250 CHAR),
    StreetAddress VARCHAR2 (250 CHAR),
    City          VARCHAR2 (250 CHAR),
    State         VARCHAR2 (250 CHAR),
    StateFull     VARCHAR2 (250 CHAR),
    ZipCode       VARCHAR2 (250 CHAR),
    Country       VARCHAR2 (250 CHAR),
    CountryFull   VARCHAR2 (250 CHAR),
    EmailAddress  VARCHAR2 (250 CHAR),
    Username      VARCHAR2 (250 CHAR),
    Password_id   VARCHAR2 (250 CHAR),
    --BrowserUserAgent  VARCHAR2 (250 CHAR),
    TelephoneNumber      VARCHAR2 (250 CHAR),
    TelephoneCountryCode VARCHAR2 (250 CHAR),
    Birthday             VARCHAR2 (250 CHAR),
    Age                  VARCHAR2 (250 CHAR),
    CCType               VARCHAR2 (250 CHAR),
    CVV2                 VARCHAR2 (250 CHAR),
    CCNumber             VARCHAR2 (250 CHAR),
    CCExpires            VARCHAR2 (250 CHAR),
    --WesternUnionMTCN VARCHAR2 (250 CHAR),
    --MoneyGramMTCN VARCHAR2 (250 CHAR),
    Occupation VARCHAR2 (250 CHAR),
    Company    VARCHAR2 (250 CHAR)
  )
  ORGANIZATION EXTERNAL
  (
    TYPE oracle_loader DEFAULT DIRECTORY ext_source ACCESS PARAMETERS (RECORDS DELIMITED BY newline skip 1 nobadfile nodiscardfile nologfile fields terminated BY ',' missing field VALUES are NULL ) LOCATION ('cust1.csv'
    -- ,'cust2.csv'
    )
  )
  REJECT LIMIT UNLIMITED;
    
--select number_id from ext_customers where cctype not in ('Visa','MasterCard');

--select distinct cctype from ext_customers;

--commit;
--grants
GRANT SELECT ON ext_customers TO BL_CL;

-------------------------------------------------
--ext_hotels;
-------------------------------------------------
DROP TABLE ext_hotels;
   CREATE TABLE ext_hotels
        (
         address  VARCHAR2 (100 ),
         --categories VARCHAR2 ( 200),
         city VARCHAR2 ( 200  ),
         country	 VARCHAR2 ( 200  ),
         latitude VARCHAR2 ( 200  ),
         longitude VARCHAR2 ( 200  ),
         name_ VARCHAR2 ( 200  ),
         postalCode VARCHAR2 ( 200 ),
         province VARCHAR2 ( 200  ),
         reviews_date	 VARCHAR2 ( 200 CHAR ),
         reviews_rating VARCHAR2 ( 200 CHAR )
 
         )
    ORGANIZATION EXTERNAL
        (TYPE oracle_loader DEFAULT DIRECTORY ext_source
                   ACCESS PARAMETERS          (RECORDS DELIMITED BY newline
         skip 1
         nobadfile nodiscardfile nologfile fields terminated by ','
         missing field values are null
         )
         LOCATION ('hotel.csv')
    )
    reject LIMIT unlimited;
    
    select * from ext_hotels;
--grants
GRANT SELECT ON ext_hotels TO BL_CL;

--==============================================================

DROP TABLE ext_sources;
   CREATE TABLE ext_sources
        (
         Rank  VARCHAR2 ( 30 CHAR ),
         Site VARCHAR2 ( 30 CHAR ),
         visits VARCHAR2 ( 30 CHAR ),
         Time_online VARCHAR2 ( 30 CHAR ),
         Page_Views VARCHAR2 ( 30 CHAR ),
         Leading_Country VARCHAR2 ( 30 CHAR )
        )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_source
         
         ACCESS PARAMETERS
            ( 
              --skip 1
            --nobadfile
            --nodiscardfile nologfile
             fields terminated by ',' optionally enclosed by '"'
             missing field values are NULL
             
             )
         LOCATION ('sources.csv')
    )
    reject LIMIT unlimited;
    
    select * from ext_sources;
--grants
commit;
GRANT SELECT ON ext_sources TO BL_CL;


 select* from sa_src.ext_categories;  
DROP TABLE ext_locations;
create table ext_locations
      (country_name           VARCHAR2(100),
       country_code2          VARCHAR2(10),
       country_code3       VARCHAR2(10),
       country_code1 NUMBER(3),
       region       VARCHAR2(100),
       subregion VARCHAR2(100),
       region_code VARCHAR2(5),
       subregion_code VARCHAR2(5)
       )
ORGANIZATION EXTERNAL
    (TYPE ORACLE_LOADER
     DEFAULT DIRECTORY ext_source
     ACCESS PARAMETERS
        (RECORDS DELIMITED BY newline
         skip 1
         nobadfile nodiscardfile nologfile fields terminated by ','
         missing field values are null
         )
     LOCATION ('country_list.csv')
)
reject LIMIT unlimited;
commit;
GRANT SELECT ON ext_categories TO BL_CL;
DROP TABLE ext_categories;
create table ext_categories
      (category_name           VARCHAR2(10),
       min_star varchar2(3),
       max_star  varchar2(3)
       )
ORGANIZATION EXTERNAL
    (TYPE ORACLE_LOADER
     DEFAULT DIRECTORY ext_source
     ACCESS PARAMETERS
        (RECORDS DELIMITED BY ';'
         skip 1
         nobadfile nodiscardfile nologfile fields terminated by ','
         missing field values are null
         )
     LOCATION ('categories.csv')
)
reject LIMIT unlimited;
commit;

--DROP TABLE ext_room_types;
--create table ext_room_types
--      (
--       type_id NUMBER(3),
--       room_type varchar2(10)
--       )
--ORGANIZATION EXTERNAL
--    (TYPE ORACLE_LOADER
--     DEFAULT DIRECTORY ext_source
--     ACCESS PARAMETERS
--        (RECORDS DELIMITED BY newline
--         --skip 1
--         nobadfile nodiscardfile nologfile fields terminated by ','
--         missing field values are null
--         )
--     LOCATION ('room_types.csv')
--)
--reject LIMIT unlimited;
--commit;