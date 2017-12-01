--PKG_3NF_TO_DM_AZS.AZS_DML
CREATE OR REPLACE PACKAGE PKG_3NF_TO_DM_AZS AS
    PROCEDURE AZS_DML;
END PKG_3NF_TO_DM_AZS;
/


CREATE OR REPLACE PACKAGE BODY PKG_3NF_TO_DM_AZS AS
 PROCEDURE AZS_DML
 IS
     sql_stat varchar(400);
     before_cnt NUMBER;
     after_cnt NUMBER;
     table_name varchar(100):='cl_AZS';
     table_name2 varchar(100):='BL_DM.DIMAZS';
 begin
  before_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
  
  insert into cl_AZS
  SELECT 
    a.ID_STATION as ID3NF, 
    a.NO,  a.LOCATION_DESC,  a.LATITUDE,  a.LONGITUDE, nvl(a.ROAD1,'na'), nvl(a.ROAD2,'na'),
    a.DT,  a.DT2,  a.AI92, a.BN92,  a.AI95,  a.LPG,  a.AI98,  
    
    c.ID_COUNTRY,   c.COUNTRY_NAME,   c.COUNTRY_CODE,  nvl(c.ID_PARENT,0) ,
    r.ID_REGION, r.REGION_NAME, 
    nvl(d.ID_DISTRICT,0), d.DISTRICT_NAME,
    
    a.DATE_UPDATE as UPDATE_DATE, sysdate insert_date
  FROM BL_3NF.CE_AZS  a
  left join BL_3NF.CE_DISTRICT d on d.ID_DISTRICT=nvl(a.ID_DISTRICT,0)
  left join BL_3NF.CE_REGION r on r.ID_REGION=d.ID_REGION
  left join BL_3NF.CE_COUNTRY c on c.ID_COUNTRY=r.ID_COUNTRY;
  --where  d.ID_DISTRICT = 0 ;
    commit;   
  after_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
  dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)'); 
  table_name:=table_name2;
  before_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
  --SELECT   count(*)   FROM   cl_AZS cl;
  MERGE INTO bl_dm.DIMAZS dm USING
          ( SELECT   *   FROM   cl_AZS cl  )
      cls ON (
           cls.ID3NF = dm.ID3NF 
      ) WHEN MATCHED THEN
          UPDATE
              SET  dm.NO=cls.NO, dm.LOCATION_DESC=cls.LOCATION_DESC,
             -- dm.LATITUDE=cls.LATITUDE, dm.LONGITUDE=cls.LONGITUDE, 
              dm.ROAD1=cls.ROAD1, dm.ROAD2=cls.ROAD2, dm.DT=cls.DT, dm.DT2=cls.DT2, dm.AI92=cls.AI92, dm.BN92=cls.BN92, 
              dm.AI95=cls.AI95, dm.LPG=cls.LPG, dm.AI98=cls.AI98, dm.ID_COUNTRY=cls.ID_COUNTRY, 
              dm.COUNTRY_NAME=cls.COUNTRY_NAME, dm.COUNTRY_CODE=cls.COUNTRY_CODE, dm.ID_PARENT=cls.ID_PARENT, 
              dm.ID_REGION=cls.ID_REGION, dm.REGION_NAME=cls.REGION_NAME, dm.ID_DISTRICT=cls.ID_DISTRICT,
              dm.DISTRICT_NAME=cls.DISTRICT_NAME, dm.UPDATE_DATE=sysdate  
          where  
                decode(dm.NO,cls.NO,0,1)+
                decode(dm.LOCATION_DESC,cls.LOCATION_DESC,0,1)+
                --decode(dm.LATITUDE,cls.LATITUDE,0,1)+decode(dm.LONGITUDE,cls.LONGITUDE,0,1)+
                decode(dm.ROAD1,cls.ROAD1,0,1)+
                decode(dm.ROAD2,cls.ROAD2,0,1)+
                decode(dm.DT,cls.DT,0,1)+
                decode(dm.DT2,cls.DT2,0,1)+
                decode(dm.AI92,cls.AI92,0,1)+
                decode(dm.BN92,cls.BN92,0,1)+
                decode(dm.AI95,cls.AI95,0,1)+
                decode(dm.LPG,cls.LPG,0,1)+
                decode(dm.AI98,cls.AI98,0,1)+
                decode(dm.ID_COUNTRY,cls.ID_COUNTRY,0,1)+
                decode(dm.COUNTRY_NAME,cls.COUNTRY_NAME,0,1)+
                decode(dm.COUNTRY_CODE,cls.COUNTRY_CODE,0,1)+
                decode(dm.ID_PARENT,cls.ID_PARENT,0,1)+
                decode(dm.ID_REGION,cls.ID_REGION,0,1)+
                decode(dm.REGION_NAME,cls.REGION_NAME,0,1)+
                decode(dm.ID_DISTRICT,cls.ID_DISTRICT,0,1)+
                decode(dm.DISTRICT_NAME,cls.DISTRICT_NAME,0,1)>0
        WHEN NOT MATCHED THEN INSERT (AZS_SURR_ID,
        ID3NF,  NO,  LOCATION_DESC,  LATITUDE,  LONGITUDE,  ROAD1,  ROAD2,  DT,  DT2,  AI92,  BN92,
        AI95,  LPG,  AI98,  ID_COUNTRY,  COUNTRY_NAME,  COUNTRY_CODE,  ID_PARENT,  ID_REGION, 
        REGION_NAME,  ID_DISTRICT,  DISTRICT_NAME,  UPDATE_DATE,  INSERT_DATE) VALUES
      ( FRAMEWORK.pkg_utl_seq.seq_getval('BL_DM.SEQ_DM_AZS_ID'),
       cls.ID3NF, cls.NO, cls.LOCATION_DESC, cls.LATITUDE, cls.LONGITUDE, cls.ROAD1, 
       cls.ROAD2, cls.DT, cls.DT2, cls.AI92, cls.BN92, cls.AI95, cls.LPG, cls.AI98, cls.ID_COUNTRY, 
       cls.COUNTRY_NAME, cls.COUNTRY_CODE, cls.ID_PARENT, cls.ID_REGION, cls.REGION_NAME, 
       cls.ID_DISTRICT, cls.DISTRICT_NAME, sysdate, sysdate);
      
   after_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
   dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');
  end AZS_DML;
end PKG_3NF_TO_DM_AZS;