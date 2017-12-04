CREATE OR REPLACE TYPE TypeForFunction
AS
OBJECT
        (EmpCd NUMBER,
        EmpName VARCHAR(60),
        DepartCode NUMBER,
        Salary NUMBER );
        /
        
CREATE OR REPLACE TYPE TableForFunction AS TABLE OF TypeForFunction;
/

CREATE OR REPLACE
FUNCTION MyFunction
(deptCode NUMBER) RETURN TableForFunction
IS 
OutTableParam TableForFunction;
BEGIN
        SELECT CAST(
        MULTISET(SELECT empno, 
                        ename, 
                        deptno, 
                        sal
                FROM scott.emp
                WHERE deptno = deptcode)
        as TableForFunction)
        INTO outtableparam
        FROM dual;
 
RETURN OutTableParam;
END;
/

SELECT * FROM TABLE(MyFunction(10));
