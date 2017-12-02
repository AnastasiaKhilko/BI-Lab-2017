DROP TABLE fct_sales;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;
CREATE TABLE fct_sales
    (
        sales_id          NUMBER ( 10 )         NOT NULL,
        event_dt          DATE                  NOT NULL,
        product_id        NUMBER ( 10 )         NOT NULL,
        employee_id       NUMBER ( 10 )         NOT NULL,
        customer_id       NUMBER ( 10 )         NOT NULL,
        shop_id           NUMBER ( 10 )         NOT NULL,
        payment_method    VARCHAR2 ( 50 CHAR )  NOT NULL,
        unit_amount       NUMBER ( 10 )         NOT NULL,
        total_sum         NUMBER ( 38 )         NOT NULL,
        insert_dt         DATE     DEFAULT '01-ßÍÂ-1990',
        update_dt         DATE     DEFAULT '31-ÄÅÊ-9999',
        
        CONSTRAINT FK_event_dt_dm      FOREIGN KEY ( event_dt )
                    REFERENCES dim_time_day ( date_dt ),
        CONSTRAINT FK_product_id_dm    FOREIGN KEY ( product_id )
                    REFERENCES dim_products ( product_id ),
        CONSTRAINT FK_employee_id_dm   FOREIGN KEY ( employee_id )
                    REFERENCES dim_employees ( employee_id ),
        CONSTRAINT FK_customer_id_dm   FOREIGN KEY ( customer_id )
                    REFERENCES dim_customers ( customer_id ),   
        CONSTRAINT FK_store_id_dm      FOREIGN KEY ( shop_id )
                    REFERENCES dim_shops ( shop_id )          
        );
        
        
 