
--select * from (
SELECT CHILD_ID ID1, substr(CHILD_NAME,1,15) "�����������", 
PAR_ID ID2, PAR_NAME "�������", '��==>'|| LTRIM(SYS_CONNECT_BY_PATH(CHILD_NAME, '==>'), '==>') AS "����. �������",
--level, CONNECT_BY_ISLEAF,
  CASE 
  WHEN level = 1 THEN '������'
  WHEN level > 1 AND CONNECT_BY_ISLEAF =0   THEN '�����'
  WHEN level > 1 AND CONNECT_BY_ISLEAF =1    THEN '����'
  ELSE '������'
  END AS "�������",
 (SELECT COUNT(*) FROM view_wrk_Geo  WHERE geo.child_id = par_id) AS "����� ��. ��-���"
FROM view_wrk_Geo geo START WITH PAR_ID = 'BY'
CONNECT BY PRIOR child_id = par_id
ORDER SIBLINGS BY 1, 3;
--)where PAR_ID!='-99';



--������� �����. ���.
WITH cte (CHILD_ID ,CHILD_NAME, PAR_ID, PAR_NAME, Hierarchy, lev,  "Count of Children") AS (
  SELECT CHILD_ID ,CHILD_NAME, PAR_ID, PAR_NAME, CHILD_NAME AS Hierarchy, '������' AS lev,
         (SELECT COUNT(*) FROM view_wrk_Geo  WHERE dc.child_id = par_id) AS "Count of Children"
  FROM view_wrk_Geo dc
  WHERE par_id ='BY'
  UNION ALL
  SELECT dl.CHILD_ID ,dl.CHILD_NAME, dl.PAR_ID, dl.PAR_NAME, cte.Hierarchy || '\' || dl.CHILD_NAME AS Hierarchy,
          CASE 
          WHEN (SELECT COUNT(*) FROM view_wrk_Geo  WHERE dl.child_id = par_id) != 0 
          THEN '�����'
          WHEN dl.par_id IS NULL AND (SELECT COUNT(*) FROM view_wrk_Geo  WHERE dl.child_id = par_id) = 0 
          THEN '����������'
          ELSE '����'
          END AS lev,
         (SELECT COUNT(*) FROM view_wrk_Geo  WHERE dl.child_id = par_id) AS "Count of Children"
  FROM view_wrk_Geo dl
  JOIN cte 
  ON dl.par_id = cte.child_id)
 SELECT CHILD_ID  ID1, CHILD_NAME "�����������", PAR_ID ID2, PAR_NAME "�������", 
 Hierarchy, lev as "�������", "Count of Children" as "���-�� ��. ��."
FROM cte;
