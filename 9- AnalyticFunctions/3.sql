-- 1. Класифікуйте значення однієї з колонок на 3 категорії залежно від загальної суми
-- значень у будь-якій числовій колонці. Використати аналітичну функцію NTILE.

SELECT name,
       price * amount                          total_price,
       NTILE(3) OVER (ORDER BY price * amount) category
FROM furniture;

-- +----------+-----------+--------+
-- |NAME      |TOTAL_PRICE|CATEGORY|
-- +----------+-----------+--------+
-- |Shelf N453|27000      |1       |
-- |Bed NNN1  |63000      |1       |
-- |Table N33 |192500     |2       |
-- |Bed N3    |285000     |2       |
-- |Table N2  |390000     |3       |
-- |Bed N4    |1130000    |3       |
-- +----------+-----------+--------+


-- 2. Складіть запит, який поверне списки лідерів (список за убуванням відповідного
-- значення) у підгрупах, отриманих у першому завданні етапу 1.

WITH a1 AS (SELECT name,
                   price * amount                          total_price,
                   NTILE(3) OVER (ORDER BY price * amount) category
            FROM furniture),
     a2 AS (SELECT name,
                   total_price,
                   category,
                   RANK() OVER (PARTITION BY category ORDER BY total_price) position
            FROM a1)
SELECT name,
       total_price,
       category,
       position
FROM a2
WHERE position = 1;

-- +----------+-----------+--------+--------+
-- |NAME      |TOTAL_PRICE|CATEGORY|POSITION|
-- +----------+-----------+--------+--------+
-- |Shelf N453|27000      |1       |1       |
-- |Table N33 |192500     |2       |1       |
-- |Table N2  |390000     |3       |1       |
-- +----------+-----------+--------+--------+

-- 3. Модифікуйте рішення попереднього завдання, повернувши по 2 лідери у кожній
-- підгрупі.

WITH a1 AS (SELECT name,
                   price * amount                          total_price,
                   NTILE(3) OVER (ORDER BY price * amount) category
            FROM furniture),
     a2 AS (SELECT name,
                   total_price,
                   category,
                   ROW_NUMBER() OVER (PARTITION BY category ORDER BY category) position
            FROM a1)
SELECT name,
       total_price,
       category,
       position
FROM a2
WHERE position <= 2;

-- +----------+-----------+--------+--------+
-- |NAME      |TOTAL_PRICE|CATEGORY|POSITION|
-- +----------+-----------+--------+--------+
-- |Shelf N453|27000      |1       |1       |
-- |Bed NNN1  |63000      |1       |2       |
-- |Table N33 |192500     |2       |1       |
-- |Bed N3    |285000     |2       |2       |
-- |Table N2  |390000     |3       |1       |
-- |Bed N4    |1130000    |3       |2       |
-- +----------+-----------+--------+--------+

-- 4. Складіть запит, який повертає рейтинг будь-якого з перерахованих значень
-- відповідно до вашої предметноїобласті: товарів/послуг/співробітників/клієнтів тощо.

SELECT name,
       price,
       RANK() OVER (ORDER BY price DESC) rating
FROM furniture;

-- +----------+--------+------+
-- |NAME      |PRICE   |RATING|
-- +----------+--------+------+
-- |Table N2  |13000.00|1     |
-- |Bed N4    |11300.00|2     |
-- |Bed N3    |9500.00 |3     |
-- |Bed NNN1  |7000.00 |4     |
-- |Table N33 |5500.00 |5     |
-- |Shelf N453|3000.00 |6     |
-- +----------+--------+------+


-- 5. Одна з колонок таблиці повинна містити значення, що повторюються, для
-- виділення підгруп, інша колонка повинна мати числові значення. Створіть запит, який
-- отримає перше значення у кожній підгрупі. Використати аналітичну функцію
-- FIRST_VALUE.

WITH a1 AS (SELECT name,
                   producer,
                   price * amount                    total_price,
                   FIRST_VALUE(price * amount) OVER
                       (PARTITION BY producer
                       ORDER BY price * amount DESC) top_producer_price
            FROM furniture)
SELECT name,
       producer,
       total_price
FROM a1
WHERE total_price = top_producer_price;

-- +---------+-----------------+-----------+
-- |NAME     |PRODUCER         |TOTAL_PRICE|
-- +---------+-----------------+-----------+
-- |Table N2 |Based Corporation|390000     |
-- |Table N33|Kyiv furniture   |192500     |
-- |Bed N4   |Lviv factory     |1130000    |
-- +---------+-----------------+-----------+