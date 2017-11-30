DROP TABLE ce_products cascade constraints;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE ce_products
    (
        product_surr_id      NUMBER ( 10 )         NOT NULL,
        product_id           VARCHAR2 ( 100 )      NOT NULL,
        product_name         VARCHAR2 ( 200 CHAR ) NOT NULL,
        product_desc         VARCHAR2 ( 300 CHAR ) NOT NULL,
        price                NUMBER ( 20,2 )       NOT NULL,
        color_surr_id        NUMBER ( 10 )         NOT NULL,
        collection_surr_id   NUMBER ( 10 )         NOT NULL,
        subcategory_surr_id  NUMBER ( 10 )         NOT NULL,
        start_dt             DATE     DEFAULT '01-ßÍÂ-1990',
        end_dt               DATE     DEFAULT '31-ÄÅÊ-9999',
        is_active            VARCHAR2 ( 10 )       NOT NULL,
        
        CONSTRAINT PK_product_id_3nf       PRIMARY KEY ( product_surr_id ),
        CONSTRAINT UNQ_product_surr_id_3nf UNIQUE      ( product_id ),
        CONSTRAINT FK_color_id_3nf         FOREIGN KEY ( color_surr_id )
                   REFERENCES ce_colors                ( color_surr_id ),
        CONSTRAINT FK_collection_id_3nf    FOREIGN KEY ( collection_surr_id )
                   REFERENCES ce_collections           ( collection_surr_id ),
        CONSTRAINT FK_subcategory_id_3nf   FOREIGN KEY ( subcategory_surr_id )
                  REFERENCES ce_subcategories          ( subcategory_surr_id )      
        );
        
        
 