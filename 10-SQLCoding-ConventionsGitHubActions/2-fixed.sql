CREATE TABLE Type (
    Code NUMBER(3),
    Type_Name VARCHAR(30),
    Description VARCHAR(100)
);

-- Я не додав колонку "is_present", яка була в моїй діаграмі,
-- тому що вона не має сенсу коли є колонка "amount"
CREATE TABLE Furniture (
    Id NUMBER(9),
    Item_Name VARCHAR(30),
    Type_Code NUMBER(3),
    Producer VARCHAR(30),
    Amount NUMBER(5),
    Production_Time NUMBER(3), -- in days
    Price NUMBER(9, 2)
);

CREATE TABLE Client (
    Id NUMBER(9),
    Client_Name VARCHAR(30),
    Address VARCHAR(100),
    Phone_Number VARCHAR(12),
    Birthday DATE
);

CREATE TABLE "Order" (
    Id NUMBER(9),
    Client_Id NUMBER(9),
    Creation_Date DATE,
    Deadline_Date DATE,
    Summary_Price NUMBER(9, 2),
    Is_Paid CHAR(1),
    Is_Done CHAR(1)
);

CREATE TABLE Sale (
    Id NUMBER(9),
    Order_Id NUMBER(9),
    Furniture_Id NUMBER(9),
    Amount NUMBER(5)
);
