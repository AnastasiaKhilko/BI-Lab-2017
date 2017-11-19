DROP TABLE Dim_Discounts_SCD;
CREATE TABLE Dim_Discounts_SCD
  (
    Discount_id                NUMBER(8) PRIMARY KEY,
    Discount_code              VARCHAR2(25) NOT NULL,
    Discount_description       VARCHAR2(250) NOT NULL,
    Discount_terms_description VARCHAR2(250) NOT NULL,
    Start_DT                   DATE NOT NULL,
    End_DT                     DATE NOT NULL,
    Is_active                  VARCHAR2(4) NOT NULL,
    Insert_DT                  DATE NOT NULL
  );
COMMENT ON TABLE Dim_Discounts_SCD
IS
  'Table Content: All information about discount programms.   
Refresh Cycle/Window: Data is loaded every 2 weeks and for a long period of time.  
';
  COMMENT ON column Dim_Discounts_SCD.Discount_id
IS
  'Dimension surrogate key';
  COMMENT ON column Dim_Discounts_SCD.Discount_code
IS
  'Dimension business key, comes from external system.';
  COMMENT ON column Dim_Discounts_SCD.Discount_description
IS
  'Discount, gift, coupon on the next bought.';
  COMMENT ON column Dim_Discounts_SCD.Discount_terms_description
IS
  'For whom (category of buyers) and why.';
  COMMENT ON column Dim_Discounts_SCD.Start_DT
IS
  'When started to function.';
  COMMENT ON column Dim_Discounts_SCD.End_DT
IS
  'IWhen ended to function.';
  COMMENT ON column Dim_Discounts_SCD.Is_Active
IS
  'Active(Y) or Not(Y).';
  COMMENT ON column Dim_Discounts_SCD.Insert_DT
IS
  'When data was loaded';
  /*
  GRANT SELECT ON dim_template TO some_user;*/
