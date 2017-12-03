/**===============================================*\
Name...............:   Normalized table ce_fct_orders 3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   30-Nov-2017
\*=============================================== */
DROP TABLE ce_fct_orders;
--**********************************************

CREATE TABLE ce_fct_orders (
    order_id     NUMBER(15) PRIMARY KEY,
    order_code   VARCHAR2(10 CHAR),
    order_date   DATE,
    cust_id      NUMBER(12,0),
    del_id       NUMBER(2,0),
    pay_id       NUMBER(2,0),
    point_id     NUMBER(3,0),
    insert_dt    DATE,
    CONSTRAINT fk_or_cust_id FOREIGN KEY ( cust_id )
        REFERENCES ce_customers ( customer_id ),
    CONSTRAINT fk_or_del_id FOREIGN KEY ( del_id )
        REFERENCES ce_deliveries ( del_id ),
    CONSTRAINT fk_or_pay_id FOREIGN KEY ( pay_id )
        REFERENCES ce_payoptions ( pay_id ),
    CONSTRAINT fk_or_point_id FOREIGN KEY ( point_id )
        REFERENCES ce_pickuppoints ( point_id )
);
--**********************************************
-- SELECT  *  FROM   ce_fct_orders;