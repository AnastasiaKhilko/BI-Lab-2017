/**===============================================*\
Name...............:   External tables SA_SRC layer
Contents...........:   Create tables and grants description
Author.............:   Maryna Hlazunova
Date...............:   22-Nov-2017
\*=============================================== */

--==============================================================
-- Table: ext_prod_types
--==============================================================
DROP TABLE ext_prod_types;
--**********************************************
   CREATE TABLE ext_prod_types
        (num_code number(5),
         type_desc   VARCHAR2 ( 100 CHAR ),
         subcategory_desc   VARCHAR2 ( 100 CHAR ),
         category_desc   VARCHAR2 ( 100 CHAR )
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_sources_dwh
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL 
                (num_code,
                 type_desc,
                 subcategory_desc,
                 category_desc)
             )
         LOCATION ('wb_prod_types.txt')
    )
    reject LIMIT unlimited;
    
    select * from ext_prod_types;
    
--grants
GRANT SELECT ON ext_prod_types TO BL_CL;
--==============================================================
-- Table: ext_brands
--==============================================================
DROP TABLE ext_brands;
--**********************************************
   CREATE TABLE ext_brands
        (num_code number(6),
         brand_desc   VARCHAR2 ( 100 CHAR )
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_sources_dwh
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL 
                (num_code,
                 brand_desc)
             )
         LOCATION ('wb_brands.txt')
    )
    reject LIMIT unlimited;
    
    select * from ext_brands;
    
--grants
GRANT SELECT ON ext_brands TO BL_CL;
--==============================================================
-- Table: ext_products
--==============================================================
DROP TABLE ext_products;
--**********************************************
   CREATE TABLE ext_products
        ( num_code   number(6),
          product_name varchar2 (100 char) ,
          product_code varchar2 (8 char) ,
          product_color varchar2 (20 char) ,
          brand_id     number(5) ,
          category_id  number (3)
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_sources_dwh
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL 
         (num_code,
          product_code,
          product_name,
          product_color,
          brand_id,
          category_id)
             )
         LOCATION ('wb_products.txt')
    )
    reject LIMIT unlimited;
    
    select * from ext_products;

--grants
GRANT SELECT ON ext_products TO BL_CL;
--==============================================================
-- Table: ext_delivery_payment
--==============================================================
DROP TABLE ext_delivery_payment;
--**********************************************
   CREATE TABLE ext_delivery_payment
        (num_code number(5),
         delivery   VARCHAR2 (100 CHAR),
         payoption   VARCHAR2 (100 CHAR)
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_sources_dwh
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL 
                (num_code,
                 delivery ,
                 payoption )
             )
         LOCATION ('wb_delivery_payment.txt')
    )
    reject LIMIT unlimited;
    
    select * from ext_delivery_payment;
    
--grants
GRANT SELECT ON ext_delivery_payment TO BL_CL;
--==============================================================
-- Table: ext_locations
--==============================================================
DROP TABLE ext_locations;
--**********************************************
   CREATE TABLE ext_locations
        (num_code number(12),
         location_name   VARCHAR2 (100 CHAR),
         location_type VARCHAR2 (100 CHAR),
         district VARCHAR2 (100 CHAR),
         region VARCHAR2 (100 CHAR)
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_sources_dwh
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL 
                (num_code,
                 location_name,
                 location_type,
                 district,
                 region)
             )
         LOCATION ('wb_locations.txt')
    )
    reject LIMIT unlimited;
    
    select * from ext_locations;
    
--grants
GRANT SELECT ON ext_locations TO BL_CL;

--==============================================================
-- Table: ext_pickuppoints
--==============================================================
DROP TABLE ext_pickuppoints;
--**********************************************
   CREATE TABLE ext_pickuppoints
        (num_code number(2),
         address   VARCHAR2 (300 CHAR)
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_sources_dwh
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL 
                (num_code,
                 address)
             )
         LOCATION ('wb_pickuppoints.txt')
    )
    reject LIMIT unlimited;
    
    select * from ext_pickuppoints;
    
--grants
GRANT SELECT ON ext_pickuppoints TO BL_CL;
--==============================================================
-- Table: ext_customers
--==============================================================
DROP TABLE ext_customers;
--**********************************************
   CREATE TABLE ext_customers
        (num_code number(8),
         customer_name VARCHAR2 (200 CHAR),
         birthdate VARCHAR2 (10 CHAR),
         location VARCHAR2 (100 CHAR),
         street VARCHAR2 (100 CHAR),
         house number(2),
         appartment number(3),
         discount number(2)
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_sources_dwh
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are NULL 
                (num_code,
                 customer_name,
                 birthdate,
                 location,
                 street,
                 house,
                 appartment,
                 discount)
                 )
         LOCATION ('wb_customers_1.txt','wb_customers_2.txt', 'wb_customers_3.txt')
    )
    reject LIMIT unlimited;
    
select * from ext_customers;

--grants
GRANT SELECT ON ext_customers TO BL_CL;