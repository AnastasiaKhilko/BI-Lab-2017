drop table cls_sources;
CREATE TABLE cls_SOURCES
        (
         SOURCE_3NF_ID NUMBER not null,
         SOURCE_ID NUMBER,
         SITE VARCHAR2 ( 30 CHAR ) NOT NULL,
         VISITS NUMBER,
         TIME_ONLINE VARCHAR2(30),
         PAGE_VIEWS NUMBER,
         LEADING_COUNTRY VARCHAR2 ( 30 CHAR ),
         SOURCE_TAX NUMBER NOT NULL,
         UPDATE_DATE DATE
        );     

select *from cls_CARDS ;
DROP TABLE Cls_CARDS;
CREATE TABLE Cls_CARDS
        (
        CARD_3NF_ID NUMBER PRIMARY KEY,
        BANK_NAME	VARCHAR2(250 CHAR) NOT NULL,
        start_dt date,
        end_dt date,
       is_active varchar2(3) ,
        discount number,
        CCTYPE	VARCHAR2(250 CHAR) NOT NULL,
        CVV2	VARCHAR2(250 CHAR),
        CCNUMBER	VARCHAR2(250 CHAR) NOT NULL,
        CCEXPIRES	VARCHAR2(250 CHAR)--,
--        CONSTRAINT bank_FK FOREIGN KEY ( BANK_ID ) 
--        REFERENCES CE_BANKS ( BANK_3NF_ID ),
--        CONSTRAINT type_FK FOREIGN KEY ( CCTYPE_ID ) 
--        REFERENCES CE_CARD_TYPES ( CARD_TYPE_3NF_ID )
        );

DROP TABLE Cls_HOTELS;
CREATE TABLE Cls_HOTELS
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

commit;

drop table cls_customers;
CREATE TABLE cls_customers(
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