CREATE TABLE test_tab (
  id          NUMBER,
  description VARCHAR2(50),
  CONSTRAINT test_tab_pk PRIMARY KEY (id)
);

INSERT /*+ APPEND */ INTO test_tab (id, description)
SELECT level,
       'Description for ' || level
FROM   dual
CONNECT BY level <= 10000;

COMMIT;