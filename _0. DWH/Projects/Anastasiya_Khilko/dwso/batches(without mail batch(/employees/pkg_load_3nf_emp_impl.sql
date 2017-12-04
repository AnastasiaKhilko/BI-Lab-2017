CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_emp AS
    PROCEDURE load_wrk_emp
    IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_customers';
        INSERT INTO wrk_customers SELECT
            *
        FROM
            sa_src.ext_customers;
        COMMIT;
        --dbms_output.put_line('The data in the table WRK_DELIVERIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_emp;
/****************************************************/

PROCEDURE load_cls_emp
    IS
    BEGIN
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END load_cls_emp;

    
/****************************************************/
PROCEDURE load_ce_emp
    IS
BEGIN
  MERGE INTO BL_3NF.CE_CUSTOMERS tgt
  USING (
)EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END load_ce_emp;

/****************************************************/

END pkg_load_3nf_emp;
/