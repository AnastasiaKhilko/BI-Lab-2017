--drop MATERIALIZED VIEW mat_view;
CREATE  MATERIALIZED VIEW mat_view REFRESH FORCE
ON DEMAND ENABLE QUERY REWRITE
AS SELECT *
FROM tab_src
ORDER BY 1 ;

BEGIN
  DBMS_STATS.gather_table_stats('user_view','tab_src' );
END;
/

BEGIN
   DBMS_REFRESH.make(
     name                 => 'user_view.minute_refresh',
     list                 => '',
     next_date            => SYSDATE,
     interval             => '/*1:Mins*/ SYSDATE + 1/(60*24)'
                    );
END;
/
BEGIN
   DBMS_REFRESH.add(
     name => 'user_view.minute_refresh',
     list => 'user_view.mat_view',
     lax  => TRUE);
END;
/
EXEC DBMS_MVIEW.refresh('mat_view');

EXPLAIN PLAN FOR
SELECT *  FROM   tab_src;
SELECT * FROM table(dbms_xplan.display);

