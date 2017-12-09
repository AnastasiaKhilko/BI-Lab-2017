-- WRK_SELLERS.
DROP TABLE wrk_sellers;
CREATE TABLE wrk_sellers
(
 seller_code        VARCHAR2 ( 100 CHAR ),
 first_name           VARCHAR2 ( 100 CHAR ),
 last_name            VARCHAR2 ( 100 CHAR ),
 gender               VARCHAR2 ( 50 CHAR ),
 age                  VARCHAR2 ( 40 CHAR ),
 email                VARCHAR2 ( 100 CHAR ),
 phone                VARCHAR2 ( 100 CHAR ),
 address              VARCHAR2 ( 100 CHAR ),
 city                 VARCHAR2 ( 100 CHAR ),
 country_id          VARCHAR2 ( 20 CHAR ),
 start_dt             DATE,
 end_dt               DATE,
 is_active            VARCHAR2 ( 100 CHAR )
);