----------------------------
/*CREATE TABLE PRODUCTS*/
DROP TABLE ext_products;
CREATE TABLE ext_products
  (
    Category        VARCHAR2 ( 100 ),
    Subcategory     VARCHAR2 ( 100 ),
    Product_Company VARCHAR2 ( 100 ),
    Product_Name    VARCHAR2 ( 100 ),
    Pack_Size       VARCHAR2 ( 100 ),
    Price           NUMBER   (  8  ),
    emailaddress    VARCHAR2 (100)
  )
  ORGANIZATION EXTERNAL
  (
    TYPE ORACLE_LOADER DEFAULT DIRECTORY ext_sources_dwh ACCESS PARAMETERS
    (RECORDS DELIMITED BY newline
    nobadfile nodiscardfile nologfile fields terminated BY ','
    missing field VALUES are NULL
    (Category ,
    Subcategory ,
    Product_Company ,
    Product_Name ,
    Pack_Size,
    Price,
    emailaddress)
    ) LOCATION ('PRODUCT_NEW3.csv')
  )
  reject LIMIT unlimited;
SELCT count(*) FROM ext_products;
--------------------------------
/*CREATE TABLE CUSTOMERS*/
--------------------------------
DROP TABLE ext_customers;
CREATE TABLE ext_customers
  (
    Number_code          NUMBER(8),
    Gender               VARCHAR2(100 CHAR),
    NameSet              VARCHAR2(100 CHAR),
    Title                VARCHAR2(100 CHAR),
    GivenName            VARCHAR2(100 CHAR),
    MiddleInitial        VARCHAR2(100 CHAR),
    Surname              VARCHAR2(100 CHAR),
    StreetAddress        VARCHAR2(100 CHAR),
    City                 VARCHAR2(100 CHAR),
    State                VARCHAR2(100 CHAR),
    StateFull            VARCHAR2(100 CHAR),
    ZipCode              VARCHAR2(100 CHAR),
    Country              VARCHAR2(100 CHAR),
    CountryFull          VARCHAR2(100 CHAR),
    EmailAddress         VARCHAR2(100 CHAR),
    Username             VARCHAR2(100 CHAR),
    Password             VARCHAR2(100 CHAR),
    BrowserUserAgent     VARCHAR2(100 CHAR),
    TelephoneNumber      VARCHAR2(100 CHAR),
    TelephoneCountryCode VARCHAR2(100 CHAR),
    MothersMaiden        VARCHAR2(100 CHAR),
    Birthday             VARCHAR2(100 CHAR),
    Age                  NUMBER(8),
    TropicalZodiac       VARCHAR2(100 CHAR),
    CCType               VARCHAR2(100 CHAR),
    CCNumber             VARCHAR2(100 CHAR),
    CVV2                 NUMBER(8),
    CCExpires            VARCHAR2(100 CHAR),
    NationalID           VARCHAR2(100 CHAR),
    UPS                  VARCHAR2(100 CHAR),
    WesternUnionMTCN     VARCHAR2(100 CHAR),
    MoneyGramMTCN        NUMBER(8),
    Color                VARCHAR2(100 CHAR),
    Occupation           VARCHAR2(100 CHAR),
    Company              VARCHAR2(100 CHAR),
    Vehicle              VARCHAR2(100 CHAR),
    Domain               VARCHAR2(100 CHAR),
    BloodType            VARCHAR2(100 CHAR),
    Pounds               VARCHAR2(100 CHAR),
    Kilograms            VARCHAR2(100 CHAR),
    FeetInches           VARCHAR2(100 CHAR),
    Centimeters          VARCHAR2(100 CHAR),
    GUID                 VARCHAR2(100 CHAR),
    Latitude             VARCHAR2(100 CHAR),
    Longitude            VARCHAR2(100 CHAR)
  )
  ORGANIZATION EXTERNAL
  (
    TYPE ORACLE_LOADER DEFAULT DIRECTORY ext_sources_dwh ACCESS PARAMETERS
    (RECORDS DELIMITED BY newline
    nobadfile nodiscardfile nologfile fields terminated BY ','
    missing field VALUES are NULL
    (Number_code,
    Gender,
    NameSet,
    Title,
    GivenName,
    MiddleInitial,
    Surname,
    StreetAddress,
    City,
    State,
    StateFull,
    ZipCode,
    Country,
    CountryFull,
    EmailAddress,
    Username,
    Password,
    BrowserUserAgent,
    TelephoneNumber,
    TelephoneCountryCode,
    MothersMaiden,
    Birthday,
    Age,
    TropicalZodiac,
    CCType,
    CCNumber,
    CVV2,
    CCExpires,
    NationalID,
    UPS,
    WesternUnionMTCN,
    MoneyGramMTCN,
    Color,
    Occupation,
    Company,
    Vehicle,
    Domain,
    BloodType,
    Pounds,
    Kilograms,
    FeetInches,
    Centimeters,
    GUID,
    Latitude,
    Longitude
    )
    ) LOCATION ('FakeNameGenerator.com_bc2aaf69.csv')
  )
  reject LIMIT unlimited;
