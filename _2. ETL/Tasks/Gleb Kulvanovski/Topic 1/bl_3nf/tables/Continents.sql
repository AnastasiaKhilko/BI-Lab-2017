EXEC system.pckg_drop.DROP_Proc('Continents', 'Table');
CREATE TABLE Continents (
  Continent_id NUMBER(3) PRIMARY KEY,
  Continent_name VARCHAR2(70) NOT NULL
  );