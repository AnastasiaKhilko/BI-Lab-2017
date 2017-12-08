PACKAGE PKG_LOAD_DATE compiled
PACKAGE BODY PKG_LOAD_DATE compiled
Errors: check compiler log
PACKAGE BODY PKG_LOAD_DATE compiled
PACKAGE BODY PKG_LOAD_DATE compiled
Errors: check compiler log
Error starting at line : 81 in command -
exec pkg_load_date.generate_date
Error report -
ORA-04063: package body "BL_CL2.PKG_LOAD_DATE" has errors
ORA-06508: PL/SQL: could not find program unit being called: "BL_CL2.PKG_LOAD_DATE"
ORA-06512: at line 1
04063. 00000 -  "%s has errors"
*Cause:    Attempt to execute a stored procedure or use a view that has
           errors.  For stored procedures, the problem could be syntax errors
           or references to other, non-existent procedures.  For views,
           the problem could be a reference in the view's defining query to
           a non-existent table.
           Can also be a table which has references to non-existent or
           inaccessible types.
*Action:   Fix the errors and/or create referenced objects as necessary.
PACKAGE BODY PKG_LOAD_DATE compiled
anonymous block completed
anonymous block completed
PACKAGE BODY PKG_LOAD_DATE compiled
anonymous block completed
Error starting at line : 85 in command -
exec pkg_load_date.load_date
Error report -
ORA-00001: unique constraint (BL_DWH.PK_DATE_ID) violated
ORA-06512: at "BL_CL2.PKG_LOAD_DATE", line 72
ORA-06512: at line 1
00001. 00000 -  "unique constraint (%s.%s) violated"
*Cause:    An UPDATE or INSERT statement attempted to insert a duplicate key.
           For Trusted Oracle configured in DBMS MAC mode, you may see
           this message if a duplicate entry exists at a different level.
*Action:   Either remove the unique restriction or do not insert the key.
PACKAGE BODY PKG_LOAD_DATE compiled
anonymous block completed
Error starting at line : 85 in command -
exec pkg_load_date.load_date
Error report -
ORA-00001: unique constraint (BL_DWH.PK_DATE_ID) violated
ORA-06512: at "BL_CL2.PKG_LOAD_DATE", line 72
ORA-06512: at line 1
00001. 00000 -  "unique constraint (%s.%s) violated"
*Cause:    An UPDATE or INSERT statement attempted to insert a duplicate key.
           For Trusted Oracle configured in DBMS MAC mode, you may see
           this message if a duplicate entry exists at a different level.
*Action:   Either remove the unique restriction or do not insert the key.
