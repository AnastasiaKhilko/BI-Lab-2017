DROP TABLE Dim_Payments CASCADE CONSTRAINTS;
CREATE TABLE Dim_Payments
  (
    Payment_sur_id           NUMBER(8) PRIMARY KEY,
    Payment_3nf_id           NUMBER(8) NOT NULL,
    Payment_code             NUMBER(8) NOT NULL,
    Payment_type_group       VARCHAR2(50) NOT NULL,
    Payment_type_description VARCHAR2(50) NOT NULL,
    Payment_prepayment       VARCHAR2(30) NOT NULL,
    insert_DT                DATE DEFAULT(sysdate) NOT NULL ,
    update_DT                DATE DEFAULT(sysdate) NOT NULL
  );
COMMENT ON TABLE Dim_Payments
IS
  'Table Content: All information about payment types.   
Refresh Cycle/Window: Data is loaded rarely and for a long period of time.  
';
  COMMENT ON column Dim_Payments.Payment_sur_id
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
