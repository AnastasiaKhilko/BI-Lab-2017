

drop table ce_customers;
CREATE TABLE ce_customers(
        customer_3nf_id number primary key,
        customer_id number,
        gender varchar2(6),
        name varchar2(20),
        surname varchar2(20),
        title varchar2(4),
        email varchar2(40),
        telephone_number varchar2(20),
        age number (2),
        age_group varchar2(10),
        birthday date,
        occupation varchar2(70),
        company varchar2(40),
        address_id number,-- number references dim_addresses(address_id),
        update_dt date
);
select*from ce_customers;
drop table ce_banks;
create table ce_banks(
bank_3nf_id number primary key,
BANK_src_id	NUMBER,
BANK_NAME	VARCHAR2(250 CHAR),
update_date date
);
truncate table bl_3nf.ce_cards;
drop table ce_cards;
create table ce_cards(
card_3nf_id number primary key,
bank_id number,
CCTYPE_id	number,
CVV2	VARCHAR2(250 CHAR),
CCNUMBER	VARCHAR2(250 CHAR),
CCEXPIRES	VARCHAR2(250 CHAR));
select * from ce_cards;
drop table ce_card_types;
create table ce_card_types(
card_type_3nf_id number primary key,
CCTYPE	VARCHAR2(250 CHAR)
);

commit;
drop TABLE ce_hotels;
CREATE TABLE ce_hotels(
hotel_3nf_id number primary key,
hotel_code varchar2(10),
hotel_name varchar2(200),
category_id number,-- references dim_categories(category_id),
address_id  number,-- references dim_addresses(address_id),
email VARCHAR2 ( 200 CHAR ),
update_dt date,
reviews_date	 VARCHAR2 ( 200 CHAR ),
reviews_rating  VARCHAR2 ( 200 CHAR )
 
);
truncate table bl_3nf.ce_customers;
------------------------------------------------
drop table ce_addresses;
CREATE TABLE ce_addresses(
address_id number primary key,
address varchar2(90),
city_id number ,--references dim_cities (city_id),
postal_code varchar2(10),
--phone varchar2(10),
update_dt date
);

CREATE TABLE ce_cities(
city_id number primary key,
city varchar2(10),
city_code 
country_id number references dim_countries (country_id),
update_dt date
);

CREATE TABLE ce_countries(
country_id number primary key,
country_code varchar2(10),
country_name varchar2(10),
region_id number references dim_regions(region_id),
update_dt date
);


---------------------------------------------------

DROP TABLE CE_CITIES;
CREATE TABLE CE_CITIES (
  CITY_3NF_ID NUMBER PRIMARY KEY,
  CITY_CODE VARCHAR2(10),
  CITY_NAME VARCHAR2(50),
  COUNTRY_CODE VARCHAR2(50)
);

DROP TABLE CE_REGIONS;
CREATE TABLE CE_REGIONS (
  REGION_3NF_ID NUMBER PRIMARY KEY,
  REGION_CODE VARCHAR2(3),
  REGION_NAME VARCHAR2(50)
  );

DROP TABLE CE_SUBREGIONS;
CREATE TABLE CE_SUBREGIONS (
  SUBREGION_3NF_ID NUMBER PRIMARY KEY,
  SUBREGION_CODE VARCHAR2(4),
  SUBREGION_NAME VARCHAR2(100),
  REGION_CODE VARCHAR(3)
  );

DROP TABLE CE_COUNTRIES;
CREATE TABLE CE_COUNTRIES (
 SUBREGION_3NF_ID NUMBER PRIMARY KEY,
  COUNTRY_CODE2 VARCHAR2(10),
  COUNTRY_CODE3 VARCHAR2(10),
  COUNTRY_NAME VARCHAR2(100),
  SUBREGION_CODE VARCHAR(4)
  );

commit;
exec BL_CL.GRANTS_TO_BL_CL;

drop table ce_hotel_categories;
CREATE TABLE ce_hotel_categories(
category_id number primary key,
category_name varchar2(20),
update_dt date
);

CREATE TABLE fact_payment(
order_id number primary key,
customer_id number references dim_customers(customer_id),
order_date date,
hotel_id number references dim_hotels(hotel_id),
source_id number references dim_sources(source_id),
order_date_id number references dim_date(date_id),
check_in_date_id number references dim_date(date_id),
check_out_date_id number references dim_date(date_id),
amount number(10,2),
-- room_type
--class
number_of_people number(10,2),
discount number(10,2)
);
truncate table bl_3nf.ce_categories;
create table ce_categories
      (
      category_3nf_id number primary key,
         category_name           VARCHAR2(10),
         min_star NUMBER(3),
         max_star  number(3)
       );      
drop table ce_categories;
create table ce_room_types
      (
      type_id number primary key,
         type_code NUMBER(3),
         room_type varchar2(10)
       );
