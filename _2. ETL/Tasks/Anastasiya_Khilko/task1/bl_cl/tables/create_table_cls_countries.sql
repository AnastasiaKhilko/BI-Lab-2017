--execute pckg_drop.DROP_Proc('TABLE', 'cls_countries');
--drop table cls_countries cascade constraints;
CREATE TABLE cls_countries
        (country_id     NUMBER ( 10 ),
         country_desc   VARCHAR2 ( 200 CHAR ),
         country_code   VARCHAR2 ( 3 )
        ); 
        