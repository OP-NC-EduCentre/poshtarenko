-- 1. Створити інформуючий тригер для виведення повідомлення на екран після
-- додавання, зміни або видалення рядка з будь-якої таблиці Вашої бази даних із зазначенням
-- у повідомленні операції, на яку зреагував тригер. Навести тест-кейс перевірки роботи
-- тригера.

CREATE OR REPLACE TRIGGER furniture_modification_after
    AFTER INSERT OR UPDATE OR DELETE ON furniture
BEGIN
    IF INSERTING THEN
        dbms_output.put_line('INSERTING INTO FURNITURE ... ');
    ELSIF UPDATING THEN
        dbms_output.put_line('UPDATING FURNITURE ... ');
    ELSIF DELETING THEN
        dbms_output.put_line('DELETING FURNITURE ... ');
    END IF;
END;


INSERT INTO furniture (id, name, type_code, producer, amount, production_time, price)
VALUES (furniture_id_seq.nextval, 'Bed N9', 1, 'Lviv factory', 12, 35, 6000.00);

-- [2022-12-23 09:57:53] 1 row affected in 594 ms
-- INSERTING INTO FURNITURE ...

UPDATE furniture
SET price = price + 300.00
WHERE id = 5;

-- [2022-12-23 09:59:50] 1 row affected in 603 ms
-- UPDATING FURNITURE ...

DELETE FROM furniture WHERE id = 5;

-- [2022-12-23 10:00:10] 1 row affected in 606 ms
-- DELETING FURNITURE ...

-- 2. Повторити попереднє завдання лише під час роботи користувача, ім'я якого
-- збігається з вашим логіном. Навести тест-кейс перевірки роботи тригера.

CREATE OR REPLACE TRIGGER furniture_modification_after
    AFTER INSERT OR UPDATE OR DELETE ON furniture
    FOR EACH ROW
    WHEN (USER = 'poshtarenko')
BEGIN
    IF INSERTING THEN
        dbms_output.put_line('INSERTING INTO FURNITURE ... ');
    ELSIF UPDATING THEN
        dbms_output.put_line('UPDATING FURNITURE ... ');
    ELSIF DELETING THEN
        dbms_output.put_line('DELETING FURNITURE ... ');
    END IF;
END;

INSERT INTO furniture (id, name, type_code, producer, amount, production_time, price)
VALUES (furniture_id_seq.nextval, 'Bed N9', 1, 'Lviv factory', 12, 35, 6000.00);

UPDATE furniture
SET price = price + 300.00
WHERE id = 5;

DELETE FROM furniture WHERE id = 5;

-- [2022-12-23 10:03:19] 1 row affected in 608 ms
-- INSERTING INTO FURNITURE ...
-- [2022-12-23 10:03:21] 1 row affected in 605 ms
-- UPDATING FURNITURE ...
-- [2022-12-23 10:03:23] 1 row affected in 605 ms
-- DELETING FURNITURE ...

-- Для демонстрації невиконання умови тригера змінимо ім'я користувача

CREATE OR REPLACE TRIGGER furniture_modification_after
    AFTER INSERT OR UPDATE OR DELETE ON furniture
    FOR EACH ROW
    WHEN (USER = 'not_poshtarenko')
BEGIN
    IF INSERTING THEN
        dbms_output.put_line('INSERTING INTO FURNITURE ... ');
    ELSIF UPDATING THEN
        dbms_output.put_line('UPDATING FURNITURE ... ');
    ELSIF DELETING THEN
        dbms_output.put_line('DELETING FURNITURE ... ');
    END IF;
END;

INSERT INTO furniture (id, name, type_code, producer, amount, production_time, price)
VALUES (furniture_id_seq.nextval, 'Bed N9', 1, 'Lviv factory', 12, 35, 6000.00);

UPDATE furniture
SET price = price + 300.00
WHERE id = 5;

DELETE FROM furniture WHERE id = 5;

-- Повідомлення не виводяться
-- [2022-12-23 10:05:26] 1 row affected in 608 ms
-- [2022-12-23 10:05:27] completed in 503 ms
-- [2022-12-23 10:05:29] completed in 502 ms
