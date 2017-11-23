execute pckg_drop.drop_proc('ext_goroda', 'table');
CREATE TABLE ext_goroda
        (  geo_id NUMBER(8),
        city_name   VARCHAR2 ( 200 CHAR ),
         region_name   VARCHAR2 ( 200 CHAR ),
           district_name  VARCHAR2 ( 200 CHAR ),
           population    NUMBER ( 10 ),
           years  VARCHAR2( 10 )
         )
    ORGANIZATION EXTERNAL
        (Type oracle_loader
  default directory ETL
  access parameters (fields terminated by ';' )
  location ('goroda.csv')
)
reject limit unlimited;
/
select *
from ext_goroda;
