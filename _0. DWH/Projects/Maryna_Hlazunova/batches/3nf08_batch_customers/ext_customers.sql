/**===============================================*\
Name...............:   External table ext_customers SA_SRC layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   25-Nov-2017
\*=============================================== */
--==============================================================
DROP TABLE ext_customers;
--**********************************************
   CREATE TABLE ext_customers
        (nat_code number(8),
         customer_name VARCHAR2 (200 CHAR),
         birthdate VARCHAR2 (10 CHAR),
         locality VARCHAR2 (100 CHAR),
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
                (nat_code,
                 customer_name,
                 birthdate,
                 locality,
                 street,
                 house,
                 appartment,
                 discount)
                 )
         LOCATION ('wb_customers.txt')
     --    LOCATION ('wb_customers_1.txt','wb_customers_2.txt', 'wb_customers_3.txt')
    )
    reject LIMIT unlimited;
--********************************************** 
-- select count(*) from ext_customers;
