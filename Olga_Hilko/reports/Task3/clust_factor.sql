 SELECT t.table_name||'.'||i.index_name idx_name,
        i.clustering_factor,
        t.blocks,
        t.num_rows
   FROM user_indexes i, user_tables t
  WHERE i.table_name = t.table_name
    AND t.table_name  IN( 'T5','EMPLRAND' );