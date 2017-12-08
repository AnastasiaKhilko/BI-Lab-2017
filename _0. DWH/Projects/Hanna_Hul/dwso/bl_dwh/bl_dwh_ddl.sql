DROP TABLE fct_orders;
DROP TABLE dim_cards;
DROP TABLE dim_sources;
DROP TABLE dim_hotels;
DROP TABLE dim_customers;
drop table dim_date;
CREATE TABLE dim_cards
  (
    CARD_dwh_ID NUMBER PRIMARY KEY,
    CARD_3NF_ID NUMBER NOT NULL,
    BANK_NAME   VARCHAR2(250 CHAR) NOT NULL,
    start_dt    DATE,
    end_dt      DATE,
    is_active   VARCHAR2(3) ,
    discount    NUMBER,
    CCTYPE      VARCHAR2(250 CHAR) NOT NULL,
    CVV2        VARCHAR2(250 CHAR),
    CCNUMBER    VARCHAR2(250 CHAR) NOT NULL,
    CCEXPIRES   VARCHAR2(250 CHAR)
  );
DROP SEQUENCE seq_cards_dwh;
CREATE SEQUENCE seq_cards_dwh INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT SELECT ON seq_cards_dwh TO BL_CL2;

  CREATE TABLE dim_sources
    (
      SOURCE_dwh_ID   NUMBER PRIMARY KEY,
      SOURCE_3NF_ID   NUMBER NOT NULL,
      SOURCE_ID       NUMBER,
      SITE            VARCHAR2 ( 30 CHAR ) NOT NULL,
      VISITS          NUMBER,
      TIME_ONLINE     VARCHAR2(30),
      PAGE_VIEWS      NUMBER,
      LEADING_COUNTRY VARCHAR2 ( 30 CHAR ),
      SOURCE_TAX      NUMBER NOT NULL,
      UPDATE_DATE     DATE
    );
  DROP SEQUENCE seq_source_dwh;
CREATE SEQUENCE seq_source_dwh INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  GRANT ALL ON seq_source_dwh TO BL_CL2;
  --commit;
  --truncate table dim_hotels;
 
  drop table dim_hotels;
  CREATE TABLE dim_hotels
    (
      hotel_dwh_ID  NUMBER PRIMARY KEY,
      HOTEL_3NF_ID   NUMBER,
      HOTEL_CODE     VARCHAR2(10),
      HOTEL_NAME     VARCHAR2(200),
      CATEGORY_NAME    varchar2(30),
      ADDRESS_ID     NUMBER,
      EMAIL          VARCHAR2 ( 200 CHAR ),
      UPDATE_DT      DATE,
      REVIEWS_DATE   DATE,
      REVIEWS_RATING NUMBER
    );
  DROP SEQUENCE seq_hotels_dwh;
CREATE SEQUENCE seq_hotels_dwh INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  GRANT ALL ON seq_hotels_dwh TO BL_CL2;
  --truncate table dim_customers;
  --select * from dim_customers;
  drop table dim_customers;
  CREATE TABLE dim_customers
    (
      customer_dwh_id  NUMBER PRIMARY KEY,
      customer_3nf_id  NUMBER NOT NULL,
      customer_id      NUMBER,
      gender           VARCHAR2(6),
      name             VARCHAR2(20),
      surname          VARCHAR2(20),
      title            VARCHAR2(4),
      email            VARCHAR2(40),
      telephone_number VARCHAR2(20),
      age              NUMBER (2),
      age_group        VARCHAR2(20),
      birthday         DATE,
      occupation       VARCHAR2(70),
      company          VARCHAR2(40),
      ADDRESS          VARCHAR2(90),-- number references dim_addresses(address_id),
      CITY_NAME        VARCHAR2(50),
      COUNTRY_NAME     VARCHAR2(100) NOT NULL,
      SUBREGION_NAME   VARCHAR2(100) NOT NULL,
      REGION_NAME      VARCHAR2(50) NOT NULL,
      update_dt        DATE
    );
GRANT ALL ON dim_customers TO BL_CL2;
DROP SEQUENCE seq_cust_dwh;
CREATE SEQUENCE seq_cust_dwh INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT ALL ON seq_cust_dwh TO BL_CL2;
  --commit;
  --select * from dim_date;

  CREATE TABLE dim_date
    (
      Date_ID             DATE PRIMARY KEY,
      date_line           VARCHAR2(20),
      date_format         VARCHAR2(20),
      Week_Day_Full       VARCHAR2(20),
      Week_Day_Short      VARCHAR2(20),
      Day_Num_of_Week     NUMBER,
      Day_Num_of_Month    NUMBER,
      Day_Num_of_Year     NUMBER,
      Month_ID            VARCHAR2(10),
      Month_Short         VARCHAR2(20),
      Month_Long          VARCHAR2(20),
      Month_Num_of_Year   NUMBER,
      Quarter_ID          VARCHAR2(20),
      Quarter             VARCHAR2(20),
      Quarter_Num_of_Year NUMBER,
      Year_ID             VARCHAR2(20)
    );

  --SELECT* FROM fact_orders;
  CREATE TABLE fct_orders
    (
      customer_id   NUMBER NOT NULL,
      order_date    DATE NOT NULL,
      hotel_id      NUMBER NOT NULL,
      source_id     NUMBER NOT NULL,
      card_id number not null,
      check_in_date DATE NOT NULL,
      days_amount   NUMBER,
      amount        NUMBER,
      room_type     VARCHAR2(15),
      number_of_people NUMBER,
      discount         NUMBER(10,2),
      CONSTRAINT customer_FK FOREIGN KEY ( customer_ID) REFERENCES dim_customers ( customer_dwh_ID ),
      CONSTRAINT hotel_FK FOREIGN KEY ( hotel_ID) REFERENCES dim_hotels( hotel_dwh_ID ),
      CONSTRAINT source_FK FOREIGN KEY ( SOURCE_ID ) REFERENCES dim_sources ( source_dwh_ID ),--,
      CONSTRAINT date1_FK FOREIGN KEY ( order_date ) REFERENCES dim_date ( date_ID ),
      CONSTRAINT date2_FK FOREIGN KEY ( check_in_date ) REFERENCES dim_date ( date_ID ),
      CONSTRAINT cards_FK FOREIGN KEY ( CARD_ID ) REFERENCES dim_cards ( card_dwh_ID )
    );
