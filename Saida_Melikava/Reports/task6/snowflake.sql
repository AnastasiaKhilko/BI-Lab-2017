CREATE TABLE DimDate
(Date_key NUMBER(8) PRIMARY KEY,
Full_date DATE NOT NULL,
Year VARCHAR2(4) NOT NULL,
Quarter VARCHAR2(1) NOT NULL,
Semester VARCHAR2(1) NOT NULL,
Month VARCHAR2(2) NOT NULL,
Month_name VARCHAR2(20) NOT NULL,
Day_of_month NUMBER(2)NOT NULL,
Day_of_year NUMBER(3)NOT NULL,
Day_name VARCHAR2(20) NOT NULL
);

CREATE TABLE DimProducts
(Product_id NUMBER(8) PRIMARY KEY,
Product_desc VARCHAR2(150),
Category_id NUMBER(8) NOT NULL,
Update_dt DATE,
CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES DimProductsCategory(category_id)
);

CREATE TABLE DimProductsCategory
(Category_id NUMBER(8) PRIMARY KEY,
Category_name VARCHAR2(40),
Update_dt DATE
);


CREATE TABLE DimRegionsCust (
Region_id NUMBER(8) PRIMARY KEY,
Region VARCHAR2(30),
Update_dt DATE
);

CREATE TABLE DimEconomicRegionsCust (
Economic_region_id NUMBER(8) PRIMARY KEY,
Economic_region VARCHAR2(30),
Update_dt DATE
);

CREATE TABLE DimCountriesCust (
Country_id NUMBER(8) PRIMARY KEY,
Country_code VARCHAR2(30),
Country_name VARCHAR2(30),
Region_id NUMBER(8) NOT NULL,
Economic_region_id NUMBER(8) NOT NULL,
Update_dt DATE,
CONSTRAINT fk_region FOREIGN KEY (region_id) REFERENCES DimRegionsCust(region_id),
CONSTRAINT fk_ecregion FOREIGN KEY (Economic_region_id) REFERENCES DimEconomicRegionsCust(Economic_region_id)
);

CREATE TABLE DimCitiesCust (
City_id NUMBER(8) PRIMARY KEY,
City VARCHAR2(30),
Country_id NUMBER(8) NOT NULL,
Update_dt DATE,
CONSTRAINT fk_Country FOREIGN KEY (Country_id) REFERENCES DimCountriesCust(Country_id)
);

CREATE TABLE DimAddressesCust (
Address_id NUMBER(8) PRIMARY KEY,
Address VARCHAR2(100),
City_id NUMBER(8) NOT NULL,
Postal_code NUMBER(8) NOT NULL,
Phone VARCHAR2(15) NOT NULL,
Update_dt DATE,
CONSTRAINT fk_City FOREIGN KEY (City_id) REFERENCES DimCitiesCust(City_id)
);

CREATE TABLE DimCustomers
(Customer_id NUMBER(8) PRIMARY KEY,
First_name VARCHAR2(30) NOT NULL,
Last_name VARCHAR2(30) NOT NULL,
Address_id NUMBER(8) NOT NULL,
Email VARCHAR(30) NOT NULL,
Update_dt DATE,
CONSTRAINT fk_ADDR FOREIGN KEY (Address_id) REFERENCES DimAddressesCust(Address_id)
);


CREATE TABLE DimRegionsEmp (
Region_id NUMBER(8) PRIMARY KEY,
Region VARCHAR2(30),
Update_dt DATE
);

CREATE TABLE DimEconomicRegionsEmp (
Economic_region_id NUMBER(8) PRIMARY KEY,
Economic_region VARCHAR2(30),
Update_dt DATE
);

CREATE TABLE DimCountriesEmp (
Country_id NUMBER(8) PRIMARY KEY,
Country_code VARCHAR2(30),
Country_name VARCHAR2(30),
Region_id NUMBER(8) NOT NULL,
Economic_region_id NUMBER(8) NOT NULL,
Update_dt DATE,
CONSTRAINT fk_region_emp FOREIGN KEY (region_id) REFERENCES DimRegionsEmp(region_id),
CONSTRAINT fk_ecregion_emp FOREIGN KEY (Economic_region_id) REFERENCES DimEconomicRegionsEmp(Economic_region_id)
);

