CREATE TABLE DimProducts
(Product_id NUMBER(8) PRIMARY KEY,
Product_desc VARCHAR2(150),
Category_name VARCHAR2(20) NOT NULL,
Update_dt DATE
);

CREATE TABLE DimEmployees
(Employee_id NUMBER(8) PRIMARY KEY,
First_name VARCHAR2(30) NOT NULL,
Last_name VARCHAR2(30) NOT NULL,
store_id number(8),
Address VARCHAR(60) NOT NULL,
City VARCHAR(30) NOT NULL,
Country VARCHAR(30) NOT NULL,
Economic_region VARCHAR(30),
Region VARCHAR(30) NOT NULL,
Email VARCHAR(30) NOT NULL,
Update_dt DATE
);

CREATE TABLE DimStores
(Store_id NUMBER(8) PRIMARY KEY,
Manager VARCHAR2(61) NOT NULL,
Manager_email VARCHAR2(30) NOT NULL,
Address VARCHAR(60) NOT NULL,
City VARCHAR(30) NOT NULL,
Country VARCHAR(30) NOT NULL,
Economic_region VARCHAR(30),
Region VARCHAR(30) NOT NULL,
Email VARCHAR(30) NOT NULL,
Update_dt DATE
);

CREATE TABLE DimCustomers
(Customer_id NUMBER(8) PRIMARY KEY,
First_name VARCHAR2(30) NOT NULL,
Last_name VARCHAR2(30) NOT NULL,
Address VARCHAR(60) NOT NULL,
City VARCHAR(30) NOT NULL,
Country VARCHAR(30) NOT NULL,
Economic_region VARCHAR(30),
Region VARCHAR(30) NOT NULL,
Email VARCHAR(30) NOT NULL,
Update_dt DATE
);

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


CREATE TABLE SalesFact
(Sale_id NUMBER(8) PRIMARY KEY,
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
CONSTRAINT fk_stores FOREIGN KEY (store_id) REFERENCES dimstores(store_id),
CONSTRAINT fk_dates FOREIGN KEY (date_key) REFERENCES dimdate(date_key)
);