SELECT * FROM ext_customers;
----------------------------------
/*CREATE TABLE COUNTRIES*/
----------------------------------
DROP TABLE EXT_GEO_COUNTRIES;
CREATE TABLE ext_geo_countries
  (
    cc_fips      VARCHAR2(2),
    cc_iso       VARCHAR2(2),
    tld          VARCHAR2(3),
    country_name VARCHAR2(200 CHAR)
  )
  ORGANIZATION EXTERNAL
  (
    TYPE oracle_loader DEFAULT DIRECTORY ext_sources_dwh ACCESS PARAMETERS (
    RECORDS DELIMITED BY NEWLINE
    NOBADFILE
    NODISCARDFILE
    NOLOGFILE
    FIELDS TERMINATED BY ';' MISSING FIELD VALUES ARE NULL (
    CC_FIPS,
    CC_ISO,
    TLD,
    COUNTRY_NAME
    )
    ) LOCATION ( 'COUNTRY.TXT' )
  )
  REJECT LIMIT UNLIMITED;
SELECT * FROM EXT_GEO_COUNTRIES;
--------------------------------------
/*CREATE TABLE CITIES*/
--------------------------------------
DROP TABLE EXT_GEO_CITIES;
CREATE TABLE ext_geo_cities
  (
    cc_fips   VARCHAR2(2),
    city_name VARCHAR2(200 CHAR)
  )
  ORGANIZATION EXTERNAL
  (
    TYPE oracle_loader DEFAULT DIRECTORY ext_sources_dwh ACCESS PARAMETERS (
    RECORDS DELIMITED BY NEWLINE
    NOBADFILE
    NODISCARDFILE
    NOLOGFILE
    FIELDS TERMINATED BY ' ' MISSING FIELD VALUES ARE NULL (
    cc_fips ,
    city_name
    )
    ) LOCATION ( 'GEODATASOURCE-CITIES-FREE.TXT' )
  )
  REJECT LIMIT UNLIMITED;
SELECT COUNT(*) FROM EXT_GEO_CITIES; 

--------------------------------------
/*CREATE TABLE SUPPLIERS*/
--------------------------------------
DROP TABLE ext_suppliers;
CREATE TABLE ext_suppliers
  (
    Number_Code          NUMBER(8),
    GivenName            VARCHAR2(100 CHAR),
    TelephoneNumber      VARCHAR2(100 CHAR),
    EmailAddress         VARCHAR2(100 CHAR),
    StreetAddress        VARCHAR2(100 CHAR),
    City                 VARCHAR2(100 CHAR),
    State                VARCHAR2(100 CHAR),
    StateFull            VARCHAR2(100 CHAR),
    ZipCode              VARCHAR2(100 CHAR),
    Country              VARCHAR2(100 CHAR),
    CountryFull          VARCHAR2(100 CHAR)
  )
  ORGANIZATION EXTERNAL
  (
    TYPE ORACLE_LOADER DEFAULT DIRECTORY ext_sources_dwh ACCESS PARAMETERS
    (RECORDS DELIMITED BY newline
    nobadfile nodiscardfile nologfile fields terminated BY ';'
    missing field VALUES are NULL
    ( Number_Code,
    GivenName,
    TelephoneNumber,
    EmailAddress,
    StreetAddress,
    City,
    State,
    StateFull,
    ZipCode,
    Country,
    CountryFull          
    )
    ) LOCATION ('Suppliers.txt')
  )
  reject LIMIT unlimited;
  select * from EXT_SUPPLIERS;