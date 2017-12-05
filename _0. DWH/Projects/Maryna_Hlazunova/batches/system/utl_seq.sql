-- Packsge for sequences

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_utl_seq_def.sql

@pkg_utl_seq_impl.sql


CONNECT bl_cl_dwh/bl_cl_dwh;

SHOW USER;

@pkg_utl_seq_def.sql

@pkg_utl_seq_impl.sql