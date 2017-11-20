EXEC system.pckg_drop.DROP_Proc('Regions', 'Table');  
CREATE TABLE Regions (
  Region_id NUMBER(3) PRIMARY KEY,
  Region_name VARCHAR2(70) NOT NULL,
  Continent_id NUMBER(3) NOT NULL,
  CONSTRAINT fk_continent_id FOREIGN KEY (Continent_id) REFERENCES Continents (Continent_id)
  );