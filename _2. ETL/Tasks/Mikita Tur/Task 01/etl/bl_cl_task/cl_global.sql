create table cl_global 
  (
    global_id number(10),
    global_desc varchar2(100 char)
  );
  insert into cl_global (global_id, global_desc
  )
SELECT child_code,
  structure_desc
FROM sa_src_task.EXT_STRUCTURES
WHERE structure_level='World';
