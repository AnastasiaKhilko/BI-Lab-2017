drop table WRK_CUSTOMERS;
create table WRK_CUSTOMERS
  (
    NUMBER_ID     varchar2 (250 char),
    GENDER        varchar2 (250 char),
    NAMESET       varchar2 (250 char),
    TITLE         varchar2 (250 char),
    GIVENNAME     varchar2 (250 char),
    SURNAME       varchar2 (250 char),
    STREETADDRESS varchar2 (250 char),
    CITY          varchar2 (250 char),
    STATE         varchar2 (250 char),
    STATEFULL     varchar2 (250 char),
    ZIPCODE       varchar2 (250 char),
    COUNTRY       varchar2 (250 char),
    COUNTRYFULL   varchar2 (250 char),
    EMAILADDRESS  varchar2 (250 char),
    USERNAME      varchar2 (250 char),
    PASSWORD_ID   varchar2 (250 char),
    --BrowserUserAgent  VARCHAR2 (250 CHAR),
    TELEPHONENUMBER      varchar2 (250 char),
    TELEPHONECOUNTRYCODE varchar2 (250 char),
    BIRTHDAY             varchar2 (250 char),
    AGE                  varchar2 (250 char),
    CCTYPE               varchar2 (250 char),
    CVV2                 varchar2 (250 char),
    CCNUMBER             varchar2 (250 char),
    CCEXPIRES            varchar2 (250 char),
    --WesternUnionMTCN VARCHAR2 (250 CHAR),
    --MoneyGramMTCN VARCHAR2 (250 CHAR),
    OCCUPATION varchar2 (250 char),
    COMPANY    varchar2 (250 char)
  );
drop table WRK_BANKS;
create table WRK_BANKS
  ( 
    BANK_ID varchar2(9),
    BANK_NAME varchar2(250 char),
    start_dt date
  );
drop table WRK_SOURCES;
create table WRK_SOURCES
  (
    SOURCE_ID       varchar2 ( 30 char ),
    SITE            varchar2 ( 30 char ),
    VISITS          varchar2 ( 30 char ),
    TIME_ONLINE     varchar2 ( 30 char ),
    PAGE_VIEWS      varchar2 ( 30 char ),
    LEADING_COUNTRY varchar2 ( 30 char )
  );
drop table WRK_HOTELS;
create table WRK_HOTELS
  (
    ADDRESS varchar2 (100 ),
    --categories VARCHAR2 ( 200),
    CITY           varchar2 ( 200 ),
    COUNTRY        varchar2 ( 200 ),
    LATITUDE       varchar2 ( 200 ),
    LONGITUDE      varchar2 ( 200 ),
    NAME_          varchar2 ( 200 ),
    POSTALCODE     varchar2 ( 200 ),
    PROVINCE       varchar2 ( 200 ),
    REVIEWS_DATE   varchar2 ( 200 char ),
    REVIEWS_RATING varchar2 ( 200 char )
  );
drop table WRK_LOCATIONS;
create table WRK_LOCATIONS
  (
    COUNTRY_NAME   varchar2(100),
    COUNTRY_CODE2  varchar2(10),
    COUNTRY_CODE3  varchar2(10),
    COUNTRY_CODE1  number(3),
    REGION         varchar2(100),
    SUBREGION      varchar2(100),
    REGION_CODE    varchar2(5),
    SUBREGION_CODE varchar2(5)
  );
drop table WRK_CATEGORIES;
create table WRK_CATEGORIES
  (
    CATEGORY_NAME varchar2(10),
    MIN_STAR       varchar2(3),
    MAX_STAR      varchar2(3),
    start_dt date
  );