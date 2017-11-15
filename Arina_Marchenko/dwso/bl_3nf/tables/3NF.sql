DROP TABLE Country CASCADE CONSTRAINTS;
CREATE TABLE Country(
    Country_id	NUMBER(8),
    Country_name VARCHAR2(200),
    CONSTRAINT Country_id PRIMARY KEY (country_id));

DROP TABLE City CASCADE CONSTRAINTS;
CREATE TABLE City(
    City_id	NUMBER(8),
    City_name VARCHAR2(200),
    Country_id	NUMBER(8),	
    CONSTRAINT City_id PRIMARY KEY (city_id),
    CONSTRAINT Store_country FOREIGN KEY (country_id) REFERENCES Country (country_id));

DROP TABLE Address CASCADE CONSTRAINTS;
CREATE TABLE Address(
    Address_id	NUMBER(8),
    Street_name VARCHAR2(200),
    House_NUMBER VARCHAR2(200),	
    City_id	NUMBER(8),
    CONSTRAINT address_id PRIMARY KEY (address_id),
    CONSTRAINT Store_city FOREIGN KEY (city_id) REFERENCES City (city_id));

DROP TABLE Store CASCADE CONSTRAINTS;
CREATE TABLE Store(
    Store_id	NUMBER(8),
    Store_name	VARCHAR2(200),	
    Address_id	NUMBER(8),
    Phone	VARCHAR2(200),	
    Email	VARCHAR2(200),
    CONSTRAINT Store_id PRIMARY KEY (Store_id),
    CONSTRAINT Store_address FOREIGN KEY (Address_id) REFERENCES Address (address_id));

DROP TABLE Seller CASCADE CONSTRAINTS;
CREATE TABLE Seller(
    Seller_id	NUMBER(8),
    Seller_name	VARCHAR2(200),
    Seller_surname	VARCHAR2(200),	
    Seller_rating	NUMBER(8),	
    Phone	VARCHAR2(200),	
    Email	VARCHAR2(200),
    City_id NUMBER(8),
    CONSTRAINT Seller_id PRIMARY KEY (seller_id),
    CONSTRAINT Seller_city FOREIGN KEY (city_id) REFERENCES City (city_id));

DROP TABLE Customer CASCADE CONSTRAINTS;
CREATE TABLE Customer(
    Customer_id	NUMBER(8),
    Customer_name	VARCHAR2(200),
    Customer_surname	VARCHAR2(200),	
    Age	NUMBER(8),	
    Gender	NUMBER(8),
    Phone	VARCHAR2(200),	
    Email	VARCHAR2(200),
    CONSTRAINT customer_id PRIMARY KEY (customer_id));

DROP TABLE Date_Dimension CASCADE CONSTRAINTS;
CREATE TABLE Date_Dimension (
    Date_id DATE NOT NULL,
    Day_per_week NUMBER(8),
    Day_per_month NUMBER(8),
    Day_per_year NUMBER(8),
    Week_per_month NUMBER(8),
    Week_per_year NUMBER(8),
    Month_NUMBER NUMBER(8),
    Month_name VARCHAR2(200),
    Year NUMBER(8),
    Day_Month VARCHAR2(200),
    Year_Month VARCHAR2(200),
    CONSTRAINT Date_id PRIMARY KEY (Date_id));

DROP TABLE Vehicle_type CASCADE CONSTRAINTS;
CREATE TABLE Vehicle_type (
    Vehicle_type_id NUMBER(8),
    Vehicle_type_name VARCHAR2(200),
    CONSTRAINT Vehicle_type_id PRIMARY KEY (Vehicle_type_id));

DROP TABLE Engine_type CASCADE CONSTRAINTS;
CREATE TABLE Engine_Type(
    Engine_Type_id NUMBER(8),
    Engine_Type_name	VARCHAR2(200),
    CONSTRAINT Engine_Type_id PRIMARY KEY (Engine_Type_id));

