CREATE OR REPLACE package pkg_insert_to_cls
AUTHID CURRENT_USER as
PROCEDURE insert_table_to_cls(distination_table   IN varchar2,
                               source_table IN varchar2);
END pkg_insert_to_cls;
/

