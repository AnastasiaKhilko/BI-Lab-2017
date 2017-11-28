CREATE TABLE ce_customer_cards
  (
    Customer_card         VARCHAR2(30) PRIMARY KEY,
    Customer_card_expires VARCHAR2(10) NOT NULL,
    insert_DT DATE NOT NULL,
    update_DT DATE NULL
  );