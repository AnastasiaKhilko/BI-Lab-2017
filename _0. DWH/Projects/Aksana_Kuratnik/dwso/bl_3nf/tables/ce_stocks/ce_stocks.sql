CREATE TABLE stocks
  (
    Stock_id              NUMBER(8) PRIMARY KEY,
    Stock_name            VARCHAR2(30) NOT NULL,
    Contact_id          NUMBER(8) NOT NULL,
    address_id      NUMBER(8) NOT NULL,
    open_date_id       DATE NOT NULL,
    CONSTRAINT fk_stock_contact FOREIGN KEY (contact_id) REFERENCES contacts(contact_id),
    CONSTRAINT fk_stock_address FOREIGN KEY (address_id) REFERENCES address(address_id),
    CONSTRAINT fk_stock_date FOREIGN KEY (open_date_id) REFERENCES ddate(date_id)
  );