CREATE OR REPLACE PACKAGE pckg_insert_payments_dim
AS
  PROCEDURE insert_bl_dim;
END pckg_insert_payments_dim;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_payments_dim
AS
PROCEDURE insert_bl_dim
IS
BEGIN
  MERGE INTO bl_dm.dim_payments dim USING
  (SELECT payment_id,
    payment_code,
    payment_type_group,
    payment_type_description,
    prepayment
  FROM bl_3nf.ce_payments
  where payment_id>0
  MINUS
  SELECT payment_3nf_id,
    payment_code,
    payment_type_group,
    payment_type_description,
    payment_prepayment
  FROM bl_dm.dim_payments
  ) cls ON ( cls.payment_id = dim.payment_3nf_id )
WHEN MATCHED THEN
  UPDATE
  SET dim.payment_type_group    =cls.payment_type_group,
    dim.payment_type_description=cls.payment_type_description,
    dim.payment_prepayment      =cls.prepayment,
    dim.update_dt               =trunc(SYSDATE) WHEN NOT MATCHED THEN
  INSERT
    (
      payment_sur_id,
      payment_3nf_id,
      payment_code,
      payment_type_group,
      payment_type_description,
      payment_prepayment
    )
    VALUES
    (
      seq_pay_dim.nextval,
      cls.payment_id,
      cls.payment_code,
      cls.payment_type_group,
      cls.payment_type_description,
      cls.prepayment
    ) ;
  dbms_output.put_line('Data in the tables is successfully merged: '||SQL%rowcount|| ' rows were inserted.');
exception
WHEN others THEN
  raise;
  COMMIT;
END;
END pckg_insert_payments_dim;
/