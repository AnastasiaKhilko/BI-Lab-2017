CREATE TABLE tmp_sales (
    ticket_id    NUMBER,
    cust_id      NUMBER,
    date_id      DATE,
    airline_id   NUMBER,
    price        NUMBER,
    amount       NUMBER,
    CONSTRAINT fk_sales_ticket FOREIGN KEY ( ticket_id )
        REFERENCES tmp_ticket ( ticket_id ),
    CONSTRAINT fk_sales_cust FOREIGN KEY ( cust_id )
        REFERENCES tmp_customers ( cust_id ),
    CONSTRAINT fk_sales_date FOREIGN KEY ( date_id )
        REFERENCES tmp_date ( date_id ),
    CONSTRAINT fk_sales_airline FOREIGN KEY ( airline_id )
        REFERENCES tmp_airline ( airline_id )
);

INSERT INTO tmp_sales SELECT
    round(dbms_random.value(
        (
            SELECT
                MIN(ticket_id)
            FROM
                tmp_ticket
        ),
        (
            SELECT
                MAX(ticket_id)
            FROM
                tmp_ticket
        )
    ) ) AS ticket,
    round(dbms_random.value(
        (
            SELECT
                MIN(cust_id)
            FROM
                tmp_customers
        ),
        (
            SELECT
                MAX(cust_id)
            FROM
                tmp_customers
        )
    ) ) AS customer,
    trunc(SYSDATE - dbms_random.value(1,1080) ) AS s_date,
    round(dbms_random.value(
        (
            SELECT
                MIN(airline_id)
            FROM
                tmp_airline
        ),
        (
            SELECT
                MAX(airline_id)
            FROM
                tmp_airline
        )
    ) ) AS airline,
    round(
        dbms_random.value(10000,100000),
        2
    ) AS price,
    round(dbms_random.value(
        0.5,
        5.5
    ) ) AS amount
FROM
    (
        SELECT
            level n
        FROM
            dual
        CONNECT BY
            level <= 10000
    );

COMMIT;