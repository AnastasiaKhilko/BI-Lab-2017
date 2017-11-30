DROP TABLE cls_date;

CREATE TABLE cls_date 
(
         date_dt              DATE            ,
         week_name            VARCHAR2( 25 )  ,
         week_number_of_month NUMBER  ( 10 )  ,
         week_number_of_year  NUMBER  ( 10 )  ,
         day_number_of_week   NUMBER  ( 10 )  ,
         day_number_of_month  NUMBER  ( 10 )  ,
         day_number_of_year   NUMBER  ( 10 )  ,
         month_year           VARCHAR2( 25 )  ,
         month_number         NUMBER  ( 10 )  ,
         month_name           VARCHAR2( 25 )  ,
         quarter              NUMBER  ( 10 )  ,         
         year_quater          VARCHAR2( 25 )  ,
         year                 NUMBER  ( 10 ) 
        );