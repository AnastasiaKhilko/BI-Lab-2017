CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_emp AS
    PROCEDURE load_wrk_emp
    IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_customers';
        INSERT INTO wrk_employees SELECT
            *
        FROM
            sa_src.ext_employees;
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
    EXECUTE IMMEDIATE 'truncate table cls_customers';
    INSERT INTO cls_employees SELECT
            *
        FROM
            wrk_employees;
        COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END load_cls_emp;

    
/****************************************************/
PROCEDURE load_ce_emp
        IS
    BEGIN
        MERGE INTO bl_3nf.ce_employees d USING
            ( SELECT
                emp_code,
                last_name,
                first_name,
                addr_id,
                email,
                phone,
                manager_code,
                store_code
            FROM
                cls_employees
            MINUS
            SELECT
                emp_code,
                last_name,
                first_name,
                addr_id,
                email,
                phone,
                manager_code,
                store_code
            FROM
                bl_3nf.ce_employees
            )
        cls ON (
            cls.emp_code = d.emp_code
        ) WHEN MATCHED THEN
            UPDATE
        SET d.last_name = cls.last_name,d.first_name = cls.first_name, d.addr_id = cls.addr_id,-- d.email = cls.email, d.phone = cls.phone, d.manager_code = cls.manager_code, d.store_code = cls.store_code,
            d.update_dt = SYSDATE
        WHEN NOT MATCHED THEN INSERT ( emp_id,emp_code,last_name,first_name, addr_id, email,phone, manager_code, store_code, insert_dt,update_dt ) VALUES ( bl_3nf.seq_emp.nextval,
        cls.emp_code,cls.last_name,cls.first_name, cls.addr_id, cls.email, cls.phone, cls.manager_code, cls.store_code, SYSDATE,SYSDATE );

        COMMIT;
        --dbms_output.put_line('The data in the table CE_DELIVERIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_emp;


/****************************************************/

END pkg_load_3nf_emp;
/