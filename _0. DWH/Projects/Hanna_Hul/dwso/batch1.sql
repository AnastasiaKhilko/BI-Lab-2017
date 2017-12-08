EXEC PKG_LOAD_3NF_CUSTOMERS.LOAD_WRK_CUSTOMERS;
EXEC PKG_LOAD_3NF_CARDS.LOAD_CLS_CARD_TYPES;
EXEC PKG_LOAD_3NF_CARDS.LOAD_CE_CARD_TYPES;
EXEC PKG_LOAD_3NF_BANKS.INSERT_BANKS;
EXEC PKG_LOAD_3NF_BANKS.LOAD_CLS_BANKS;
EXEC PKG_LOAD_3NF_BANKS.LOAD_CE;
EXEC PKG_LOAD_3NF_CARDS.LOAD_CLS_CARDS;
EXEC PKG_LOAD_3NF_CARDS.LOAD_CE_CARDS;
EXEC PKG_LOAD_3NF_SOURCES.LOAD_TO_WRK;
EXEC PKG_LOAD_3NF_HOTELS.LOAD_HOTELS;
EXEC BL_CL.LOAD_LOCATIONS;
EXEC PKG_LOAD_3NF_SOURCES.LOAD_CLS_SOURCES;
EXEC PKG_LOAD_3NF_SOURCES.LOAD_CE;
EXEC PKG_LOAD_3NF_CATEGORIES.LOAD_WRK_CATEGORIES;
EXEC PKG_LOAD_3NF_CATEGORIES.LOAD_CLS_CATEGORIES;
EXEC PKG_LOAD_3NF_CATEGORIES.LOAD_CE;
EXEC PKG_LOAD_3NF_HOTELS.LOAD_HOTELS_CLS;
EXEC PKG_LOAD_3NF_HOTELS.LOAD_CE;
EXEC PKG_LOAD_3NF_CUSTOMERS.INSERT_TABLE_CUSTOMERS;
EXEC PKG_LOAD_3NF_CUSTOMERS.MERGE_TABLE_CE_CUSTOMERS;
EXEC PKG_LOAD_3NF_FACT.GENERATE_FACT;
EXEC BL_3NF.DO_TRUNCATE;
EXEC PKG_LOAD_3NF_FACT.LOAD_FACT;