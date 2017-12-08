DROP TABLE CE_REGIONS;
CREATE TABLE CE_REGIONS
  (
    REGION_3NF_ID NUMBER NOT NULL,
    REGION_CODE   VARCHAR2(3) NOT NULL,
    REGION_NAME   VARCHAR2(50) NOT NULL,
    CONSTRAINT REGION_ID_PK PRIMARY KEY ( REGION_3NF_ID ),
    CONSTRAINT CODE_UNQ UNIQUE ( REGION_CODE )
  );
SELECT * FROM CE_REGIONS;
DROP TABLE CE_SUBREGIONS;
CREATE TABLE CE_SUBREGIONS
  (
    SUBREGION_3NF_ID NUMBER NOT NULL,
    SUBREGION_CODE   VARCHAR2(4) NOT NULL,
    SUBREGION_NAME   VARCHAR2(100) NOT NULL,
    REGION_ID     NUMBER NOT NULL,
    CONSTRAINT SUBREGION_ID_PK PRIMARY KEY ( SUBREGION_3NF_ID ),
    CONSTRAINT CODE_UNQ1 UNIQUE ( SUBREGION_CODE ),
    CONSTRAINT SUBREGION_FK FOREIGN KEY ( REGION_ID ) 
    REFERENCES CE_REGIONS ( REGION_3NF_ID )
  );
 SELECT * FROM CE_SUBREGIONS;
SELECT * FROM CE_COUNTRIES;
 ---------------------------------------------  
DROP TABLE CE_COUNTRIES;
CREATE TABLE CE_COUNTRIES
  (
    COUNTRY_3NF_ID NUMBER NOT NULL,
    COUNTRY_CODE2    VARCHAR2(10),
    COUNTRY_CODE3    VARCHAR2(10),
    COUNTRY_NAME     VARCHAR2(100) NOT NULL,
    SUBREGION_ID   NUMBER NOT NULL,
    CONSTRAINT COUNTRY_ID_PK PRIMARY KEY (COUNTRY_3NF_ID),
    CONSTRAINT CODE_UNQ3 UNIQUE ( COUNTRY_CODE3 ),
    CONSTRAINT CODE1_UNQ UNIQUE ( COUNTRY_name ),
    CONSTRAINT country_FK FOREIGN KEY ( SUBREGION_ID) 
    REFERENCES CE_SUBREGIONS ( SUBREGION_3NF_ID )
  );
SELECT* FROM CE_COUNTRIES;  
---------------------------------------------
TRUNCATE TABLE CE_REGIONS;
TRUNCATE TABLE CE_SUBREGIONS;
TRUNCATE TABLE CE_COUNTRIES;
----------------------------------------------
SELECT * FROM CE_CITIES order by CITY_3NF_ID;
DROP TABLE CE_CITIES;
truncate table ce_cities;
CREATE TABLE CE_CITIES
  (
    CITY_3NF_ID  NUMBER PRIMARY KEY,
    CITY_NAME    VARCHAR2(50),
    COUNTRY_ID NUMBER,
    CONSTRAINT city_FK FOREIGN KEY ( country_ID) 
    REFERENCES CE_countries ( country_3nf_ID )
  );
select* from ce_addresses order by ADDRESS_ID;
drop table ce_addresses;
CREATE TABLE CE_ADDRESSES
  (
    ADDRESS_ID  NUMBER PRIMARY KEY,
    ADDRESS     VARCHAR2(90),
    CITY_ID     NUMBER ,--references dim_cities (city_id),
    POSTAL_CODE VARCHAR2(60),
    --phone varchar2(10),
    UPDATE_DT DATE,
    CONSTRAINT address_FK FOREIGN KEY ( city_ID) 
    REFERENCES CE_cities ( city_3nf_ID )
  );
commit;
select * from ce_sources order by SOURCE_3NF_ID;
DROP TABLE CE_SOURCES;
TRUNCATE TABLE  CE_SOURCES;
CREATE TABLE CE_SOURCES
        (
         SOURCE_3NF_ID NUMBER PRIMARY KEY,
         SOURCE_ID NUMBER,
         SITE VARCHAR2 ( 30 CHAR ) NOT NULL,
         VISITS NUMBER,
         TIME_ONLINE VARCHAR2(30),
         PAGE_VIEWS NUMBER,
         LEADING_COUNTRY VARCHAR2 ( 30 CHAR ),
         SOURCE_TAX NUMBER NOT NULL,
         UPDATE_DATE DATE
        );       
