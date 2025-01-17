CREATE TABLE CE_CUSTOMER
  (
    CUSTOMER_SRCID NUMBER (8)        NOT NULL,
    FIRST_NAME     VARCHAR2 (25)     NOT NULL,
    MIDDLE_NAME    VARCHAR2 (25)     NOT NULL,
    LAST_NAME      VARCHAR2 (25)     NOT NULL,
    AGE            NUMBER (4)        NOT NULL,
    GENDER         VARCHAR2 (4)      NOT NULL,
    EMAIL          VARCHAR2 (25)     NOT NULL,
    PHONE          NUMBER (8)        NOT NULL,
    ADDRESS_SRCID  NUMBER (8)        NOT NULL,
    CONSTRAINT "PK_CUSTOMER_SRCID" PRIMARY KEY (CUSTOMER_SRCID),
    CONSTRAINT "FK_ADDRESS_SRCID" FOREIGN KEY (ADDRESS_SRCID) REFERENCES CE_ADDRESS (ADDRESS_SRCID)
  );