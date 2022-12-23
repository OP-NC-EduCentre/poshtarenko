-- 1. Створити тригер для реалізації каскадного видалення рядків зі значеннями PK-
-- колонки, пов'язаних з FK-колонкою. Навести тест-кейс перевірки роботи тригера.

CREATE OR REPLACE TRIGGER furniture_delete_cascade
    BEFORE DELETE
    ON furniture
    FOR EACH ROW
BEGIN
    DELETE
    FROM sale
    WHERE sale.furniture_id = :old.id;
END;
/

DELETE
FROM furniture
WHERE id = 2;

-- З консолі бачимо, що було виконано 2 дії (тобто не лише видалення)
-- [2022-12-23 10:11:23] completed in 701 ms
-- [2022-12-23 10:11:25] 1 row affected in 603 ms

SELECT id
FROM furniture
WHERE id = 2;
SELECT id
FROM sale
WHERE furniture_id = 2;

-- Обидва запити нічого не повертають

-- 2. Створити тригер для реалізації предметно-орієнтованого контролю спроби
-- додавання значення FK-колонки, що не існує у PK-колонці. Навести тест-кейс перевірки
-- роботи тригера.

CREATE OR REPLACE TRIGGER sale_insert_furniture_id_control
    BEFORE INSERT
    ON sale
    FOR EACH ROW
DECLARE
    furniture_id furniture.id%TYPE;
BEGIN
    SELECT id
    INTO furniture_id
    FROM furniture
    WHERE id = :new.furniture_id;
EXCEPTION
    WHEN no_data_found THEN
        RAISE_APPLICATION_ERROR(-20551, 'Furniture with id=' || :new.furniture_id || ' NOT EXISTS!');
END;
/

INSERT
INTO sale (id, order_id, furniture_id, amount)
VALUES (sale_id_seq.nextval, 1, 999, 10);

-- [2022-12-23 10:26:49] [72000][20551]
-- [2022-12-23 10:26:49] 	ORA-20551: Furniture with id=999 NOT EXISTS!
-- [2022-12-23 10:26:49] 	ORA-06512: at "POSHTARENKO.SALE_INSERT_FURNITURE_ID_CONTROL", line 8
-- [2022-12-23 10:26:49] 	ORA-04088: error during execution of trigger 'POSHTARENKO.SALE_INSERT_FURNITURE_ID_CONTROL'
-- [2022-12-23 10:26:49] Position: 64