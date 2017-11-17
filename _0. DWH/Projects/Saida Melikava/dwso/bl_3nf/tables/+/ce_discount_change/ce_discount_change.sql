CREATE TABLE ce_discount_change
  (
    Discount_change_id VARCHAR2(8) PRIMARY KEY,
    Start_DT           DATE NOT NULL,
    End_DT             DATE NOT NULL,
    Current_flag       VARCHAR2(10) NOT NULL
  );