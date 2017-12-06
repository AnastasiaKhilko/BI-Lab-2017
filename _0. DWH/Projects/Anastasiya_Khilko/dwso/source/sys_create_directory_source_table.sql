drop directory source_table;
create directory source_table
as 'D:\Anastasiya_Khilko\shared_dwh\';

grant read on directory source_table to sa_src;
grant write on directory source_table to sa_src;
grant read on directory source_table to bl_cl;
grant write on directory source_table to bl_cl;