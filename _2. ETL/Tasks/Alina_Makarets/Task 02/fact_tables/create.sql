CREATE TABLE fct_table 
  (Event_date DATE NOT NULL,
  Product_id NUMBER NOT NULL,
  Customer_id NUMBER NOT NULL,
  Store_id NUMBER NOT NULL,
  Total_price NUMBER NOT NULL,
  Amount NUMBER NOT NULL,
  CONSTRAINT FK_Event_date FOREIGN KEY (Event_date)
      REFERENCES Dim_time_day (Date_id),
  CONSTRAINT FK_Product_id FOREIGN KEY (Product_id)
      REFERENCES Dim_Products (Product_id),
  CONSTRAINT FK_Customer_id FOREIGN KEY (Customer_id)
      REFERENCES Dim_Customers (Customer_id),
  CONSTRAINT FK_Store_id FOREIGN KEY (Store_id)
      REFERENCES Dim_Stores (Store_id)
      );
      
      
    