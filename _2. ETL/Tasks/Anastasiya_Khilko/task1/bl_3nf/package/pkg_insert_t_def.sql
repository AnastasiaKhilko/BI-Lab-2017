CREATE OR REPLACE PACKAGE pkg_insert_t
  AUTHID CURRENT_USER as
  PROCEDURE table_insert;
END pkg_insert_t;
/