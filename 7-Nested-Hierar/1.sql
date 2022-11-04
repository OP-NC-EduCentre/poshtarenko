-- 1. Виконання простих однорядкових підзапитів із екві-з'єднанням або тета-з'єднанням.
-- Задача : Вибрати всі меблі з ціною більшою, ніж ціна меблів з id = 1

SELECT id,
       name,
       price
FROM furniture
WHERE price > (SELECT price
               FROM furniture
               WHERE id = 1);

-- +--+--------+--------+
-- |ID|NAME    |PRICE   |
-- +--+--------+--------+
-- |3 |Table N2|13000.00|
-- |4 |Bed N3  |9500.00 |
-- |5 |Bed N4  |11300.00|
-- +--+--------+--------+

-- 2. Використання агрегатних функцій у підзапитах.
-- Задача : Вибрати всі меблі з ціною меншою за середню

SELECT id,
       name,
       price
FROM furniture
WHERE price < (SELECT AVG(price)
               FROM furniture);

-- +--+--------+-------+
-- |ID|NAME    |PRICE  |
-- +--+--------+-------+
-- |1 |Bed N1  |7000.00|
-- |2 |Table N1|5500.00|
-- |6 |Shelf N1|3000.00|
-- +--+--------+-------+


-- 3. Пропозиція HAVING із підзапитами.
-- Задача : Отримати список компаній - виробників меблів, у яких максимальна ціна меблів
-- менша за середню ціну всіх меблів

SELECT producer,
       MAX(price)
FROM furniture
GROUP BY producer
HAVING MAX(price) < (SELECT AVG(price)
                     FROM furniture);

-- +--------------+----------+
-- |PRODUCER      |MAX(PRICE)|
-- +--------------+----------+
-- |Kyiv furniture|5500      |
-- +--------------+----------+


-- 4
-- Задача : Вибрати всі меблі, у яких ціна менша за 10000.00, але час виробництва (у днях) яких
-- вищий за час виробництва будь-яких меблів з ціною вищою за 10000.00

SELECT id,
       name,
       price,
       production_time
FROM furniture
WHERE price < 10000.00
  AND production_time > ANY (SELECT production_time
                             FROM furniture
                             WHERE price > 10000.00);

-- +--+------+-------+---------------+
-- |ID|NAME  |PRICE  |PRODUCTION_TIME|
-- +--+------+-------+---------------+
-- |1 |Bed N1|7000.00|70             |
-- |4 |Bed N3|9500.00|65             |
-- +--+------+-------+---------------+

-- 5. Використання оператора WITH для структуризації запиту
-- Задача : Вибрати меблі, ціна яких є вищою за середню ціну серед меблів їхнього типу.

WITH avg_type_price
         AS (SELECT t.code     AS code,
                    t.name     AS name,
                    AVG(price) AS avg_price
             FROM type t
                      JOIN furniture f ON t.code = f.type_code
             GROUP BY t.code, t.name)
SELECT furniture.name      AS name,
       avg_type_price.name AS type,
       price
FROM furniture
         JOIN avg_type_price ON furniture.type_code = avg_type_price.code
WHERE furniture.price > avg_type_price.avg_price;

-- +--------+-----+--------+
-- |NAME    |TYPE |PRICE   |
-- +--------+-----+--------+
-- |Bed N3  |Bed  |9500.00 |
-- |Table N2|Table|13000.00|
-- |Bed N4  |Bed  |11300.00|
-- +--------+-----+--------+

-- 6. Використання кореляційних підзапитів
-- Задача : Отримати список меблів, які жодного разу не продавалися

SELECT id,
       name,
       price
FROM furniture
WHERE NOT EXISTS(
        SELECT f.name
        FROM sale s
                 JOIN furniture f ON f.id = s.furniture_id
        WHERE furniture.name = f.name
    );

-- +--+--------+--------+
-- |ID|NAME    |PRICE   |
-- +--+--------+--------+
-- |3 |Table N2|13000.00|
-- |4 |Bed N3  |9500.00 |
-- |5 |Bed N4  |11300.00|
-- +--+--------+--------+