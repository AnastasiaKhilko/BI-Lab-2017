DROP TABLE ce_sales CASCADE CONSTRAINTS;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE ce_sales
    (
        sales_surr_id     NUMBER ( 10 )         NOT NULL,
        sales_number      NUMBER ( 38 )         NOT NULL,
        event_dt          DATE                  NOT NULL,
        product_surr_id   NUMBER ( 10 )         NOT NULL,
        employee_surr_id  NUMBER ( 10 )         NOT NULL,
        customer_surr_id  NUMBER ( 10 )         NOT NULL,
        shop_surr_id      NUMBER ( 10 )         NOT NULL,
        payment_method    VARCHAR2 ( 50 CHAR )  NOT NULL,
        unit_amount       NUMBER ( 10 )         NOT NULL,
        total_sum         NUMBER ( 38 )         NOT NULL,
        insert_dt         DATE     DEFAULT '01-ßÍÂ-1990',
        update_dt         DATE     DEFAULT '31-ÄÅÊ-9999',
        
        CONSTRAINT PK_sales_surr_id_3nf  PRIMARY KEY ( sales_surr_id ),
        CONSTRAINT FK_event_dt_3nf       FOREIGN KEY ( event_dt )
                    REFERENCES ce_date ( date_dt ),
        CONSTRAINT FK_product_id_3nf     FOREIGN KEY ( product_surr_id )
                    REFERENCES ce_products ( product_surr_id ),
        CONSTRAINT FK_employee_id_3nf    FOREIGN KEY ( employee_surr_id )
                    REFERENCES ce_employees ( employee_surr_id ),
        CONSTRAINT FK_customer_id_3nf    FOREIGN KEY ( customer_surr_id )
                    REFERENCES ce_customers ( customer_surr_id ),   
        CONSTRAINT FK_store_id_3nf       FOREIGN KEY ( shop_surr_id )
                    REFERENCES ce_shops ( shop_surr_id )          
        );
        
        
 