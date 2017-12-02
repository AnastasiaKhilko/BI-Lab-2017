DROP TABLE cls_dim_shops;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE cls_dim_shops
    (
        shop_id               NUMBER ( 10 )          NOT NULL,
        shop_name             VARCHAR2 ( 100  CHAR ) NOT NULL,
        phone                 VARCHAR2 ( 50 CHAR )   NOT NULL,
        address               VARCHAR2 ( 200 CHAR )  NOT NULL,
        city_id               NUMBER   ( 10 )        NOT NULL,
        city_name             VARCHAR2 ( 200 CHAR )  NOT NULL,
        region_id             NUMBER   ( 10 )        NOT NULL,
        region_name           VARCHAR2 ( 200 CHAR )  NOT NULL,
        manager_id            NUMBER   ( 10 )        NOT NULL,
        manager_last_name     VARCHAR2 ( 100 CHAR )  NOT NULL,
        manager_first_name    VARCHAR2 ( 100 CHAR )  NOT NULL,
        manager_middle_name   VARCHAR2 ( 100 CHAR )  NOT NULL,
        manager_gender        VARCHAR2 ( 50 CHAR )   NOT NULL 
    );