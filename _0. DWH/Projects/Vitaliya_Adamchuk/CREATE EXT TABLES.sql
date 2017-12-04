CREATE OR REPLACE DIRECTORY external_location_tables
AS
  '/media/sf_MY/location';
CREATE OR REPLACE DIRECTORY external_manag_tables
AS
  '/media/sf_MY/managers';
CREATE OR REPLACE DIRECTORY external_orders
AS
  '/media/sf_MY/orders';
CREATE OR REPLACE DIRECTORY external_returned_orders
AS
  '/media/sf_MY/returned_ord';
  -- ext_geo_countries_iso3166.
  CREATE TABLE EXT_COUNTRIES
    (
      COUNTRY_ID   NUMBER ( 10 ),
      COUNTRY_DESC VARCHAR2 ( 200 CHAR ),
      COUNTRY_CODE VARCHAR2 ( 3 )
    )
    organization external
    (
      type ORACLE_LOADER DEFAULT directory external_location_tables access parameters (RECORDS DELIMITED BY 0x'0D0A' NOBADFILE NODISCARDFILE NOLOGFILE FIELDS TERMINATED BY ';' MISSING FIELD VALUES ARE NULL (COUNTRY_ID INTEGER external (4), COUNTRY_DESC CHAR(200), COUNTRY_CODE CHAR(3) ) ) location ('iso_3166.tab')
    )
    reject limit unlimited;
  -- ext_cntr2structure_iso3166.
  CREATE TABLE EXT_FULL_DATA
    (
      COUNTRY_ID     NUMBER(10,0),
      COUNTY_DESC    VARCHAR2(200 CHAR),
      STRUCTURE_CODE NUMBER(10,0),
      STRUCTURE_DESC VARCHAR2(200 CHAR)
    )
    organization external
    (
      type ORACLE_LOADER DEFAULT directory external_location_tables access parameters (RECORDS DELIMITED BY 0x'0D0A' NOBADFILE NODISCARDFILE NOLOGFILE FIELDS TERMINATED BY ';' MISSING FIELD VALUES ARE NULL (COUNTRY_ID INTEGER external (4), COUNTY_DESC CHAR(200), STRUCTURE_CODE INTEGER external, STRUCTURE_DESC CHAR(200) ) ) location ('iso_3166_geo_un_contries.tab')
    )
    reject limit unlimited;
  -- ext_geo_structure_iso3166.
  CREATE TABLE EXT_STRUCTURES
    (
      CHILD_CODE      NUMBER(10,0),
      PARENT_CODE     NUMBER(10,0),
      STRUCTURE_DESC  VARCHAR2(200 CHAR),
      STRUCTURE_LEVEL VARCHAR2(200 CHAR)
    )
    organization external
    (
      type ORACLE_LOADER DEFAULT directory external_location_tables 
      access parameters (RECORDS DELIMITED BY 0x'0D' NOBADFILE NODISCARDFILE NOLOGFILE FIELDS TERMINATED BY ';'
      MISSING FIELD VALUES ARE NULL 
      (CHILD_CODE INTEGER external (4),
      PARENT_CODE INTEGER external, 
      STRUCTURE_DESC CHAR(200), 
      STRUCTURE_LEVEL CHAR(200) ) )
      location ('iso_3166_geo_un.tab')
    )
    reject limit unlimited;
    
  -- ext_managers
    create table EXT_MANAGERS
        (
		region varchar2 ( 100 char ),
        last_name varchar2 ( 100 char )
         )
    organization external
        (TYPE ORACLE_LOADER DEFAULT DIRECTORY external_manag_tables
                         ACCESS PARAMETERS (FIELDS TERMINATED BY ',')
                         LOCATION ('managers_by_regions.csv'                              )
    )
    reject limit unlimited;
    
COMMIT;
     -- ext_ret_orders
     create table EXT_RET_ORDERS
        (
        ORDER_ID NUMBER(10,0),
        STATUS varchar2 ( 100 char )
         )
    organization external
        (TYPE ORACLE_LOADER DEFAULT DIRECTORY external_returned_orders
                         ACCESS PARAMETERS (FIELDS TERMINATED BY ',')
                         LOCATION ('returned_orders.csv'))
    reject limit unlimited;
    
COMMIT;
    

    -- ext_orders
    CREATE TABLE EXT_ORDERS
      (
        ORDER_ID              NUMBER (10),
        ORDER_DATE            VARCHAR2 ( 15 CHAR ),
        ORDER_PRIORITY        VARCHAR2 ( 50 CHAR ),
        ORDER_QUANTITY        NUMBER (10),
        SALES                 NUMBER (8, 2),
        DISCOUNT              NUMBER (8, 2),
        SHIP_MODE             VARCHAR2 ( 50 CHAR ),
        PROFIT                NUMBER (8, 2), 
        UNIT_PRICE            NUMBER (8, 2), 
        SHIPPING_COST         NUMBER (8, 2), 
        CUSTOMER_NAME         VARCHAR2 (200 CHAR ),
        PROVINCE              VARCHAR2 (100 CHAR ),
        REGION                VARCHAR2 (200 CHAR ),
        CUSTOMER_SEGMENT      VARCHAR2 (300 CHAR ),
        PRODUCT_CATEGORY      VARCHAR2 (300 CHAR ),
        PRODUCT_SUB_CATEGORY  VARCHAR2 (600 CHAR ),
        PRODUCT_NAME          VARCHAR2 (900 CHAR ),
        PRODUCR_CONTAINER     VARCHAR2 (100 CHAR ),
        PRODUCT_BASE_MARGIN   NUMBER (2, 2), 
        SHIP_DATE             VARCHAR2 ( 50 CHAR )
      )
      organization external
      (
        TYPE ORACLE_LOADER DEFAULT DIRECTORY external_orders ACCESS PARAMETERS (FIELDS TERMINATED BY ',') LOCATION ('orders_info2.csv' )
      )
      reject limit unlimited;
    COMMIT;
