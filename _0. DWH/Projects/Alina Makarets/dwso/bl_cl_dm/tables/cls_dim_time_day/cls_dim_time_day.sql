DROP TABLE cls_dim_time_day;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE cls_dim_time_day 
(
         date_dt              DATE            NOT NULL,
         week_number          NUMBER  ( 10 )  NOT NULL,
         week_name            VARCHAR2( 25 )  NOT NULL,
         week_of_year         NUMBER  ( 10 )  NOT NULL,
         day_number_of_week   NUMBER  ( 10 )  NOT NULL,
         day_number_of_month  NUMBER  ( 10 )  NOT NULL,
         day_number_of_year   NUMBER  ( 10 )  NOT NULL,
         month_year           VARCHAR2( 25 )  NOT NULL,
         month_number         NUMBER  ( 10 )  NOT NULL,
         month_name           VARCHAR2( 25 )  NOT NULL,
         first_day_of_month   DATE            NOT NULL,
         last_day_of_month    DATE            NOT NULL,
         quarter              NUMBER  ( 10 )  NOT NULL,         
         year_quater          VARCHAR2( 25 )  NOT NULL,
         year                 NUMBER   ( 10 ) NOT NULL
        );