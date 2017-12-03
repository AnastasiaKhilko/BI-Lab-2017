DROP TABLE WRK_CUSTOMERS;
CREATE TABLE WRK_CUSTOMERS(
Number_id VARCHAR2 (250 CHAR),
        Gender VARCHAR2 (250 CHAR),
        NameSet VARCHAR2 (250 CHAR),
        Title VARCHAR2 (250 CHAR),
        GivenName VARCHAR2 (250 CHAR),
        Surname	 VARCHAR2 (250 CHAR),
        StreetAddress	 VARCHAR2 (250 CHAR),
        City	 VARCHAR2 (250 CHAR),
        State	 VARCHAR2 (250 CHAR),
        StateFull VARCHAR2 (250 CHAR),
        ZipCode VARCHAR2 (250 CHAR),
        Country VARCHAR2 (250 CHAR),
        CountryFull VARCHAR2 (250 CHAR),
        EmailAddress VARCHAR2 (250 CHAR),
        Username VARCHAR2 (250 CHAR),
        Password_id VARCHAR2 (250 CHAR),
        --BrowserUserAgent	 VARCHAR2 (250 CHAR),
        TelephoneNumber	 VARCHAR2 (250 CHAR),
        TelephoneCountryCode VARCHAR2 (250 CHAR),
        Birthday VARCHAR2 (250 CHAR),
        Age VARCHAR2 (250 CHAR),
        CCType	 VARCHAR2 (250 CHAR),
        CVV2 VARCHAR2 (250 CHAR),
        CCNumber VARCHAR2 (250 CHAR),
        CCExpires	 VARCHAR2 (250 CHAR),
       --WesternUnionMTCN VARCHAR2 (250 CHAR),
        --MoneyGramMTCN VARCHAR2 (250 CHAR),
        Occupation VARCHAR2 (250 CHAR),
        Company	 VARCHAR2 (250 CHAR)
);
begin
 pkg_etl_load_wrk.load_wrk_prod_types;
