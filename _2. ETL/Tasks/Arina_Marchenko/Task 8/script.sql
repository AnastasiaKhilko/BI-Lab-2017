CREATE OR REPLACE TYPE TypeFunction
AS
OBJECT
        (ID NUMBER,
        Name VARCHAR(60),
        DepCode NUMBER,
        Salary NUMBER );
        /
CREATE TYPE t_tab IS TABLE OF t_row;
/
CREATE OR REPLACE TYPE TableFunction AS TABLE OF TypeFunction;
/
CREATE OR REPLACE
FUNCTION MyFnct
(deptCode NUMBER) RETURN TableFunction
IS 
OutTableParam TableFunction;
BEGIN
        SELECT CAST(
        MULTISET(SELECT empno, 
                        ename, 
                        deptno, 
                        sal
                FROM scott.emp
                WHERE deptno != deptcode)
        as TableFunction)
        INTO outtableparam
        FROM dual;
 
RETURN OutTableParam;
END;
/
SELECT * FROM TABLE(MyFnct(5));