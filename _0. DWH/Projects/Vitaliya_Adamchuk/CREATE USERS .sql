--sa_src
CREATE USER sa_src
    IDENTIFIED BY "Q1w2e3r4"
    default TABLESPACE TBS_DWH_TEST;

grant all privileges to sa_src identified by "Q1w2e3r4";

--bl_cl
CREATE USER bl_cl
    IDENTIFIED BY "Q1w2e3r4"
    default TABLESPACE TBS_DWH_TEST;

grant all privileges to bl_cl identified by "Q1w2e3r4";

--bl_3nf
CREATE USER bl_3nf
    IDENTIFIED BY "Q1w2e3r4"
    default TABLESPACE TBS_DWH_TEST;

grant all privileges to bl_3nf identified by "Q1w2e3r4";

--bl_dm
CREATE USER bl_dm
    IDENTIFIED BY "Q1w2e3r4"
    default TABLESPACE TBS_DWH_TEST;

grant all privileges to bl_dm identified by "Q1w2e3r4";