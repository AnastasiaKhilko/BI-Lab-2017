CREATE TABLE ce_customer
  (
    Customer_id         VARCHAR2(8) PRIMARY KEY,
    Customer_name       VARCHAR2(30) NOT NULL,
    Customer_surname    VARCHAR2(30) NOT NULL,
    Customer_email      VARCHAR2(50) NOT NULL,
    Customer_phone      VARCHAR2(30) NOT NULL,
    Customer_age        NUMBER(3) NOT NULL,
    Customer_gender     VARCHAR2(10) NOT NULL,
    Customer_card       VARCHAR2(30) NOT NULL,
    Customer_company    VARCHAR2(100) NOT NULL,
    Customer_occupation VARCHAR2(100) NOT NULL,
    Customer_vehicle    VARCHAR2(50) NOT NULL,
    Customer_region_id  NUMBER(8) NOT NULL,
    Customer_country_id NUMBER(8) NOT NULL,
    Customer_city_id    NUMBER(8) NOT NULL,
    Customer_address_id NUMBER(8) NOT NULL,
    CONSTRAINT fk_cust_card FOREIGN KEY ( Customer_card) REFERENCES ce_customer_card(Customer_card),
    CONSTRAINT fk_cust_region FOREIGN KEY (customer_region_id) REFERENCES ce_region(region_id),
    CONSTRAINT fk_cust_country FOREIGN KEY (customer_country_id) REFERENCES ce_country(country_id),
    CONSTRAINT fk_cust_city FOREIGN KEY (customer_city_id) REFERENCES ce_city(city_id),
    CONSTRAINT fk_cust_address FOREIGN KEY (customer_address_id) REFERENCES ce_address(address_id)
  );
