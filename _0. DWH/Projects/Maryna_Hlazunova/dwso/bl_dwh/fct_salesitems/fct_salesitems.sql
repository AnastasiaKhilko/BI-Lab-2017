/**===============================================*\
Name...............:   Cleansing table fct_salesitems BL_DWH layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   02-Dec-2017
\*=============================================== */
DROP TABLE fct_salesitems;
--**********************************************

CREATE TABLE fct_salesitems (
    dd_order_srcid           NUMBER(15),
    dim_order_date           DATE,
    dim_customer_surrid      NUMBER(12,0),
    dim_product_surrid       NUMBER(10),
    dim_paydelivery_surrid   NUMBER(2,0),
    dim_pickuppoint_surrid   NUMBER(3,0),
    fct_quantity             NUMBER(20),
    fct_item_sum             NUMBER(35,2),
    fct_discount_sum         NUMBER(35,2),
    fct_total_sum            NUMBER(35,2),
    insert_dt                DATE,
    CONSTRAINT fk_dim_order_date FOREIGN KEY ( dim_order_date )
        REFERENCES dim_dates ( full_date ),
    CONSTRAINT fk_dim_customer_surrid FOREIGN KEY ( dim_customer_surrid )
        REFERENCES dim_customers_scd ( customer_surrid ),
    CONSTRAINT fk_dim_product_surrid FOREIGN KEY ( dim_product_surrid )
        REFERENCES dim_products_scd ( product_surrid ),
    CONSTRAINT fk_dim_paydeliveries_surrid FOREIGN KEY ( dim_paydelivery_surrid )
        REFERENCES dim_paydeliveries ( paydelivery_surrid ),
    CONSTRAINT fk_dim_pickuppoints_surrid FOREIGN KEY ( dim_pickuppoint_surrid )
        REFERENCES dim_pickuppoints ( pickuppoint_surrid )
);

--**********************************************
--select * from cls2_products;