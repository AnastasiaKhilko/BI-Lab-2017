execute DBMS_MVIEW.EXPLAIN_MVIEW('MV1');

SELECT mview_name, refresh_mode, refresh_method,
last_refresh_type, last_refresh_date
FROM user_mviews;
----------------------------------------------------------------------
SET SERVEROUTPUT ON;
DECLARE
    result SYS.EXPLAINMVARRAYTYPE := SYS.EXPLAINMVARRAYTYPE();
BEGIN
    DBMS_MVIEW.EXPLAIN_MVIEW('MV1', result);

    FOR i IN result.FIRST..result.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(result(i).CAPABILITY_NAME || ': ' || CASE WHEN result(i).POSSIBLE = 'T' THEN 'Yes' ELSE 'No' || CASE WHEN result(i).RELATED_TEXT IS NOT NULL THEN ' because of ' || result(i).RELATED_TEXT END || '; ' || result(i).MSGTXT END);
    END LOOP;
END;