end;
/
--select count(*) from (
select count(*) from (select distinct StreetAddress from wrk_customers order by 1);
select count(*) from (select distinct city from wrk_customers);
select *  from wrk_customers;
drop table cls_customers;
select * from cls_addresses;
  CREATE TABLE CLS_CUSTOMERS 
   (	CUSTOMER_ID NUMBER, 
	GENDER VARCHAR2(6 BYTE), 
	NAME VARCHAR2(20 BYTE), 
	SURNAME VARCHAR2(20 BYTE), 
	TITLE VARCHAR2(4 BYTE), 
	EMAIL VARCHAR2(40 BYTE), 
	PHONE VARCHAR2(20 BYTE), 
	AGE NUMBER(2,0), 
	AGE_GROUP VARCHAR2(10 BYTE), 
	BIRTHDAY DATE, 
	OCCUPATION VARCHAR2(70 BYTE), 
	COMPANY VARCHAR2(40 BYTE), 
	address_id number, --city
  
	UPDATE_DT DATE
   );
   commit;
   drop table cls_addresses;
  CREATE TABLE cls_addresses(
--address_id number primary key,
address varchar2(90),
city_id number ,--references dim_cities (city_id),
postal_code varchar2(40),
--phone varchar2(10),
update_dt date
);
--CREATE TABLE cls_CUSTOMERS(
--        customer_id number,
--        Gender VARCHAR2 (250 CHAR),
--        --NameSet VARCHAR2 (250 CHAR),
--        Title VARCHAR2 (250 CHAR),
--        Name VARCHAR2 (250 CHAR),
--        Surname	 VARCHAR2 (250 CHAR),
----        StreetAddress	 VARCHAR2 (250 CHAR),
----        City	 VARCHAR2 (250 CHAR),
----        State	 VARCHAR2 (250 CHAR),
----        StateFull VARCHAR2 (250 CHAR),
----        ZipCode VARCHAR2 (250 CHAR),
----        Country VARCHAR2 (250 CHAR),
----        CountryFull VARCHAR2 (250 CHAR),
--        Email VARCHAR2 (250 CHAR),
--        Username VARCHAR2 (250 CHAR),
--       -- Password_id VARCHAR2 (250 CHAR),
--        --BrowserUserAgent	 VARCHAR2 (250 CHAR),
--        TelephoneNumber	 VARCHAR2 (250 CHAR),
--        --TelephoneCountryCode VARCHAR2 (250 CHAR),
--        Birthday VARCHAR2 (250 CHAR),
--        Age VARCHAR2 (250 CHAR),
--        --CCType	 VARCHAR2 (250 CHAR),
--        --CVV2 VARCHAR2 (250 CHAR),
--        --CCNumber VARCHAR2 (250 CHAR),
--        --CCExpires	 VARCHAR2 (250 CHAR),
--       --WesternUnionMTCN VARCHAR2 (250 CHAR),
--        --MoneyGramMTCN VARCHAR2 (250 CHAR),
--        Occupation VARCHAR2 (250 CHAR),
--        Company	 VARCHAR2 (250 CHAR)
--);
create table wrk_banks(
BANK_ID	NUMBER,
BANK_NAME	VARCHAR2(250 CHAR)
);
select * from wrk_hotels;
select*from wrk_banks;
drop table cls_cards;
create table cls_cards(
CCTYPE_id	number,
bank_id number,
CVV2	VARCHAR2(250 CHAR),
CCNUMBER	VARCHAR2(250 CHAR),
CCEXPIRES	VARCHAR2(250 CHAR));
--commit;
drop table cls_card_types;
create table cls_card_types(
card_type_id number primary key,

CCTYPE	VARCHAR2(250 CHAR)
);
begin
pkg_etl_load_cards.load_cls_cards;
 

END;
/
commit;
select * from cls_customers;
select * from cls_banks;
select * from cls_cards;

begin
pkg_etl_load_banks.insert_banks;
pkg_etl_load_banks.load_cls_banks;
end;
/
DROP TABLE wrk_sources;
CREATE TABLE wrk_sources
        (
         source_id VARCHAR2 ( 30 CHAR ),
         Site VARCHAR2 ( 30 CHAR ),
         visits VARCHAR2 ( 30 CHAR ),
         Time_online VARCHAR2 ( 30 CHAR ),
         Page_Views VARCHAR2 ( 30 CHAR ),
         Leading_Country VARCHAR2 ( 30 CHAR )
        );
commit;
select*from wrk_sources;
DROP TABLE cls_sources;       
CREATE TABLE cls_sources
        (
         --source_3nf_id number,
         source_id number,
         Site VARCHAR2 ( 30 CHAR ),
         visits number,
         Time_online varchar2(30),
         Page_Views number,
         Leading_Country VARCHAR2 ( 30 CHAR ),
         source_tax number,
         update_date date
        );
--select to_timestamp(Time_online,'HH:MI') ,
--         time_online
--         Leading_Country
--from cls_sources;
begin        
pkg_etl_load_sources.load_to_wrk;
pkg_etl_load_sources.load_cls_sources;
pkg_etl_load_sources.load_ce;
end;
/
select * from CLS_SOURCES;
select * from bl_3nf.ce_sources;

select * from wrk_hotels;
CREATE TABLE wrk_hotels
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
 
         );
drop table cls_hotels;


         commit;CREATE TABLE cls_hotels
        (
         hotel_code varchar2(7),
         address_id number,
         --categories VARCHAR2 ( 200),
         category_id number,
        -- city VARCHAR2 ( 200  ),
        -- country	 VARCHAR2 ( 200  ),
        -- latitude VARCHAR2 ( 200  ),
        -- longitude VARCHAR2 ( 200  ),
         name VARCHAR2 ( 200  ),
         --postalCode VARCHAR2 ( 200 ),
        -- province VARCHAR2 ( 200  ),
         email	 VARCHAR2 ( 200 CHAR ),
         reviews_date	 VARCHAR2 ( 200 CHAR ),
         reviews_rating VARCHAR2 ( 200 CHAR )
 
         );       
