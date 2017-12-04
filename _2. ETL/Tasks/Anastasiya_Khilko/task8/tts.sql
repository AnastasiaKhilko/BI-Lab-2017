EXEC SYS.DBMS_TTS.TRANSPORT_SET_CHECK(ts_list => 'TEST_DATA', incl_constraints => TRUE);
SELECT * FROM transport_set_violations;

select name, value from v$parameter where name in ('db_block_size','compatible')
union all
select parameter, value from nls_database_parameters where parameter like '%characterset';


ALTER TABLESPACE test_data READ WRITE;

CREATE OR REPLACE DIRECTORY temp_dir AS '/tmp/';
GRANT READ, WRITE ON DIRECTORY temp_dir TO system;

expdp directory = temp_dir transport_tablespaces=test_data dumpfile = test.dmp


expdp userid='sys/password as sysdba' 
transport_tablespace=y tablespaces=test_data file=test_data.dmp log=test_data_exp.log

ALTER TABLESPACE test_data READ WRITE;

CREATE OR REPLACE DIRECTORY temp_dir AS '/tmp/';
GRANT READ, WRITE ON DIRECTORY temp_dir TO system;

impdp userid=system/password directory=temp_dir dumpfile=test_data.dmp logfile=test_data_imp.log 
transport_datafiles='/u01/app/oracle/oradata/DB11GB/test_data01.dbf'

SELECT tablespace_name, plugged_in, status
FROM   dba_tablespaces
WHERE  tablespace_name = 'TEST_DATA';

SELECT tablespace_name, plugged_in, status
FROM   dba_tablespaces
WHERE  tablespace_name = 'TEST_DATA';
