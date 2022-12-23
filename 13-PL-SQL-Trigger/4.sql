-- 1. Створити таблицю для реєстрації наступних DDL-подій: тип події, що спричинила
-- запуск тригера; ім'я користувача; ім'я об'єкта БД. Створити тригер реєстрації заданих подій
-- створення об'єктів. Подати тест-кейси перевірки роботи тригера.

CREATE TABLE ddl_log
(
    operation_type  VARCHAR2(64),
    author_username VARCHAR2(64),
    object_name     VARCHAR2(64)
);

CREATE OR REPLACE TRIGGER ddl_log
    AFTER CREATE OR ALTER OR DROP
    ON poshtarenko.SCHEMA
BEGIN
    INSERT
    INTO ddl_log (operation_type, author_username, object_name)
    VALUES (ORA_SYSEVENT, ORA_LOGIN_USER, ORA_DICT_OBJ_NAME);
END;
/

CREATE TABLE some_table
(
    some_field NUMBER(3)
);

ALTER TABLE some_table
    ADD CONSTRAINT some_constraint CHECK (some_field > 0);

DROP TABLE some_table;

SELECT *
FROM ddl_log;

-- +--------------+---------------+-----------+
-- |OPERATION_TYPE|AUTHOR_USERNAME|OBJECT_NAME|
-- +--------------+---------------+-----------+
-- |CREATE        |POSHTARENKO    |SOME_TABLE |
-- |ALTER         |POSHTARENKO    |SOME_TABLE |
-- |DROP          |POSHTARENKO    |SOME_TABLE |
-- +--------------+---------------+-----------+