DROP TABLE fct_sales CASCADE CONSTRAINTS;
ALTER SESSION SET nls_date_format = 'DD-MON-YYYY';
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
        insert_dt         DATE     DEFAULT '01-ЯНВ-1990',
        update_dt         DATE     DEFAULT '31-ДЕК-9999',
        
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
        )


/*   PARTITION BY RANGE (event_dt)
   SUBPARTITION BY LIST (payment_method)
   SUBPARTITION TEMPLATE 
      (SUBPARTITION cash        VALUES ('Наличные деньги') TABLESPACE tbs_cash,
       SUBPARTITION credit_card VALUES ('Кредитная карта') TABLESPACE tbs_card
      )
  (PARTITION year_10_13 VALUES LESS THAN ( TO_DATE('01-ЯНВ-2014','DD-MON-YYYY')),
   PARTITION year_14_16 VALUES LESS THAN ( TO_DATE('01-ЯНВ-2017','DD-MON-YYYY')),
   PARTITION q1_2017 VALUES LESS THAN ( TO_DATE('01-АПР-2017','DD-MON-YYYY')),
   PARTITION q2_2017 VALUES LESS THAN ( TO_DATE('1-ИЮЛ-2017','DD-MON-YYYY')),
   PARTITION q3_2017 VALUES LESS THAN ( TO_DATE('1-ОКТ-2017','DD-MON-YYYY')),
   PARTITION q4_2017 VALUES LESS THAN ( TO_DATE('1-ЯНВ-2018','DD-MON-YYYY'))
  )*/;