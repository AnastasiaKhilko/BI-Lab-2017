CREATE TABLE sellers
  (
    seller_id         number(8) PRIMARY KEY,
    First_name       VARCHAR2(30) NOT NULL,
    Middle_name  VARCHAR2(4) ,
    Second_name    VARCHAR2(30) NOT NULL,
    age        NUMBER(3) NOT NULL,
    gender     VARCHAR2(10) NOT NULL,
    seller_address_id NUMBER(8) NOT NULL,
    seller_contact_id   number(8) not null,
    stock_id number(8) not null,
    CONSTRAINT fk_sell_address FOREIGN KEY (seller_address_id) REFERENCES address(address_id),
    CONSTRAINT fk_sell_cont FOREIGN KEY (seller_contact_id) REFERENCES contacts(contact_id),
    CONSTRAINT fk_sell_stk FOREIGN KEY (stock_id) REFERENCES stocks(stock_id)
    
  );
