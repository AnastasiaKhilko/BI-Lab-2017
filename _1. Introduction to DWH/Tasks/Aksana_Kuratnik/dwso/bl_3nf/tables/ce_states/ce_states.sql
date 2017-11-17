CREATE TABLE states
  (
    state_id NUMBER(8) PRIMARY KEY,
    state_name    VARCHAR2(30) NOT NULL,
    state_short_name  VARCHAR2(10) NOT NULL,
    zip_code VARCHAR2(10) NOT NULL
  );