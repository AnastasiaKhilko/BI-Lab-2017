/**===============================================*\
Name...............:   External table ext_locations SA_SRC layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   27-Nov-2017
\*=============================================== */
DROP TABLE ext_refer_products;
--**********************************************
   CREATE TABLE ext_refer_products
        (type_code VARCHAR2 (5 CHAR),
         type   VARCHAR2 (100 CHAR),
         subcat_code VARCHAR2 (5 CHAR),
         subcategory   VARCHAR2 (100 CHAR),
         cat_code VARCHAR2 (3 CHAR),
         category   VARCHAR2 (100 CHAR)
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_sources_dwh
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL 
                (type_code,
                 type,
                 subcat_code,
                 subcategory,
                 cat_code,
                 category)
             )
         LOCATION ('wb_prod_types.txt')
    )
    reject LIMIT unlimited;
--**********************************************    
--select * from ext_refer_products;