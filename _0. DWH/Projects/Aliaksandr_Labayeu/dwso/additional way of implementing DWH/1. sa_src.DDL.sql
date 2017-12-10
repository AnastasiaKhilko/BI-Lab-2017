CREATE OR REPLACE DIRECTORY ext_tables AS '/media/sf_shared';

--==============================================================
-- Table: ext_products
--==============================================================
-- DROP SYNONYMS
DROP TABLE ext_products;
CREATE TABLE ext_products
    (
    product_code VARCHAR2(8),
    product VARCHAR2(100),
    prod_category VARCHAR2(100),
      prod_category_code VARCHAR2(8),
    subcategory VARCHAR2(100),
      subcategory_code VARCHAR2(8),
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
     LOCATION ('Product_catalog_v5.csv')
)
reject LIMIT unlimited;

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
     Responsible_CODE VARCHAR2(20),
     StreetAddress VARCHAR2(255),
     StreetCode VARCHAR2(20),
     City	VARCHAR2(255),
     City_code VARCHAR2(30),
     State VARCHAR2(50),
     StateFull VARCHAR2(100),
     ZipCode VARCHAR(50),
     Country_CODE	VARCHAR2(3),
     Country	VARCHAR2(100),
     EmailAddress VARCHAR2(255),
     TelephoneNumber	VARCHAR2(50),
     TelephoneCountryCode	NUMBER(10),
     Birthday VARCHAR2(20),
     Age	NUMBER(3),
     CCType	VARCHAR2(20),
     CCExpires	VARCHAR2(20),
     WesternUnion	NUMBER(30),
     Color	VARCHAR2(30),
     Occupation	VARCHAR2(255),
     Occupation_code VARCHAR2(60),
     Company	VARCHAR2(255),
     Consumer_rate NUMBER(3),
     Rate_Description VARCHAR(10)
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
     City_code VARCHAR2(10),
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
-- SELECT COUNT( DISTINCT city) FROM ext_departments; -- CODE REBUILd!!!!!!!!!!!!!!!!!!!!

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
     DEFAULT DIRECTORY ext_tables
     ACCESS PARAMETERS
        (RECORDS DELIMITED BY newline
         skip 1
         nobadfile nodiscardfile nologfile fields terminated by ','
         missing field values are null
         )
     LOCATION ('country_list.csv')
)
reject LIMIT unlimited;
