DROP TABLE Dim_Authors;
CREATE TABLE Dim_Authors
  (
    Author_id   NUMBER(8) PRIMARY KEY,
    Author_code VARCHAR2(25) NOT NULL,
    Author_name VARCHAR2(70) NOT NULL,
    Insert_DT   DATE NOT NULL,
    Update_DT   DATE NOT NULL
  );
COMMENT ON TABLE Dim_Authors
IS
  'Table Content: All information about authors of books .   
Refresh Cycle/Window: Data is loaded rarely and for a long period of time.  
';
  COMMENT ON column Dim_Authors.Author_id
IS
  'Dimension surrogate key';
  COMMENT ON column Dim_Authors.Author_code
IS
  'Dimension business key, comes from external system.';
  COMMENT ON column Dim_Authors.Insert_DT
IS
  'When data was loaded';
  COMMENT ON column Dim_Authors.Update_DT
IS
  'When data was updated';
  /*
  GRANT SELECT ON dim_template TO some_user;*/
