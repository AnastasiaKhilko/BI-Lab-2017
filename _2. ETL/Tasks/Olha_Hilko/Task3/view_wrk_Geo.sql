create or replace view view_wrk_Geo as select distinct 'OBL'||t1 par_id, 'RAI'||t1||t2 child_id, 
obl par_name, raion  || ' �����' child_name  from wrk_GEO s  where raion is not null  --122 ������ (���. ����������)
union all
select distinct 'OBL'||t1 par_id, 'TOWN'||t2||t3 child_id,   obl,  name from wrk_GEO s  
where raion is null and obl is not null                                              --130 ������ (���. ����������)
union all
select distinct 'BY','OBL'||t1, '��������' , obl from wrk_GEO s where obl is not null --6 ������� (��)
union all
select distinct 'BY', 'CITY'||t1, '��������', name from wrk_GEO s where obl is null --6 ��������� ������ (��) --'CITY'||t1
union all
select distinct 'RAI'||t1||t2 , to_char(soato), raion ||' �����',  name
 from wrk_GEO where  sovet is null and raion is not null                   -- 213 ���. ������ (��������� ���������� )
 union all
 select  'SOV'||t1||t2||t3, to_char(soato), sovet ||' �����',  name
 from wrk_GEO where  sovet is not null and raion is not null --order by 1,2,3-- 27189  ���. ������ (����/���) 
  union all
 select distinct 'RAI'||t1||t2 child_id,  'SOV'||t1||t2||t3,  
raion, sovet from wrk_GEO  where  sovet is not null and raion is not null ; -- 1553 �������� ������ (��������� ���������� )
--union all select '-99','BY', '��������','��������' from dual;
--order by raion;                                                            
select * from view_wrk_Geo;


select * from view_wrk_Geo t1 inner join view_wrk_Geo t2
on t1.par_id = t2.child_id;
