BEGIN
    pkg_utl_drop_object.drop_proc(object_name => 'TEST_TABLE', object_type => 'TABLE');
END;

CREATE TABLE test_table
(
	test_surrid NUMBER,
	test_natkey VARCHAR2(20),
	test_desc VARCHAR2(200)
);