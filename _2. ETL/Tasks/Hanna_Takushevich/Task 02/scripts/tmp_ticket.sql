CREATE SEQUENCE ticket_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE TABLE tmp_ticket (
    ticket_id       NUMBER PRIMARY KEY,
    service_class   VARCHAR2(30),
    flight_code     VARCHAR2(10)
);

INSERT INTO tmp_ticket SELECT
    ticket_seq.NEXTVAL,
    CASE round(dbms_random.value(1,3) - 0.3)
        WHEN 1   THEN 'Economy class'
        WHEN 2   THEN 'Standard class'
        WHEN 3   THEN 'Business class'
    END,
    dbms_random.string('u',10)
FROM
    (
        SELECT
            level n
        FROM
            dual
        CONNECT BY
            level <= 100000
    );

COMMIT;