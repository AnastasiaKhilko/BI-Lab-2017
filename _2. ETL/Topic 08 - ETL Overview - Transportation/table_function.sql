DROP TYPE t_tf_tab;
DROP TYPE t_tf_row;

CREATE TYPE t_tf_row AS OBJECT (
  id           NUMBER,
  description  VARCHAR2(50)
);
/

CREATE TYPE t_tf_tab IS TABLE OF t_tf_row;
/

-- Build the table function itself.
CREATE OR REPLACE FUNCTION get_tab_tf (p_rows IN NUMBER) RETURN t_tf_tab AS
  l_tab  t_tf_tab := t_tf_tab();
BEGIN
  FOR i IN 1 .. p_rows LOOP
    l_tab.extend;
    l_tab(l_tab.last) := t_tf_row(i, 'Description for ' || i);
  END LOOP;

  RETURN l_tab;
END;
/

SELECT *
FROM   TABLE(get_tab_tf(10))
ORDER BY id DESC;

--pipelined table function

CREATE OR REPLACE FUNCTION get_tab_ptf (p_rows IN NUMBER) RETURN t_tf_tab PIPELINED AS
BEGIN
  FOR i IN 1 .. p_rows LOOP
    PIPE ROW(t_tf_row(i, 'Description for ' || i));   
  END LOOP;

  RETURN;
END;
/
 
SELECT *
FROM   TABLE(get_tab_ptf(10))
ORDER BY id DESC;

