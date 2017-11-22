-- ext_ORDERS.
    create table EXT_ORDERS
        (order_quantity  number ( 38 ),
         sales number ( 38,2 ),
         discount number ( 4,2 ),
         ship_mode varchar2 ( 200 char ),
         profit number ( 38,2 ),
		 unit_price  number ( 38,2 ),
		 shiping_cost number ( 38,2 ),
         Customer_Name varchar2 ( 200 char ),
		 Province varchar2 ( 200 char ),
		 Region varchar2 ( 200 char ),
		 Customer_Segment varchar2 ( 200 char ),
		 Product_Category varchar2 ( 200 char ),
		 Product_Sub-Category varchar2 ( 200 char ),
		 Product_Name varchar2 ( 200 char ),
		 Product_Container varchar2 ( 200 char ),
		 Product_Base_Margin varchar2 ( 200 char ),
		 Ship_Date varchar2 ( 200 char ),
         is_active varchar2 ( 200 char )
         )
    organization external
        (TYPE ORACLE_LOADER DEFAULT DIRECTORY external_cust_tables
                         ACCESS PARAMETERS (FIELDS TERMINATED BY ',')
                         LOCATION ('orders_info.csv', 
                                  )
    )
    reject limit unlimited;