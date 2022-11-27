CREATE TABLE Type (
    code NUMBER(3),
    name VARCHAR(30),
    description VARCHAR(100)
);

-- Я не додав колонку "is_present", яка була в моїй діаграмі,
-- тому що вона не має сенсу коли є колонка "amount"
CREATE TABLE Furniture (
    id NUMBER(9),
    name VARCHAR(30),
    type_code NUMBER(3),
    producer VARCHAR(30),
    amount NUMBER(5),
    production_time NUMBER(3), -- in days
    price NUMBER(9,2)
);

CREATE TABLE Client (
    id NUMBER(9),
    name VARCHAR(30),
    address VARCHAR(100),
    phone_number VARCHAR(12),
    birthday DATE
);

CREATE TABLE "Order" (
    id NUMBER(9),
    client_id NUMBER(9),
    creation_date DATE,
    deadline_date DATE,
    summary_price NUMBER(9,2),
    is_paid CHAR(1),
    is_done CHAR(1)
);

CREATE TABLE Sale (
    id NUMBER(9),
    order_id NUMBER(9),
    furniture_id NUMBER(9),
    amount NUMBER(5)
);