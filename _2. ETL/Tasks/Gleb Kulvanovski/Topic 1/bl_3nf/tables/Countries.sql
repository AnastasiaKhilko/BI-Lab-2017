EXEC system.pckg_drop.DROP_Proc('Countries', 'Table'); 
CREATE TABLE Countries (
  Country_id NUMBER(3) PRIMARY KEY,
  Country_code VARCHAR2(5) NOT NULL,
  Country_name VARCHAR2(70) NOT NULL,
  Region_id NUMBER(3) NOT NULL,
  CONSTRAINT fk_region_id FOREIGN KEY (region_id) REFERENCES Regions (region_id)
  );
  