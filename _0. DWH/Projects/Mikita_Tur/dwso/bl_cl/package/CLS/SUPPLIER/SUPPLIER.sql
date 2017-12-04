select * from wrk_SUPPLIERs;
drop table cls_supplier;
CREATE TABLE Cls_SUPPLIER
  (
    SUPPLIER_SRCID NUMBER (8)        ,
    SUPPLIER_NAME  VARCHAR2 (50)    ,
    PHONE          varchar2 (100)       ,
    EMAIL          VARCHAR2 (50)     ,
    address varchar2(100),
    ADDRESS_SRCID  NUMBER (8)       ,
    START_DT       DATE             ,
    END_DT         DATE              ,
    IS_ACTIVE      VARCHAR2 (10)      
      );

truncate table cls_supplier;
INSERT INTO cls_supplier ( SUPPLIER_SRCID,
    SUPPLIER_NAME,
    PHONE,
    EMAIL,
    ADDRESS,
    START_DT,
    END_DT,
    IS_ACTIVE)
SELECT sup.number_code ,
sup.givenNAME,
sup.TELEPHONENUMBER,
sup.EMAILADDRESS,
sup.streetaddress,
NVL2(nfsup.supplier_srcid, TRUNC(sysdate),TO_DATE('01/01/1900','DD/MM/YYYY')) as start_dt,
TO_DATE('31/12/9999','DD/MM/YYYY') as end_dt,
'ACT' as IS_ACTIVE
FROM  WRK_suppliers sup left join bl_3nf.ce_supplier nfsup
ON (nfsup.start_dt<= TRUNC(sysdate)
and nfsup.end_dt > TRUNC(sysdate)
and nfsup.supplier_srcid = sup.number_code)
WHERE DECODE(sup.givenname, nfsup.supplier_name, 0,1)+ decode(sup.emailaddress,nfsup.email,0,1)>0
UNION ALL
SELECT nfsup.supplier_srcid, nfsup.supplier_name,nfsup.phone,
nfsup.email,sup.streetaddress,

nfsup.start_dt, TRUNC(sysdate) end_dt, 'ACT' IS_ACTIVE
FROM  WRK_suppliers sup left join bl_3nf.ce_supplier nfsup
ON (nfsup.start_dt<= TRUNC(sysdate)
and nfsup.end_dt > TRUNC(sysdate)
and nfsup.supplier_srcid = sup.number_code)
WHERE DECODE(sup.givenname, nfsup.supplier_name, 0,1)+ 
decode(sup.emailaddress,nfsup.email,0,1)>0;
update cls_supplier 
set address_srcid = (select distinct address_srcid 
from BL_3NF.CE_ADDRESS ad, WRK_SUPPLIERS sup WHERE  ad.address=sup.streetaddress);
select * from cls_supplier;
truncate table cls_supplier;
MERGE INTO bl_3nf.ce_supplier tgt
USING (SELECT * FROM cls_supplier) src
ON (src.supplier_srcid = tgt.supplier_srcid 
AND src.start_dt = tgt.start_dt)
WHEN MATCHED THEN 
UPDATE SET tgt.supplier_name = src.supplier_name,
tgt.phone=src.phone,
tgt.email=src.email,
tgt.end_dt = src.end_dt,
tgt.is_active=src.is_active
WHEN NOT MATCHED THEN 
INSERT (supplier_id, supplier_srcid, supplier_name,phone,email, start_dt, end_dt,is_active)
VALUES (bl_3nf.sup_seq.nextval, src.supplier_srcid, src.supplier_name,src.phone,src.email, src.start_dt, src.end_dt,src.is_active);
select * from cls_supplier;
delete  from cls_supplier where end_dt='01-DEC-17';
commit;

select * from target_table;