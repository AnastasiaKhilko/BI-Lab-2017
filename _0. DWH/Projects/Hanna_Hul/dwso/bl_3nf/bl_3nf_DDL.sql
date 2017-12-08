drop table ce_orders;
DROP TABLE ce_customers;
DROP TABLE CE_hotels;
DROP TABLE ce_categories;
DROP TABLE ce_cards;
DROP TABLE ce_card_types;
DROP TABLE ce_banks;
DROP TABLE ce_addresses;
drop table ce_sources;
DROP TABLE CE_CITIES;
DROP TABLE CE_COUNTRIES;
DROP TABLE CE_SUBREGIONS;
DROP TABLE CE_REGIONS;

--------------------------------
DROP TABLE CE_REGIONS;
CREATE TABLE CE_REGIONS
  (
    REGION_3NF_ID NUMBER NOT NULL,
    REGION_CODE   VARCHAR2(3) NOT NULL,
    REGION_NAME   VARCHAR2(50) NOT NULL,
    CONSTRAINT REGION_ID_PK PRIMARY KEY ( REGION_3NF_ID ),
    CONSTRAINT CODE_UNQ UNIQUE ( REGION_CODE )
  );
--SELECT * FROM CE_REGIONS;
DROP SEQUENCE seq_regions_3nf;
CREATE SEQUENCE seq_regions_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT all ON seq_regions_3nf  TO BL_CL;

DROP TABLE CE_SUBREGIONS;
CREATE TABLE CE_SUBREGIONS
  (
    SUBREGION_3NF_ID NUMBER NOT NULL,
    SUBREGION_CODE   VARCHAR2(4) NOT NULL,
    SUBREGION_NAME   VARCHAR2(100) NOT NULL,
    REGION_ID        NUMBER NOT NULL,
    CONSTRAINT SUBREGION_ID_PK PRIMARY KEY ( SUBREGION_3NF_ID ),
    CONSTRAINT CODE_UNQ1 UNIQUE ( SUBREGION_CODE ),
    CONSTRAINT SUBREGION_FK FOREIGN KEY ( REGION_ID ) REFERENCES CE_REGIONS ( REGION_3NF_ID )
  );
DROP SEQUENCE seq_subregions_3nf;
CREATE SEQUENCE seq_subregions_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT all ON seq_subregions_3nf  TO BL_CL;
--sELECT * FROM CE_SUBREGIONS;
--SELECT * FROM CE_COUNTRIES;
---------------------------------------------
DROP TABLE CE_COUNTRIES;
CREATE TABLE CE_COUNTRIES
  (
    COUNTRY_3NF_ID NUMBER NOT NULL,
    COUNTRY_CODE2  VARCHAR2(10),
    COUNTRY_CODE3  VARCHAR2(10),
    COUNTRY_NAME   VARCHAR2(100) NOT NULL,
    SUBREGION_ID   NUMBER NOT NULL,
    CONSTRAINT COUNTRY_ID_PK PRIMARY KEY (COUNTRY_3NF_ID),
    CONSTRAINT CODE_UNQ3 UNIQUE ( COUNTRY_CODE3 ),
    CONSTRAINT CODE1_UNQ UNIQUE ( COUNTRY_name ),
    CONSTRAINT country_FK FOREIGN KEY ( SUBREGION_ID) REFERENCES CE_SUBREGIONS ( SUBREGION_3NF_ID )
  );
DROP SEQUENCE seq_countries_3nf;
CREATE SEQUENCE seq_countries_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT all ON seq_countries_3nf  TO BL_CL;
--SELECT* FROM CE_COUNTRIES;
---------------------------------------------
--TRUNCATE TABLE CE_REGIONS;
--TRUNCATE TABLE CE_SUBREGIONS;
--TRUNCATE TABLE CE_COUNTRIES;
----------------------------------------------
--SELECT *
--FROM CE_CITIES
--ORDER BY CITY_3NF_ID;
DROP TABLE CE_CITIES;
--TRUNCATE TABLE ce_cities;
CREATE TABLE CE_CITIES
  (
    CITY_3NF_ID NUMBER PRIMARY KEY,
    CITY_NAME   VARCHAR2(50),
    COUNTRY_ID  NUMBER,
    CONSTRAINT city_FK FOREIGN KEY ( country_ID) REFERENCES CE_countries ( country_3nf_ID )
  );
DROP SEQUENCE seq_cities_3nf;
CREATE SEQUENCE seq_cities_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT all ON seq_cities_3nf  TO BL_CL; 
--SELECT* FROM ce_addresses ORDER BY ADDRESS_ID;
 DROP SEQUENCE seq_addresses_3nf;
