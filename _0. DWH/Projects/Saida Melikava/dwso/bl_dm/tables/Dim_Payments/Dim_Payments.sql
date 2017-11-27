EXECUTE pckg_drop.drop_proc(object_name=>'Dim_Payments',object_type=>'table');
CREATE TABLE Dim_Payments
  (
    Payment_id               NUMBER(8) PRIMARY KEY,
    Payment_type_group       VARCHAR2(50) NOT NULL,
    Payment_type_description VARCHAR2(50) NOT NULL,
    Payment_prepayment       VARCHAR2(10) NOT NULL,
    Insert_DT                DATE NOT NULL,
    Update_DT                DATE NOT NULL
  );
COMMENT ON TABLE Dim_Payments
IS
  'Table Content: All information about payment types.   
Refresh Cycle/Window: Data is loaded rarely and for a long period of time.  
';
  COMMENT ON column Dim_Payments.Payment_id
IS
  'Dimension surrogate key';
  COMMENT ON column Dim_Payments.Payment_type_group
IS
  'Cash, credit card, e-money';
  COMMENT ON column Dim_Payments.Payment_type_description
IS
  'Visa/Master Card for cards, Bitcoin/Etherum for e-money';
  COMMENT ON column Dim_Payments.Payment_prepayment
IS
  'Prepayment/non-prepayment';
  COMMENT ON column Dim_Payments.Insert_DT
IS
  'When data was loaded';
  COMMENT ON column Dim_Payments.Update_DT
IS
  'When data was updated';
  /*
  GRANT SELECT ON dim_template TO some_user;*/
