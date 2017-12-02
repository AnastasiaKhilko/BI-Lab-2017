TRUNCATE TABLE cl_state;
INSERT INTO cl_state
SELECT 
  st.state_num ,
  st.DEST_STATE_NM,
  st.country_num 
FROM
  (SELECT DISTINCT state_num , DEST_STATE_NM, country_num  FROM wrk_state
  ) st
WHERE state_num IS NOT NULL
AND  DEST_STATE_NM IS NOT NULL
AND country_num IS NOT NULL;