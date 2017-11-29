CREATE PUBLIC DATABASE LINK hr_link
CONNECT TO hr IDENTIFIED BY hr
USING '//192.168.56.101:1521/vd01dw';


CREATE TYPE t_row AS OBJECT (
  id  NUMBER,
  name  VARCHAR2(20)
);
/

CREATE TYPE t_table IS TABLE OF t_row;
/

CREATE OR REPLACE FUNCTION get_table (p_rows IN NUMBER) RETURN t_table AS
  l_tab  t_table := t_table();
BEGIN
  FOR i IN 1 .. p_rows LOOP
    l_tab.extend;
    l_tab(l_tab.last) := t_row(i, 'Customer ' || i);
  END LOOP;

  RETURN l_tab;
END;
/

SELECT * FROM TABLE (get_table(143));