select * from wrk_hotels;
drop table wrk_countries;
CREATE TABLE wrk_countries
        (country_id     NUMBER ( 10 ),
         country_desc   VARCHAR2 ( 200 CHAR ),
         country_code   VARCHAR2 ( 3 )
         );
drop table wrk_structure;        
create table wrk_structure 
          (child_code           NUMBER(10,0),
           parent_code          NUMBER(10,0),
           structure_desc       VARCHAR2(200 CHAR),
           structure_level      VARCHAR2(200 CHAR)
           );
drop table wrk_connection;          
create table wrk_conuntry2struct
          (country_id           NUMBER(10,0),
           county_desc          VARCHAR2(200 CHAR),
           structure_code       NUMBER(10,0),
           structure_desc       VARCHAR2(200 CHAR)
           );

-----------------------------------
drop table cls_continents;
CREATE
  TABLE cls_continents
  (
    --continent_id   NUMBER (3),
    continent_src_id number(3),
    continent_name VARCHAR2 (200 CHAR)
  );

drop table cls_regions;
CREATE
  TABLE cls_regions
  (
    --region_id    NUMBER (3),
    region_src_id    NUMBER (3),
    region_name  VARCHAR2(200 CHAR),
    continent_id NUMBER (3)
  );
  
drop table cls_countries;
CREATE
  TABLE cls_countries
  (
    --country_id   NUMBER (3),
    country_src_id NUMBER (3),
    country_name VARCHAR2 (200 CHAR),
    country_code VARCHAR2 (3),
    region_id    NUMBER (3)
  );              
commit;    
---------------------------------
drop table wrk_locations;
create table wrk_locations
      (country_name           VARCHAR2(100),
       country_code2          VARCHAR2(10),
       country_code3       VARCHAR2(10),
       country_code1 NUMBER(3),
       region       VARCHAR2(100),
       subregion VARCHAR2(100),
       region_code VARCHAR2(5),
       subregion_code VARCHAR2(5)
       );
DROP TABLE CLS_REGIONS;
CREATE TABLE CLS_REGIONS (
  REGION_CODE VARCHAR2(3),
  REGION_NAME VARCHAR2(50)
  );

DROP TABLE CLS_SUBREGIONS;
CREATE TABLE CLS_SUBREGIONS (
  SUBREGION_CODE VARCHAR2(4),
  SUBREGION_NAME VARCHAR2(100),
  REGION_CODE VARCHAR(3)
  );
truncate table cls_cities;
DROP TABLE CLS_COUNTRIES;
CREATE TABLE CLS_COUNTRIES (
  country_code2 VARCHAR2(10),
  country_code3 VARCHAR2(10),
  country_name VARCHAR2(100),
  subregion_code VARCHAR(4)
  );
select*from cls_cities;
DROP TABLE CLS_CITIES;
CREATE TABLE CLS_CITIES (
  --city_code VARCHAR2(10),
  city_name VARCHAR2(50),
  country_code VARCHAR2(50)
);
select *from wrk_hotels;
drop table wrk_categories;
create table wrk_categories
      (
         category_name           VARCHAR2(10),
         in_star varchar2(3),
         max_star  varchar2(3)
       );
       commit;
select * from cls_categories;
create table cls_categories
      (
         category_name           VARCHAR2(10),
         in_star NUMBER(3),
         max_star  number(3)
       );      
create table wrk_room_types
      (
         type_id NUMBER(3),
         room_type varchar2(10)
       );
create table cls_room_types
      (
         type_id NUMBER(3),
         room_type varchar2(10)
       );
       
drop table cls_orders;      
CREATE TABLE cls_orders(
          customer_id number,
          order_date date,
          hotel_id number,
          source_id number,
          check_in_date date,
          days_amount number,
          amount number,
          room_type varchar2(15),
          --class
          number_of_people number,
          discount number(10,2)
);