-- CLS_PANTY_SIZES.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_panty_sizes', object_type => 'table');
END;

CREATE TABLE cls_panty_sizes
(
 panty_size_id  NUMBER ( 10 ) NOT NULL,
 panty_size_uk  VARCHAR2 ( 200 CHAR ) NOT NULL,
 panty_size_usa VARCHAR2 ( 200 CHAR ) NOT NULL,
 panty_size_eu  VARCHAR2 ( 200 CHAR ) NOT NULL,
 panty_size_fr  VARCHAR2 ( 200 CHAR ) NOT NULL,
 panty_size_uie VARCHAR2 ( 200 CHAR ) NOT NULL
);