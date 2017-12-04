/**===============================================*\
Name...............:   External table ext_locations SA_SRC layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   27-Nov-2017
\*=============================================== */
DROP TABLE ext_products;
--**********************************************
   CREATE TABLE ext_products
        ( product_code   varchar2 (8 char),
          vendor_code varchar2 (8 char) ,
          product_name varchar2 (100 char) ,
          product_color varchar2 (20 char) ,
          brand    VARCHAR2(5 char),
          type  VARCHAR2(4 char)
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_sources_dwh
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL 
         (product_code,
          vendor_code,
          product_name,
          product_color,
          brand,
          type)
             )
         LOCATION ('wb_products2.txt')
    )
    reject LIMIT unlimited;

--**********************************************   
--select count(*) from ext_products;
    
