CREATE OR REPLACE PACKAGE pkg_load_3nf_cards
AS
  PROCEDURE load_cls_card_types;
  PROCEDURE load_ce_card_types;
  PROCEDURE load_cls_cards;
  PROCEDURE load_ce_cards;
END pkg_load_3nf_cards;
/
CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_cards
AS
PROCEDURE load_cls_card_types
IS
  -- DECLARE
  --emp_dept_id employees.department_id%TYPE;
BEGIN
  --execute DROP SEQUENCE seq_card_types;
  EXECUTE IMMEDIATE 'truncate table cls_card_types';
  --EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_card_types START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 1000000 NOCYCLE NOCACHE ORDER';
  FOR rec IN
  ( SELECT DISTINCT cctype FROM wrk_customers
  )
  loop
    INSERT
    INTO cls_card_types
      (
        card_type_id,
        cctype
      )
      VALUES
      (
        bl_3nf.seq_card_types_3nf.nextval,
        rec.cctype
      );
  END loop;
  COMMIT;
END load_cls_card_types;
PROCEDURE load_cls_cards
IS
BEGIN
  EXECUTE IMMEDIATE' truncate table cls_cards';
  INSERT INTO cls_cards
    (cctype_id , bank_id, ccnumber, cvv2, ccexpires
    )
  SELECT ce.card_type_3nf_id ,
    round( dbms_random.VALUE(1,
    (SELECT count(*) FROM bl_3nf.ce_banks
    ))),
    cvv2 ,
    ccnumber,
    ccexpires
  FROM wrk_customers w
  LEFT JOIN bl_3nf.ce_card_types ce
  ON w.cctype = ce.cctype ;
  COMMIT;
  -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
END load_cls_cards;
PROCEDURE load_ce_card_types
IS
BEGIN
  INSERT
  INTO bl_3nf.ce_card_types
    (SELECT card_type_id,
        cctype
      FROM cls_card_types
      WHERE cctype IN
        (SELECT cctype FROM cls_card_types
        MINUS
        SELECT cctype FROM bl_3nf.ce_card_types
        )
    );

  COMMIT;
  -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
END load_ce_card_types;
PROCEDURE load_ce_cards
IS
BEGIN
  --       insert INTO bl_3nf.ce_cards
  --       select bl_3nf.seq_cards_3nf.nextval, bank_id,
  --          CCType_id,
  --         CVV2 ,
  --        CCNumber,
  --        CCExpires
  --         --cls.update_date
  --         --sysdate
  --from cls_cards
  MERGE INTO bl_3nf.ce_cards ce USING
  (SELECT --source_3nf_id,
      cctype_id,
      bank_id,
      cvv2 ,
      ccnumber,
      ccexpires
      --update_date
    FROM cls_cards
    MINUS
    SELECT --source_3nf_id,
      cctype_id,
      bank_id,
      cvv2 ,
      ccnumber,
      ccexpires
      --update_date
    FROM bl_3nf.ce_cards
  )
  cls ON ( cls.ccnumber = ce.ccnumber and cls.bank_id = ce.bank_id and cls.cvv2 = ce.cvv2)
WHEN MATCHED THEN
  UPDATE
  SET ce.cctype_id = cls.cctype_id,
    --ce.bank_id     = cls.bank_id,
    ce.ccexpires   = cls.ccexpires
   --, ce.cvv2        = cls.cvv2 
    WHEN NOT MATCHED THEN
  INSERT VALUES
    (
      bl_3nf.seq_cards_3nf.nextval ,
      cls.bank_id,
      cls.cctype_id,
      cls.cvv2 ,
      cls.ccnumber,
      cls.ccexpires
      --cls.update_date
      --sysdate
    ) ;
  --end;
  COMMIT;
END load_ce_cards;
END pkg_load_3nf_cards;
/
