-- WRK_PANTY_SIZES.
BEGIN
  pkg_drop.drop_proc(object_name => 'wrk_panty_sizes', object_type => 'table');
END;

CREATE TABLE wrk_panty_sizes
(
 panty_size_code NUMBER (20),
 panty_size_uk  VARCHAR2 ( 200 CHAR ),
 panty_size_usa VARCHAR2 ( 200 CHAR ),
 panty_size_eu  VARCHAR2 ( 200 CHAR ),
 panty_size_fr  VARCHAR2 ( 200 CHAR ),
 panty_size_uie VARCHAR2 ( 200 CHAR )
);