DROP TABLE Gearbox_type CASCADE CONSTRAINTS;
CREATE TABLE Gearbox_type(
    Gearbox_type_id NUMBER(8),
    Gearbox_type_name	VARCHAR2(200),
    CONSTRAINT Gearbox_type_id PRIMARY KEY (Gearbox_type_id));

DROP TABLE Brand CASCADE CONSTRAINTS;
CREATE TABLE Brand(
    Brand_id	NUMBER(8),
    Brand_name	VARCHAR2(200),
    CONSTRAINT Brand_id PRIMARY KEY (Brand_id));

DROP TABLE Model CASCADE CONSTRAINTS;
CREATE TABLE Model(
    Model_id	NUMBER(8),
    Model_name	VARCHAR2(200),
    Brand_id NUMBER(8),
    CONSTRAINT Model_id PRIMARY KEY (Model_id),
    CONSTRAINT Model_Brand FOREIGN KEY (Brand_id) REFERENCES Brand (brand_id));

DROP TABLE Repaired_Status CASCADE CONSTRAINTS;
CREATE TABLE Repaired_Status(
    Repair_status_id	NUMBER(8),
    Repair_status_name	VARCHAR2(200),
    CONSTRAINT Repair_status_id PRIMARY KEY (Repair_status_id));
    
DROP TABLE Cars CASCADE CONSTRAINTS;
CREATE TABLE Cars(
    Car_id	NUMBER(8),
    Car_NUMBER	NUMBER(8), 
    Car_name	VARCHAR2(200),
    Car_Registration_date_id	Date,
    Vehicle_type_id NUMBER(8),
    Engine_Type_id NUMBER(8),
    Gearbox_type_id NUMBER(8),
    Model_id	NUMBER(8),
    Repair_status_id	NUMBER(8),
    CONSTRAINT Car_id PRIMARY KEY (Car_id),
    CONSTRAINT Car_Registration_id FOREIGN KEY (Car_Registration_date_id) REFERENCES Date_Dimension (Date_id),
    CONSTRAINT Car_Vehicle_type_id FOREIGN KEY (Vehicle_type_id) REFERENCES Vehicle_type (Vehicle_type_id),
    CONSTRAINT Car_Engine_Type_id FOREIGN KEY (Engine_Type_id) REFERENCES Engine_Type (Engine_Type_id),
    CONSTRAINT Car_Gearbox_type_id FOREIGN KEY (Gearbox_type_id) REFERENCES Gearbox_type (Gearbox_type_id),
    CONSTRAINT Car_Model_id FOREIGN KEY (Model_id) REFERENCES Model (Model_id),
    CONSTRAINT Car_Repair_status_id FOREIGN KEY (Repair_status_id) REFERENCES Repaired_status (Repair_status_id));
    
DROP TABLE Orders CASCADE CONSTRAINTS;
CREATE TABLE Orders(
    Order_id NUMBER(8),
    Order_code NUMBER(8),
    Order_Date_id Date,
    Cost NUMBER(8),
    Min_price NUMBER(8),
    Avg_price NUMBER(8),
    Sd_price NUMBER(8),
    Car_id NUMBER(8),
    Seller_id	NUMBER(8),
    Customer_id	NUMBER(8),
    Store_id NUMBER(8),
    CONSTRAINT order_id PRIMARY KEY (order_id),
    CONSTRAINT Order_Date_id FOREIGN KEY (Order_Date_id) REFERENCES Date_Dimension (Date_id),
    CONSTRAINT Order_Seller_id FOREIGN KEY (Seller_id) REFERENCES Seller (Seller_id),
    CONSTRAINT Order_Customer_id FOREIGN KEY (Customer_id) REFERENCES Customer (Customer_id),
    CONSTRAINT Order_Car_id FOREIGN KEY (Car_id) REFERENCES Cars (Car_id),
    CONSTRAINT Order_Store_id FOREIGN KEY (Store_id) REFERENCES Store (Store_id));