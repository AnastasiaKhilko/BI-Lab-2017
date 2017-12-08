CREATE OR REPLACE PACKAGE pkg_load_dwh_cards
AS
  PROCEDURE load_cls2_cards;
  PROCEDURE load_dwh;
END pkg_load_dwh_cards;
/
CREATE OR REPLACE PACKAGE BODY pkg_load_dwh_cards
AS
PROCEDURE load_cls2_cards
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_cards';
  INSERT INTO cls_cards
  SELECT CARD_3NF_ID,
    BANK_NAME,
    start_dt,
    end_dt,
    is_active,
    discount,
    CCTYPE,
    CVV2,
    CCNUMBER,
    CCEXPIRES
  FROM bl_3nf.CE_CARDS ca
  LEFT JOIN bl_3nf.CE_banks b
  ON ca.bank_id = b.bank_3nf_id
  LEFT JOIN bl_3nf.CE_CARD_typeS t
  ON ca.CCTYPE_ID = t.CARD_TYPE_3NF_ID;
  COMMIT;
  -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
END load_cls2_cards;
PROCEDURE load_dwh
IS
BEGIN
  MERGE INTO bl_dwh.dim_cards d USING
  (SELECT CARD_3NF_ID,
    BANK_NAME,
    start_dt,
    end_dt,
    is_active,
    discount,
    CCTYPE,
    CVV2,
    CCNUMBER,
    CCEXPIRES
  FROM cls_cards
  MINUS
  SELECT CARD_3NF_ID,
    BANK_NAME,
    start_dt,
    end_dt,
    is_active,
    discount,
    CCTYPE,
    CVV2,
    CCNUMBER,
    CCEXPIRES
  FROM bl_dwh.dim_cards
  ) cls ON ( cls.card_3nf_id = d.card_3nf_id )
WHEN MATCHED THEN
  UPDATE
  SET
    -- d.CARD_3NF_ID = cls.CARD_3NF_ID,
    d.BANK_NAME = cls.BANK_NAME,
    d.start_dt  = cls.start_dt ,
    d.end_dt    = cls.end_dt,
    d.is_active = cls.is_active,
    d.discount  = cls.discount,
    d.CCTYPE    = cls.CCTYPE,
    d.CVV2      = cls.CVV2,
    d.CCNUMBER  = cls.CCNUMBER,
    d.CCEXPIRES = cls.CCEXPIRES 
    WHEN NOT MATCHED THEN
    INSERT
    VALUES
    (
      bl_dwh.seq_cards_dwh.nextval ,
      cls.card_3nf_id ,
      cls.BANK_NAME,
      cls.start_dt ,
      cls.end_dt,
      cls.is_active,
      cls.discount,
      cls.CCTYPE,
      cls.CVV2,
      cls.CCNUMBER,
      cls.CCEXPIRES--,
      --  sysdate
    ) ;
  --end;
  COMMIT;
END load_dwh;
END pkg_load_dwh_cards;
/

