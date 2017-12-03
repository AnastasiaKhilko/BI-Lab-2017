------------------------
DROP TABLE WRK_PRODUCTS;
------------------------
CREATE TABLE WRK_PRODUCTS
  (
    Category        VARCHAR2 ( 100 ),
    Subcategory     VARCHAR2 ( 100 ),
    Product_Company VARCHAR2 ( 100 ),
    Product_Name    VARCHAR2 ( 100 ),
    Pack_Size       VARCHAR2 ( 100 ),
    Price           NUMBER ( 8 ),
    emailaddress    VARCHAR2(100)
  );
------------------------------------
DROP TABLE WRK_CUSTOMERS;
------------------------------------
CREATE TABLE WRK_CUSTOMERS
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
  );
--------------------------------------------
DROP TABLE WRK_COUNTRIES;
--------------------------------------------
CREATE TABLE WRK_COUNTRIES
  (
    cc_fips      VARCHAR2(2),
    cc_iso       VARCHAR2(2),
    tld          VARCHAR2(3),
    country_name VARCHAR2(200 CHAR) 
  );
-------------------------------------------
DROP TABLE WRK_CITIES;
-------------------------------------------
CREATE TABLE WRK_CITIES
  (
    cc_fips   VARCHAR2(2),
    city_name VARCHAR2(200 CHAR)
  );
----------------------------
DROP TABLE wrk_suppliers;
----------------------------
CREATE TABLE wrk_suppliers
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
  );
  alter table wrk_products add  id number(8); 
update wrk_products set id=rownum;