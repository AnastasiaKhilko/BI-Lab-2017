--DIRECTORY.
CREATE OR REPLACE DIRECTORY ext_tables AS '/media/sf_Aksana_Kuratnik';

--TABLE ext_geo_countries_iso3166.
    CREATE TABLE ext_geo_countries_iso3166
        (country_id     NUMBER ( 10 ),
         country_desc   VARCHAR2 ( 200 CHAR ),
         country_code   VARCHAR2 ( 3 )
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL 
                (country_id integer external (4),
                 country_desc char(200),
                 country_code char(3) )
             )
         LOCATION ('iso_3166.tab')
    )
    reject LIMIT unlimited;

--TABLE ext_geo_structure_iso3166
    create table ext_geo_structure_iso3166  
          (child_code           NUMBER(10,0),
           parent_code          NUMBER(10,0),
           structure_desc       VARCHAR2(200 CHAR),
           structure_level      VARCHAR2(200 CHAR)
           )
    ORGANIZATION EXTERNAL (
        TYPE ORACLE_LOADER
        DEFAULT DIRECTORY ext_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL
                  (child_code integer external (4),
                   parent_code integer external,
                   structure_desc char(200),
                   structure_level char(200) )
             )
        location ('iso_3166_geo_un.tab')
    )
    reject limit unlimited;

--TABLE ext_cntr2structure_iso3166.
    create table ext_cntr2structure_iso3166
          (country_id           NUMBER(10,0),
           county_desc          VARCHAR2(200 CHAR),
           structure_code       NUMBER(10,0),
           structure_desc       VARCHAR2(200 CHAR)
           )
    ORGANIZATION EXTERNAL (
        TYPE ORACLE_LOADER
        DEFAULT DIRECTORY ext_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL
                  (country_id integer external (4),
                   county_desc char(200),
                   structure_code integer external,
                   structure_desc char(200) )
             )
        location ('iso_3166_geo_un_contries.tab')
    )
    reject limit unlimited;
    
--TABLE tmp_products.
 CREATE TABLE tmp_products
  (
    product_name    VARCHAR2 ( 100 )
  , product_type    VARCHAR2 ( 100 )
  , volume          NUMBER
  , price_per_litre NUMBER
  ) ;
  
 --TABLE  tmp_customers
 CREATE TABLE tmp_customers AS
 SELECT cust.FIRST_NAME
, cust.last_name
, cntr.country_desc
, cust.sex
   FROM
  (SELECT --+no_merge
    E2.FIRST_NAME
  , E1.LAST_NAME
  , ROUND ( dbms_random.value ( 0.51, 241.49 ) )           AS cntr_id
  , DECODE ( ROUND ( dbms_random.value ), 0, 'M', 1, 'F' ) AS sex
     FROM hr.employees e1
  , hr.employees e2
  , ( SELECT level FROM dual CONNECT BY level <= 10
    )
  ) cust
, (SELECT rownum rn
  , country_desc
     FROM ext_geo_countries_iso3166
 ORDER BY country_desc
  ) cntr
  WHERE cust.cntr_id = cntr.rn;


 SELECT MIN ( q )
   FROM
  ( SELECT dbms_random.value ( 1, 241 ) q FROM dual CONNECT BY level
    <= 10000
  ) ;


--TABLE tmp_sales.
 CREATE TABLE tmp_sales
  (
    event_dt    DATE
  , product_id  NUMBER
  , customer_id NUMBER
  , quantity    NUMBER
  , amount      NUMBER
  , discount    NUMBER
  ) ;
BEGIN

  FOR i IN 1..50
  LOOP
    dbms_random.seed
    (
      i * 5
    )
    ;

     INSERT INTO tmp_sales
     SELECT sls.event_dt
    , sls.product_id
    , sls.customer_id
    , sls.quantity
    , ( sls.quantity * prd.price_per_litre * prd.volume ) * ( 1 - (
      sls.discount   / 100 ) ) AS amount
    , sls.discount
       FROM
      (SELECT --+no_merge
        TRUNC ( sysdate - dbms_random.value ( 1, 1700 ) ) AS event_dt
      , ROUND ( dbms_random.value ( 0.51, ( SELECT COUNT ( * ) FROM
          tmp_products
        ) + .49 ) ) AS product_id
      , ROUND ( dbms_random.value ( 0.51, ( SELECT COUNT ( * ) FROM
          tmp_customers
        ) + .49 ) )                                 AS customer_id
      , ROUND ( dbms_random.value ( 0.51, 50.49 ) ) AS quantity
      , ceil ( dbms_random.value ( 1, 10 ) ) discount
         FROM dual
        CONNECT BY level <= 100000
      ) sls
    , ( SELECT rownum product_id, t.* FROM tmp_products t ORDER BY
        PRODUCT_NAME
      ) prd
      WHERE sls.product_id = prd.product_id;

  END LOOP;

END;
/

 SELECT * FROM tmp_sales;   



