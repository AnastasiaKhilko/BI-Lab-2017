CREATE DIRECTORY ext_tables AS '/media/sf_shared';
/* Tables:
ext_products
ext_consumers
ext_departments
ext_geo_countries_iso3166
ext_geo_structure_iso3166
ext_cntr2structure_iso3166
*/

--==============================================================
-- Table: ext_products
--==============================================================

DROP TABLE ext_products;
CREATE TABLE ext_products
    (
    product_code VARCHAR2(8),
    product VARCHAR2(100),
    prod_category VARCHAR2(100),
    subcategory VARCHAR2(100),
    localization VARCHAR2(100),
    tobacco NUMBER(8,2),
    prod_size NUMBER(4),
    prod_price NUMBER(8,2)
     )
ORGANIZATION EXTERNAL
    (TYPE ORACLE_LOADER
     DEFAULT DIRECTORY ext_tables
     ACCESS PARAMETERS
        (RECORDS DELIMITED BY newline
         skip 1
         nobadfile nodiscardfile nologfile fields terminated by ','
         missing field values are null
         )
     LOCATION ('Product_catalog_v4.csv')
)
reject LIMIT unlimited;

-- SELECT * FROM ext_products ORDER BY 2;

--==============================================================
-- Table: ext_consumers
--==============================================================
-- Consumers + Addresses + Responsible + Cities 
DROP TABLE ext_consumers;
CREATE TABLE ext_consumers
    (
     consumer_code VARCHAR2(255),
     gender VARCHAR2(10),
     FullName VARCHAR2(255),
     StreetAddress VARCHAR2(255),
     City	VARCHAR2(50),
     State VARCHAR2(50),
     StateFull VARCHAR(50),
     ZipCode VARCHAR(10),
     Country_CODE	VARCHAR2(2),
     Country	VARCHAR2(20),
     EmailAddress VARCHAR2(50),
     TelephoneNumber	VARCHAR2(50),
     TelephoneCountryCode	NUMBER(4),
     Birthday VARCHAR2(20),
     Age	NUMBER(3),
     CCType	VARCHAR2(20),
     CCExpires	VARCHAR2(20),
     WesternUnion	NUMBER(10),
     Color	VARCHAR2(10),
     Occupation	VARCHAR(20),
     Company	VARCHAR2(30),
     Consumer_rate NUMBER(5)
     )
ORGANIZATION EXTERNAL
    (TYPE ORACLE_LOADER
     DEFAULT DIRECTORY ext_tables
     ACCESS PARAMETERS
        (RECORDS DELIMITED BY newline
         skip 1
         nobadfile nodiscardfile nologfile fields terminated by ','
         missing field values are null
         )
     LOCATION ('Consumer_list_v2.csv')
)
reject LIMIT unlimited;

-- SELECT COUNT(DISTINCT consumer_code) FROM ext_consumers;

--==============================================================
-- Table: ext_departments
--==============================================================
-- Departments + Addresses + Cities 
DROP TABLE ext_departments;
CREATE TABLE ext_departments
    (
     dep_code VARCHAR(10),
     department VARCHAR(100),
     Country VARCHAR2(50),
     City VARCHAR2(50),
     StreetAddress VARCHAR2(255),
     StateFull	VARCHAR2(50),
     State_CODE VARCHAR2(2),
     Country_CODE	VARCHAR2(2),
     ZipCode	VARCHAR(20),
     UPS	VARCHAR(30),
     TelephoneNumber VARCHAR(40)
     )
ORGANIZATION EXTERNAL
    (TYPE ORACLE_LOADER
     DEFAULT DIRECTORY ext_tables
     ACCESS PARAMETERS
        (RECORDS DELIMITED BY newline
         skip 1
         nobadfile nodiscardfile nologfile fields terminated by ','
         missing field values are null
         )
     LOCATION ('department_list_v4.csv')
)
reject LIMIT unlimited;

-- SELECT * FROM ext_departments ORDER BY 2;

--==============================================================
-- Table: ext_geo_countries_iso3166
--==============================================================

CREATE TABLE ext_geo_countries_iso3166
    (country_id     NUMBER ( 10 ),
     country_desc   VARCHAR2 ( 200 CHAR ),
     country_code   VARCHAR2 ( 3 )
     )
ORGANIZATION EXTERNAL
    (TYPE ORACLE_LOADER
     DEFAULT DIRECTORY ext_tables
     ACCESS PARAMETERS
        (RECORDS DELIMITED BY 0x'0D0A'
         nobadfile nodiscardfile nologfile fields terminated by ';'
         missing field values are NULL 
            (country_id integer external (4),
             country_desc char(200),
             country_code char(3) )
         )
     LOCATION ('iso_3166.tab')
)
reject LIMIT unlimited;

--==============================================================
-- Table: ext_geo_structure_iso3166                           
--==============================================================
create table ext_geo_structure_iso3166  
      (child_code           NUMBER(10,0),
       parent_code          NUMBER(10,0),
       structure_desc       VARCHAR2(200 CHAR),
       structure_level      VARCHAR2(200 CHAR)
       )
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY ext_tables
     ACCESS PARAMETERS
        (RECORDS DELIMITED BY 0x'0D'
         nobadfile nodiscardfile nologfile fields terminated by ';'
         missing field values are NULL
              (child_code integer external (4),
               parent_code integer external,
               structure_desc char(200),
               structure_level char(200) )
         )
    location ('iso_3166_geo_un.tab')
)
reject limit unlimited;

--==============================================================
-- Table: t_ext_cntr2structure_iso3166
--==============================================================
DROP TABLE ext_cntr2structure_iso3166;
create table ext_cntr2structure_iso3166
      (country_id           NUMBER(10,0),
       country_desc          VARCHAR2(200 CHAR),
       structure_code       NUMBER(10,0),
       structure_desc       VARCHAR2(200 CHAR)
       )
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY ext_tables
     ACCESS PARAMETERS
        (RECORDS DELIMITED BY 0x'0D0A'
         nobadfile nodiscardfile nologfile fields terminated by ';'
         missing field values are NULL
              (country_id integer external (4),
               country_desc char(200),
               structure_code integer external,
               structure_desc char(200) )
         )
    location ('iso_3166_geo_un_contries.tab')
)
reject limit unlimited;
*/