CREATE SEQUENCE seq_addresses_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
DROP TABLE ce_addresses;
GRANT all ON seq_addresses_3nf  TO BL_CL;
CREATE TABLE CE_ADDRESSES
  (
    ADDRESS_ID  NUMBER PRIMARY KEY,
    ADDRESS     VARCHAR2(90),
    CITY_ID     NUMBER ,--references dim_cities (city_id),
    POSTAL_CODE VARCHAR2(60),
    --phone varchar2(10),
    UPDATE_DT DATE,
    CONSTRAINT address_FK FOREIGN KEY ( city_ID) REFERENCES CE_cities ( city_3nf_ID )
  );
--COMMIT;

DROP TABLE  CE_SOURCES;
CREATE TABLE CE_SOURCES
        (
         SOURCE_3NF_ID NUMBER PRIMARY KEY,
         SOURCE_ID NUMBER,
         SITE VARCHAR2 ( 30 CHAR ) NOT NULL,
         VISITS NUMBER,
         TIME_ONLINE VARCHAR2(30),
         PAGE_VIEWS NUMBER,
         LEADING_COUNTRY varchar2(20),
         SOURCE_TAX NUMBER NOT NULL,
         UPDATE_DATE DATE
 
        );  
DROP SEQUENCE seq_sources_3nf;
CREATE SEQUENCE seq_sources_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT all ON seq_sources_3nf  TO BL_CL;
DROP TABLE CE_CARD_TYPES;
CREATE TABLE CE_CARD_TYPES
        (
        CARD_TYPE_3NF_ID NUMBER PRIMARY KEY,
        CCTYPE	VARCHAR2(250 CHAR) NOT NULL
        );
DROP SEQUENCE seq_card_types_3nf;
CREATE SEQUENCE seq_card_types_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT all ON seq_card_types_3nf  TO BL_CL;


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
DROP SEQUENCE seq_banks_3nf;
CREATE SEQUENCE seq_banks_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT all ON seq_banks_3nf  TO BL_CL;
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
DROP SEQUENCE seq_cards_3nf;
CREATE SEQUENCE seq_cards_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;       
GRANT all ON seq_cards_3nf  TO BL_CL;


DROP TABLE CE_CATEGORIES;
CREATE TABLE CE_CATEGORIES
  (
    CATEGORY_3NF_ID NUMBER PRIMARY KEY,
    CATEGORY_NAME VARCHAR2(10),
    MIN_STAR       NUMBER(3),
    MAX_STAR      NUMBER(3),
    START_DT date,
    END_DT date,
    IS_ACTIVE varchar2(3),
    UPDATE_DT date
  );
DROP SEQUENCE seq_categories_3nf;
CREATE SEQUENCE seq_categories_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;       
GRANT all ON seq_categories_3nf  TO BL_CL;


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
          REVIEWS_DATE	 date,
          REVIEWS_RATING  number,
          CONSTRAINT hotel1_FK FOREIGN KEY ( address_ID) 
          REFERENCES CE_addresses ( address_ID ),
          CONSTRAINT hotel2_FK FOREIGN KEY ( category_ID ) 
          REFERENCES CE_categories ( category_3nf_ID )
 
);
DROP SEQUENCE seq_hotels_3nf;
CREATE SEQUENCE seq_hotels_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT all ON seq_hotels_3nf TO BL_CL;

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
        age_group varchar2(25),
        birthday date,
        occupation varchar2(70),
        company varchar2(40),
        address_id number,-- number references dim_addresses(address_id),
        update_dt date,
        CONSTRAINT customer1_FK FOREIGN KEY ( address_ID) 
    REFERENCES CE_addresses ( address_ID )
);
------select*from ce_customers;
DROP SEQUENCE seq_customers_3nf;
CREATE SEQUENCE seq_customers_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT all ON seq_customers_3nf TO BL_CL;


--select count(* )from ce_orders;

drop table ce_orders;
CREATE TABLE ce_orders(
          customer_id number not null,
          order_date date not null,
          hotel_id number not null,
          source_id number not null,
          card_id number not null,
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
    CONSTRAINT order1_FK FOREIGN KEY ( card_ID) 
    REFERENCES CE_cards ( card_3nf_id),
    CONSTRAINT source_FK FOREIGN KEY ( source_ID) 
    REFERENCES CE_sources ( source_3nf_ID )--,
--    CONSTRAINT address_FK FOREIGN KEY ( city_ID) 
--    REFERENCES CE_cities ( city_3nf_ID )
);
--select * from ce_addresses;
--select * from ce_hotels;
--select * from ce_banks order by bank_3nf_id;
--select * from ce_card_types;
