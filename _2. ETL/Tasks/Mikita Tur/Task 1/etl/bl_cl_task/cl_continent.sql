create table cl_continent
  (
    continent_id number(10),
    continent_desc varchar2(100 char),
    global_id number(10)
  );
INSERT INTO cl_continent
  (cintinent_id, continent_desc,global_id
  )
SELECT child_code,
  structure_desc,
  parent_code
FROM sa_src_task.EXT_STRUCTURES
WHERE structure_level='Continents';
commit;