COMMIT;
SELECT * FROM BL_3NF.CE_SOURCES order by SOURCE_3NF_ID;

DROP TABLE CE_CARD_TYPES;
CREATE TABLE CE_CARD_TYPES
        (
        CARD_TYPE_3NF_ID NUMBER PRIMARY KEY,
        CCTYPE	VARCHAR2(250 CHAR) NOT NULL
        );
SELECT * FROM CE_CARD_TYPES;
truncate table CE_CARD_TYPES;
truncate table CE_CARDS;
SELECT * FROM CE_CARDS order by card_3nf_id;
DROP TABLE CE_BANKS;
CREATE TABLE CE_BANKS(
        BANK_3NF_ID NUMBER PRIMARY KEY,
        BANK_SRC_ID varchar2(8) NOT NULL,
        BANK_NAME	VARCHAR2(250 CHAR) NOT NULL,
        start_dt date,
        end_dt date,
       is_active varchar2(3) ,
        discount number,
        update_dt date
);
select * from ce_banks;
TRUNCATE TABLE BL_3NF.CE_CARDS;
DROP TABLE CE_CARDS;
CREATE TABLE CE_CARDS
        (
        CARD_3NF_ID NUMBER PRIMARY KEY,
        BANK_ID NUMBER NOT NULL,
        CCTYPE_ID	NUMBER NOT NULL,
        CVV2	VARCHAR2(250 CHAR),
        CCNUMBER	VARCHAR2(250 CHAR) NOT NULL,
        CCEXPIRES	VARCHAR2(250 CHAR),
        CONSTRAINT bank_FK FOREIGN KEY ( BANK_ID ) 
        REFERENCES CE_BANKS ( BANK_3NF_ID ),
        CONSTRAINT type_FK FOREIGN KEY ( CCTYPE_ID ) 
        REFERENCES CE_CARD_TYPES ( CARD_TYPE_3NF_ID )
        );
        commit;
select * from ce_hotels order by hotel_3nf_id;        
DROP TABLE CE_HOTELS;
CREATE TABLE CE_HOTELS
(
          HOTEL_3NF_ID NUMBER PRIMARY KEY,
          HOTEL_CODE VARCHAR2(10),
          HOTEL_NAME VARCHAR2(200),
          CATEGORY_ID NUMBER,-- references dim_categories(category_id),
          ADDRESS_ID  NUMBER,-- references dim_addresses(address_id),
          EMAIL VARCHAR2 ( 200 CHAR ),
          UPDATE_DT DATE,
          REVIEWS_DATE	 VARCHAR2 ( 200 CHAR ),
          REVIEWS_RATING  VARCHAR2 ( 200 CHAR )
 
);

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
alter table ce_orders
add  CONSTRAINT order1_FK FOREIGN KEY ( card_ID) 
    REFERENCES CE_cards ( card_3nf_id);
alter table ce_customers
add  CONSTRAINT customer1_FK FOREIGN KEY ( address_ID) 
    REFERENCES CE_addresses ( address_ID );
select count(* )from ce_orders;
drop table ce_orders;
CREATE TABLE ce_orders(
          customer_id number not null,
          order_date date not null,
          hotel_id number not null,
          source_id number not null,
          check_in_date date not null,
          days_amount number,
          amount number,
          room_type varchar2(15),
          --class
          number_of_people number,
          discount number(10,2),
          CONSTRAINT customer_FK FOREIGN KEY ( customer_ID) 
    REFERENCES CE_customers ( customer_3nf_ID ),
    CONSTRAINT hotel_FK FOREIGN KEY ( hotel_ID) 
    REFERENCES CE_hotels( hotel_3nf_ID ),
--    CONSTRAINT address_FK FOREIGN KEY ( address_ID) 
--    REFERENCES CE_addresses ( address_3nf_ID ),
    CONSTRAINT source_FK FOREIGN KEY ( source_ID) 
    REFERENCES CE_sources ( source_3nf_ID )--,
--    CONSTRAINT address_FK FOREIGN KEY ( city_ID) 
--    REFERENCES CE_cities ( city_3nf_ID )
);
create or replace procedure do_truncate
as
begin
execute immediate 'truncate table bl_3nf.ce_orders';
end;
/
commit;
truncate table ce_orders;
grant execute on do_truncate to bl_cl;