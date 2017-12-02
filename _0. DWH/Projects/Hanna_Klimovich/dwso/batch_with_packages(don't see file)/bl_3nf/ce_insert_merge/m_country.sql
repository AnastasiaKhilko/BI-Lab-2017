 MERGE INTO bl_3nf.ce_country nf USING
  (SELECT ctr.country_num ,
    ctr.country_name,
    rg.region_id_seq
  FROM bl_cl.CL_country ctr
  LEFT JOIN bl_3nf.CE_REGION rg
  ON ctr.region_num=rg.region_num
  MINUS
  SELECT ctr.country_num ,
    ctr.country_name,
    region_id
  FROM bl_3nf.ce_country ctr
  ) cl ON (nf.country_num = cl.country_num)
WHEN MATCHED THEN
  UPDATE SET nf.country_name = cl.country_name WHEN NOT MATCHED THEN
  INSERT VALUES
    (
      bl_3nf.country_seq.NEXTVAL,
      cl.country_num ,
      cl.country_name,
      cl.region_id_seq
    );
commit;
--truncate table ce_country;