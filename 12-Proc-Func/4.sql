-- 4.1. З урахуванням вашої предметної області створити табличну функцію, що
-- повертає значення будь-яких двох колонок будь-якої таблиці з урахуванням значення однієї
-- з колонок, що передається як параметр. Показати приклад виклику функції.

CREATE TYPE furniture_main_info AS OBJECT
(
    name  VARCHAR(30),
    price NUMBER(9, 2)
);

CREATE TYPE furniture_item_list IS TABLE OF furniture_main_info;

CREATE OR REPLACE FUNCTION get_furniture_by_producer(producer_name IN furniture.producer%TYPE)
    RETURN furniture_item_list
AS
    furniture_list furniture_item_list := furniture_item_list();
BEGIN
    SELECT furniture_main_info(name, price) BULK COLLECT
    INTO furniture_list
    FROM furniture
    WHERE producer = producer_name;
    RETURN furniture_list;
END;
/


SELECT name,
       price
FROM TABLE (get_furniture_by_producer('Lviv_factory'));

-- +----------+--------+
-- |NAME      |PRICE   |
-- +----------+--------+
-- |Bed NNN1  |7000.00 |
-- |Shelf N453|3000.00 |
-- |Bed N4    |11300.00|
-- +----------+--------+

-- 4.2. Повторіть рішення попереднього завдання, але з використанням конвеєрної
-- табличної функції.

CREATE OR REPLACE PACKAGE furniture_utils_pipelined IS
    TYPE furniture_main_info IS RECORD
                                (
                                    name  VARCHAR(30),
                                    price NUMBER(9, 2)
                                );
    TYPE furniture_item_list IS TABLE OF furniture_main_info;
    FUNCTION get_furniture_by_producer(producer_name IN furniture.producer%TYPE)
        RETURN furniture_item_list PIPELINED;
END furniture_utils_pipelined;
/

CREATE OR REPLACE PACKAGE BODY furniture_utils_pipelined IS
    FUNCTION get_furniture_by_producer(producer_name IN furniture.producer%TYPE)
        RETURN furniture_item_list PIPELINED
    AS
        furniture_list furniture_item_list := furniture_item_list();
    BEGIN
        FOR item IN (SELECT name,
                            price
                     FROM furniture
                     WHERE producer = producer_name)
            LOOP
                PIPE ROW (item);
            END LOOP;
    END;
END furniture_utils_pipelined;
/


SELECT name,
       price
FROM TABLE (furniture_utils_pipelined.get_furniture_by_producer('Lviv_factory'));

-- +----------+--------+
-- |NAME      |PRICE   |
-- +----------+--------+
-- |Bed NNN1  |7000.00 |
-- |Shelf N453|3000.00 |
-- |Bed N4    |11300.00|
-- +----------+--------+