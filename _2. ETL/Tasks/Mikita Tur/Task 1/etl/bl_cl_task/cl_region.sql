create table cl_region 
  (
  region_id number(10),
  region_desc varchar2(100 char),
  continent_id number(10)
  );
INSERT INTO cl_region
  (region_id, region_desc,continent_id
  )
SELECT child_code,
  structure_desc,
  parent_code
FROM sa_src_task.EXT_STRUCTURES
WHERE structure_level='Regions';
commit;