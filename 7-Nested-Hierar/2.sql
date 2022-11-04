-- 1. Багатотабличне внесення даних
-- Задача : Використовуючи один INSERT-запит, зареєструвати нового клієнта, а також
-- нове замовлення, яке здійснив цей новий клієнт. Сумарна вартість нового
-- замовлення дорівнює вартості двох одиниць меблів з назвою "Table N1"

ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

INSERT ALL
INTO client (id, name, address, phone_number, birthday)
VALUES (client_id_seq.nextval, 'Valeriy Hromov', 'Odesa, Some str. 1', '+38584944849', '11/04/2001')
INTO "ORDER" (id, client_id, creation_date, deadline_date, summary_price, is_paid, is_done)
VALUES (order_id_seq.nextval, client_id_seq.currval, CURRENT_DATE, '04/12/2022', order_price, 'N', 'N')
SELECT 2 * price AS order_price
FROM furniture
WHERE name = 'Table N1';

-- OK : 2 rows affected in 23 ms

-- 2. Використання багатостовпцевих підзапитів при зміні даних
-- Задача : Змінити для меблів з назвою "Shelf N1" кількість і дату останнього постачання
-- на такі ж значення відповідних стовпців, як у меблів з назвою "Bed N1"

UPDATE furniture
SET (amount, last_supply_date) = (SELECT amount, last_supply_date
                                  FROM furniture
                                  WHERE name = 'Bed N1')
WHERE name = 'Shelf N1';

-- OK : 1 row affected in 15 ms

-- 3. Видалення рядків із використанням кореляційних підзапитів.
-- Задача : Видалити з бази даних всіх клієнтів, які не зробили жодного замовлення

DELETE
FROM (SELECT *
      FROM client c
      WHERE NOT EXISTS(
              SELECT *
              FROM "ORDER" o
                       JOIN poshtarenko.client c2 ON c2.id = o.client_id
              WHERE c.id = o.client_id
          ));

-- OK : 1 row affected in 19 ms

-- 4. Поєднаний INSERT/UPDATE запит – оператор MERGE
-- Задача : Створити копію таблиці меблів, зменшити ціни в таблиці-копії у два рази
-- і видалити всі меблі з ціною більшою за 9000. Потім відновити у таблиці-копії
-- вихідні дані.

CREATE TABLE furniture_copy AS
SELECT *
FROM furniture;

DELETE
FROM furniture_copy
WHERE price > 9000;

UPDATE furniture_copy
SET price = price / 2;

SELECT * FROM furniture_copy;

-- Таблиця-копія зі зміненими даними :
-- +--+--------+---------+--------------+------+---------------+-------+----------------+
-- |ID|NAME    |TYPE_CODE|PRODUCER      |AMOUNT|PRODUCTION_TIME|PRICE  |LAST_SUPPLY_DATE|
-- +--+--------+---------+--------------+------+---------------+-------+----------------+
-- |1 |Bed N1  |1        |Lviv factory  |9     |70             |3500.00|null            |
-- |2 |Table N1|2        |Kyiv furniture|35    |15             |2750.00|null            |
-- |6 |Shelf N1|5        |Lviv factory  |9     |30             |1500.00|null            |
-- +--+--------+---------+--------------+------+---------------+-------+----------------+

MERGE
INTO furniture_copy f_copy
USING furniture f
ON (f.id = f_copy.id)
WHEN MATCHED THEN
    UPDATE
    SET f_copy.price = f.price
WHEN NOT MATCHED THEN
    INSERT (id, name, type_code, producer, amount,
            production_time, price, last_supply_date)
    VALUES (f.id, f.name, f.type_code, f.producer, f.amount,
            f.production_time, f.price, f.last_supply_date);

-- OK : 6 rows affected in 25 ms

SELECT * FROM furniture_copy;

-- Таблиця-копія з відновленими даними :
-- +--+--------+---------+-----------------+------+---------------+--------+----------------+
-- |ID|NAME    |TYPE_CODE|PRODUCER         |AMOUNT|PRODUCTION_TIME|PRICE   |LAST_SUPPLY_DATE|
-- +--+--------+---------+-----------------+------+---------------+--------+----------------+
-- |1 |Bed N1  |1        |Lviv factory     |9     |70             |7000.00 |null            |
-- |2 |Table N1|2        |Kyiv furniture   |35    |15             |5500.00 |null            |
-- |6 |Shelf N1|5        |Lviv factory     |9     |30             |3000.00 |null            |
-- |3 |Table N2|2        |Based Corporation|30    |60             |13000.00|null            |
-- |4 |Bed N3  |1        |Based Corporation|30    |65             |9500.00 |2022-01-30      |
-- |5 |Bed N4  |1        |Lviv factory     |100   |55             |11300.00|null            |
-- +--+--------+---------+-----------------+------+---------------+--------+----------------+