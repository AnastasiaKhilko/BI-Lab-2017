CREATE TABLE contacts
  (
    contact_id  NUMBER(8) PRIMARY KEY,
    email_address        VARCHAR2(30) NOT NULL,
    telephone_number      VARCHAR2(30) NOT NULL
  );