CREATE TABLE ce_store
  (
    Store_id              VARCHAR2(8) PRIMARY KEY,
    Store_name            VARCHAR2(30) NOT NULL,
    Store_email           VARCHAR2(50) NOT NULL,
    Store_phone           VARCHAR2(30) NOT NULL,
    Store_Manager_id         VARCHAR2(30) NOT NULL,
    Store_region_id       NUMBER(8) NOT NULL,
    Store_country_id      NUMBER(8) NOT NULL,
    Store_city_id         NUMBER(8) NOT NULL,
    Store_address_id      NUMBER(8) NOT NULL,
    Store_open_date       DATE NOT NULL,
    Store_last_repair_day DATE,
    CONSTRAINT fk_store_manag FOREIGN KEY (Store_Manager_id) REFERENCES ce_employee(employee_id),
    CONSTRAINT fk_store_region FOREIGN KEY (store_region_id) REFERENCES ce_region(region_id),
    CONSTRAINT fk_store_country FOREIGN KEY (store_country_id) REFERENCES ce_country(country_id),
    CONSTRAINT fk_store_city FOREIGN KEY (store_city_id) REFERENCES ce_city(city_id),
    CONSTRAINT fk_store_address FOREIGN KEY (store_address_id) REFERENCES ce_address(address_id)

  );
