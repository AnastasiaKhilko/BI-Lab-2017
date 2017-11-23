DROP TABLE error_log;
CREATE TABLE error_log
  (
    code    NUMBER,
    MESSAGE VARCHAR2(4000),
    backtrace CLOB,
    callstack CLOB,
    user_name VARCHAR2(30),
    error_dt  DATE
  );
CREATE OR REPLACE PROCEDURE err_log
IS
  pragma AUTONOMOUS_TRANSACTION;
  l_code NUMBER        := SQLCODE;
  l_msg  VARCHAR2(4000):= SQLERRM;
BEGIN
  INSERT
  INTO error_log
    (
      CODE,
      MESSAGE,
      BACKTRACE,
      CALLSTACK,
      USER_NAME,
      ERROR_DT
    )
    VALUES
    (
      l_code,
      l_msg,
      SYS.DBMS_UTILITY.FORMAT_ERROR_STACK,
      SYS.DBMS_UTILITY.FORMAT_CALL_STACK,
      USER,
      sysdate
    );
  COMMIT;
END;
/
show errors