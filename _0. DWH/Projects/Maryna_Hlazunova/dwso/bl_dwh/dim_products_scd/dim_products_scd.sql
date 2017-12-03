/**===============================================*\
Name...............:   Cleansing table dim_products_scd BL_DWH layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   02-Dec-2017
\*=============================================== */
DROP TABLE dim_products_scd;
--**********************************************

CREATE TABLE dim_products_scd (
    product_surrid        NUMBER(8) PRIMARY KEY,
    product_srcid         NUMBER(8) NOT NULL,
    product_desc          VARCHAR2(50) NOT NULL,
    product_vendorcode    VARCHAR2(8 CHAR) NOT NULL,
    product_color         VARCHAR2(25) NOT NULL,
    product_brand         VARCHAR2(100) NOT NULL,
    product_type          VARCHAR2(100) NOT NULL,
    product_subcategory   VARCHAR2(150) NOT NULL,
    product_category      VARCHAR2(50) NOT NULL,
    start_dt              DATE NOT NULL,
    end_dt                DATE NOT NULL,
    is_active             VARCHAR2(1 CHAR) NOT NULL,
    ta_insert_dt          DATE NOT NULL,
    ta_update_dt          DATE NOT NULL
)

--**********************************************
--select * from dim_products_scd;