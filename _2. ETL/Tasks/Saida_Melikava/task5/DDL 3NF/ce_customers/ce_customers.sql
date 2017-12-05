EXECUTE pckg_drop.drop_proc(object_name=>'ce_customers', object_type=>'table');
CREATE TABLE ce_customers
  (
    Customer_id      NUMBER(8) PRIMARY KEY,
    Customer_code    VARCHAR2(30) NOT NULL,
    Customer_name    VARCHAR2(30) NOT NULL,
    Customer_surname VARCHAR2(30) NOT NULL,
    Customer_email   VARCHAR2(50) NOT NULL,
    Customer_phone   VARCHAR2(30) NOT NULL,
    Customer_card    VARCHAR2(30) NOT NULL,
    Customer_city_id NUMBER(8) NOT NULL,
    insert_DT        DATE DEFAULT(sysdate) NOT NULL ,
    update_DT        DATE DEFAULT(sysdate) NOT NULL 
  );
ALTER TABLE ce_customers ADD CONSTRAINT fk_cust_address FOREIGN KEY (Customer_city_id) REFERENCES ce_cities(city_id);