CREATE TABLE DimCitiesEmp (
City_id NUMBER(8) PRIMARY KEY,
City VARCHAR2(30),
Country_id NUMBER(8) NOT NULL,
Update_dt DATE,
CONSTRAINT fk_Country_emp FOREIGN KEY (Country_id) REFERENCES DimCountriesEmp(Country_id)
);

CREATE TABLE DimAddressesEmp (
Address_id NUMBER(8) PRIMARY KEY,
Address VARCHAR2(100),
City_id NUMBER(8) NOT NULL,
Postal_code NUMBER(8) NOT NULL,
Phone VARCHAR2(15) NOT NULL,
Update_dt DATE,
CONSTRAINT fk_City_emp FOREIGN KEY (City_id) REFERENCES DimCitiesEmp(City_id)
);

CREATE TABLE DimEmployees
(Employee_id NUMBER(8) PRIMARY KEY,
First_name VARCHAR2(30) NOT NULL,
Last_name VARCHAR2(30) NOT NULL,
Address_id NUMBER(8) NOT NULL,
Email VARCHAR(30) NOT NULL,
Store_id NUMBER(8) NOT NULL,
Update_dt DATE,
CONSTRAINT fk_ADDR_emp FOREIGN KEY (Address_id) REFERENCES DimAddressesemp(Address_id)
);

CREATE TABLE DimRegionsStore (
Region_id NUMBER(8) PRIMARY KEY,
Region VARCHAR2(30),
Update_dt DATE
);

CREATE TABLE DimEconomicRegionsStore (
Economic_region_id NUMBER(8) PRIMARY KEY,
Economic_region VARCHAR2(30),
Update_dt DATE
);

CREATE TABLE DimCountriesStore (
Country_id NUMBER(8) PRIMARY KEY,
Country_code VARCHAR2(30),
Country_name VARCHAR2(30),
Region_id NUMBER(8) NOT NULL,
Economic_region_id NUMBER(8) NOT NULL,
Update_dt DATE,
CONSTRAINT fk_region_store FOREIGN KEY (region_id) REFERENCES DimRegionsStore(region_id),
CONSTRAINT fk_ecregion_store FOREIGN KEY (Economic_region_id) REFERENCES DimEconomicRegionsStore(Economic_region_id)
);

CREATE TABLE DimCitiesStore (
City_id NUMBER(8) PRIMARY KEY,
City VARCHAR2(30),
Country_id NUMBER(8) NOT NULL,
Update_dt DATE,
CONSTRAINT fk_Country_store FOREIGN KEY (Country_id) REFERENCES DimCountriesStore(Country_id)
);

CREATE TABLE DimAddressesStore (
Address_id NUMBER(8) PRIMARY KEY,
Address VARCHAR2(100),
City_id NUMBER(8) NOT NULL,
Postal_code NUMBER(8) NOT NULL,
Phone VARCHAR2(15) NOT NULL,
Update_dt DATE,
CONSTRAINT fk_City_store FOREIGN KEY (City_id) REFERENCES DimCitiesStore(City_id)
);

CREATE TABLE DimStore
(Store_id NUMBER(8) PRIMARY KEY,
Manager VARCHAR2(61) NOT NULL,
Manager_email VARCHAR2(30) NOT NULL,
Address_id NUMBER(8) NOT NULL,
Update_dt DATE,
CONSTRAINT fk_ADDR_store FOREIGN KEY (Address_id) REFERENCES DimAddressesStore(Address_id)
);

CREATE TABLE Salesfact 
(
Sale_id NUMBER(8) PRIMARY KEY,
Customer_id NUMBER(8) NOT NULL,
Employee_id NUMBER(8) NOT NULL,
Product_id NUMBER(8) NOT NULL,
Store_id NUMBER(8) NOT NULL,
Date_key NUMBER(8) NOT NULL,
Amount number(10,2) NOT NULL,
Uodate_dt date,
CONSTRAINT fk_costomers FOREIGN KEY (customer_id) REFERENCES dimcustomers(customer_id),
CONSTRAINT fk_employees FOREIGN KEY (employee_id) REFERENCES dimemployees(employee_id),
CONSTRAINT fk_products FOREIGN KEY (product_id) REFERENCES dimproducts(product_id),
CONSTRAINT fk_stores FOREIGN KEY (store_id) REFERENCES dimstore(store_id),
CONSTRAINT fk_dates FOREIGN KEY (date_key) REFERENCES dimdate(date_key)
);
