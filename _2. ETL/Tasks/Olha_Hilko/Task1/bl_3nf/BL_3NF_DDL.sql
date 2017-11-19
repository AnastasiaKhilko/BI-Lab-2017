EXEC  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('Continents', 'TABLE'); 
CREATE TABLE Continents (
  Continent_id NUMBER(3) PRIMARY KEY,
  Continent_name VARCHAR2(70) NOT NULL
  );

EXEC FRAMEWORK.pkg_utl_drop.proc_drop_obj ('Regions', 'TABLE'); 
CREATE TABLE Regions (
  Region_id NUMBER(3) PRIMARY KEY,
  Region_name VARCHAR2(70) NOT NULL,
  Continent_id NUMBER(3) NOT NULL,
  CONSTRAINT fk_continent_id FOREIGN KEY (Continent_id) REFERENCES Continents (Continent_id)
  );
 
EXEC FRAMEWORK.pkg_utl_drop.proc_drop_obj ('Countries', 'TABLE');   
CREATE TABLE Countries (
  Country_id NUMBER(3) PRIMARY KEY,
  Country_code VARCHAR2(5) NOT NULL,
  Country_name VARCHAR2(70) NOT NULL,
  Region_id NUMBER(3) NOT NULL,
  CONSTRAINT fk_region_id FOREIGN KEY (region_id) REFERENCES Regions (region_id)
  );



/*exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('Continents', 'TABLE'); 
CREATE TABLE Continents (
  Continent_id NUMBER(3) PRIMARY KEY,
  Continent_name VARCHAR2(70) NOT NULL
  );

exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('Regions', 'TABLE'); 
CREATE TABLE Regions (
  Region_id NUMBER(3) PRIMARY KEY,
  Region_name VARCHAR2(70) NOT NULL,
  Continent_id NUMBER(3) NOT NULL
  );

exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('Countries', 'TABLE');   
CREATE TABLE Countries (
  Country_id NUMBER(3) PRIMARY KEY,
  Country_code VARCHAR2(5),-- NOT NULL,
  Country_name VARCHAR2(70) NOT NULL,
  Region_id NUMBER(3) NOT NULL
  );*/