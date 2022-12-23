-- 1. Розробити механізм журналізації DML-операцій, що виконуються над таблицею
-- вашої бази даних, враховуючи такі дії:
-- – створити таблицю з ім'ям LOG_ім'я_таблиці. Структура таблиці повинна
-- включати: ім'я користувача, тип операції, дата виконання операції, атрибути, що містять
-- старі та нові значення.
-- – створити тригер журналювання.
-- Перевірити роботу тригера журналювання для операцій INSERT, UPDATE,
-- DELETE.

CREATE TABLE client_log
(
    operation_author VARCHAR2(64),
    operation_type   VARCHAR(16),
    operation_date   DATE,
    new_name         VARCHAR2(30),
    old_name         VARCHAR2(30),
    new_address      VARCHAR2(100),
    old_address      VARCHAR2(100),
    new_phone        VARCHAR2(24),
    old_phone        VARCHAR2(24),
    new_birthday     DATE,
    old_birthday     DATE,
    new_email        VARCHAR2(64),
    old_email        VARCHAR2(64)
);

CREATE OR REPLACE TRIGGER client_log
    AFTER INSERT OR UPDATE OR DELETE
    ON client
    FOR EACH ROW
DECLARE
    operation_type client_log.operation_type%TYPE;
BEGIN
    IF INSERTING THEN
        operation_type := 'INSERT';
    ELSIF UPDATING THEN
        operation_type := 'UPDATE';
    ELSIF DELETING THEN
        operation_type := 'DELETE';
    END IF;

    INSERT
    INTO client_log
    VALUES (USER, operation_type, SYSDATE,
            :new.name, :old.name,
            :new.address, :old.address,
            :new.phone_number, :old.phone_number,
            :new.birthday, :old.birthday,
            :new.email, :old.email);
END;
/

INSERT
INTO client (id, name, address, phone_number, birthday, email)
VALUES (client_id_seq.nextval, 'Petro Kulish', 'Lutsk, Some str. 5', '+58(401)590-01-22', '27/12/1999',
        'petrokulish@ukr.com.ua');

UPDATE client
SET name = 'Sophia Panteleymonova'
WHERE id = 30108;

DELETE client
WHERE id = 30108;

-- Виведу лише перші колонки таблиці (всі не влазять)
SELECT operation_author,
       operation_type,
       operation_date,
       new_name,
       old_name
FROM client_log;

-- +----------------+--------------+-------------------+---------------------+---------------------+
-- |OPERATION_AUTHOR|OPERATION_TYPE|OPERATION_DATE     |NEW_NAME             |OLD_NAME             |
-- +----------------+--------------+-------------------+---------------------+---------------------+
-- |POSHTARENKO     |INSERT        |2022-12-23 10:44:25|Petro Kulish         |null                 |
-- |POSHTARENKO     |UPDATE        |2022-12-23 10:44:27|Sophia Panteleymonova|Petro Kulish         |
-- |POSHTARENKO     |DELETE        |2022-12-23 10:44:28|null                 |Sophia Panteleymonova|
-- +----------------+--------------+-------------------+---------------------+---------------------+

-- 2. Припустимо, що використовується СУБД до 12-ї версії, яка не підтримує механізм
-- DEFAULT SEQUENCE, який дозволяє автоматично внести нове значення первинного
-- ключа, якщо воно не задано при операції внесення. Для будь-якої колонки вашої бази даних
-- створити тригер з підтримкою механізму DEFAULT SEQUENCE. Навести тест-кейс
-- перевірки роботи тригера.

CREATE OR REPLACE TRIGGER furniture_default_sequence
    BEFORE INSERT
    ON furniture
    FOR EACH ROW
BEGIN
    IF :new.id IS NULL THEN
        :new.id := furniture_id_seq.nextval;
    END IF;
END;
/

INSERT
INTO furniture (name, type_code, producer, amount, production_time, price)
VALUES ('Bed N11', 1, 'Lviv factory', 15, 25, 5000.00);

SELECT id,
       name,
       price
FROM furniture
WHERE name = 'Bed N11';

-- +--+-------+-------+
-- |ID|NAME   |PRICE  |
-- +--+-------+-------+
-- |66|Bed N11|5000.00|
-- +--+-------+-------+