-- Помилки :
-- L014	2 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	3 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L029	3 / 5	
-- Keywords should not be used as identifiers.
-- L014	4 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	10 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	11 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L029	11 / 5	
-- Keywords should not be used as identifiers.
-- L014	12 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	13 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	14 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	15 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	16 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L008	16 / 19	
-- Unquoted identifiers must be consistently pascal case.
-- L014	21 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L029	21 / 5	
-- Keywords should not be used as identifiers.
-- L014	22 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	23 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	24 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	28 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	29 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	30 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	31 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	32 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L008	32 / 27	
-- Unquoted identifiers must be consistently pascal case.
-- L014	34 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	38 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	39 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	40 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	41 / 5	
-- Unquoted identifiers must be consistently pascal case.

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
