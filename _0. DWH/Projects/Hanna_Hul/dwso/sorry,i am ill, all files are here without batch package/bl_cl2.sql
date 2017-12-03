drop table cls_sources;
select * from cls_sources;
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
          HOTEL_3NF_ID NUMBER ,
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
        customer_3nf_id number not null,
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
        ADDRESS     VARCHAR2(90),-- number references dim_addresses(address_id),
        CITY_NAME    VARCHAR2(50),
        COUNTRY_NAME     VARCHAR2(100) NOT NULL,
        SUBREGION_NAME   VARCHAR2(100) NOT NULL,
         REGION_NAME   VARCHAR2(50) NOT NULL,
        update_dt date
);


select * from cls_date;
drop table cls_date;
CREATE TABLE cls_date(  
    Date_ID date not null,
    date_line varchar2(20),
    date_format varchar2(20),
    Week_Day_Full varchar2(20),
     Week_Day_Short varchar2(20),
     Day_Num_of_Week number,
    Day_Num_of_Month number,
    Day_Num_of_Year number,
    Month_ID varchar2(10),
     Month_Short varchar2(20),
    Month_Long varchar2(20),
    Month_Num_of_Year number,
     Quarter_ID varchar2(20),
    Quarter varchar2(20),
    Quarter_Num_of_Year number,
    Year_ID varchar2(20)
    --31 AS Year_Time_Span,
    --COUNT(*) OVER (PARTITION BY TO_CHAR(CurrDate,'YYYY')) AS Year_Time_Span,
    -- to_date('31-JAN-2010','DD-MON-YYYY') AS Year_End_Date
    --MAX(CurrDate) OVER (PARTITION BY TO_CHAR(CurrDate,'YYYY')) Year_End_Date
);
 -- ALTER TABLE dim_date ADD CONSTRAINT pk_date_id PRIMARY KEY (date_id);
  COMMIT;

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
execute immediate 'truncate table bl_dwh.ce_orders';
end;
/
commit;
truncate table ce_orders;
grant execute on do_truncate to bl_cl2;
select * from cls_orders;
drop table cls_orders;
CREATE TABLE cls_orders(
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
          discount number(10,2)--,
--          CONSTRAINT customer_FK FOREIGN KEY ( customer_ID) 
--    REFERENCES dwh_customers ( customer_dwh_ID ),
--    CONSTRAINT hotel_FK FOREIGN KEY ( hotel_ID) 
--    REFERENCES dwh_hotels( SOURCE_dwh_ID ),
----    CONSTRAINT address_FK FOREIGN KEY ( address_ID) 
----    REFERENCES CE_addresses ( address_3nf_ID ),
--    CONSTRAINT source_FK FOREIGN KEY ( source_ID) 
--    REFERENCES dwh_sources ( source_dwh_ID )--,
--    CONSTRAINT address_FK FOREIGN KEY ( city_ID) 
--    REFERENCES CE_cities ( city_3nf_ID )
);