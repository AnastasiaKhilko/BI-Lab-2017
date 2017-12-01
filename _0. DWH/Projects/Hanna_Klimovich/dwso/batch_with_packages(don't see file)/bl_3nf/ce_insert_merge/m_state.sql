MERGE INTO bl_3nf.ce_state nf USING
  (SELECT ctr.state_num ,
    ctr.DEST_STATE_NM,
    rg.country_id_seq
  FROM bl_cl.CL_state ctr
  LEFT JOIN bl_3nf.CE_country rg
  ON ctr.country_num=rg.country_id_seq
  MINUS
  SELECT ctr.state_num ,
    ctr.DEST_STATE_NM,
    country_num
  FROM bl_3nf.ce_state ctr
  ) cl ON (nf.state_num = cl.state_num)
WHEN MATCHED THEN
  UPDATE SET nf.DEST_STATE_NM = cl.DEST_STATE_NM WHEN NOT MATCHED THEN
  INSERT VALUES
    (
      bl_3nf.state_seq.NEXTVAL,
      cl.state_num ,
      cl.DEST_STATE_NM,
      cl.country_id_seq
    );
    commit;