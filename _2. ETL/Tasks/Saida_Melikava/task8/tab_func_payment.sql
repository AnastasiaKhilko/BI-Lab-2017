CREATE OR REPLACE TYPE Paym_type
AS
  OBJECT
  (
  code     NUMBER(8),
  type       VARCHAR2 ( 200 CHAR ),
  descr      VARCHAR2 ( 200 CHAR ),
  prepayment VARCHAR2 ( 200 CHAR ));
  /
CREATE OR REPLACE TYPE Paym_func
AS
  TABLE OF Paym_type;
  /
CREATE OR REPLACE PACKAGE refcur_pkg AUTHID DEFINEr
IS
TYPE refcur_t
IS
  REF
  CURSOR
    RETURN bl_cl.wrk_payment%ROWTYPE;
  END refcur_pkg;
  /
CREATE OR REPLACE FUNCTION tab_func(
  p refcur_pkg.refcur_t)
RETURN Paym_func AUTHID DEFINER PIPELINED
IS
  out_rec Paym_type := Paym_type(NULL,NULL,NULL,NULL);
  in_rec p%ROWTYPE;
BEGIN
  LOOP
    FETCH p INTO in_rec;
  EXIT
WHEN p%NOTFOUND;
  out_rec.code       := in_rec.code;
  out_rec.type       :=in_rec.type;
  out_rec.descr      := in_rec.descr;
  out_rec.prepayment := in_rec.prepayment;
  PIPE ROW(out_rec);
END LOOP;
CLOSE p;
RETURN;
END tab_func;
/
SELECT * FROM TABLE(tab_func(CURSOR
  (SELECT * FROM bl_cl.wrk_payment
  )));
