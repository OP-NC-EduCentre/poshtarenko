-- 1. Одна з колонок таблиць повинна містити строкове значення з трьома різними буквами у
-- першій позиції. Створіть запит, який отримає три рядки таблиці з урахуванням трьох букв,
-- використовуючи оператор LIKE.

SELECT id,
       name,
       price
FROM furniture
WHERE name LIKE 'Tab%';

-- +--+--------+--------+
-- |ID|NAME    |PRICE   |
-- +--+--------+--------+
-- |2 |Table N1|5500.00 |
-- |3 |Table N2|13000.00|
-- +--+--------+--------+

-- 2. Повторіть завдання 1, використовуючи регулярні вирази з альтернативними варіантами.

SELECT id,
       name,
       price
FROM furniture
WHERE regexp_like(name, '^Tab');

-- +--+--------+--------+
-- |ID|NAME    |PRICE   |
-- +--+--------+--------+
-- |2 |Table N1|5500.00 |
-- |3 |Table N2|13000.00|
-- +--+--------+--------+

-- 3. Одна з колонок таблиць повинна містити строкове значення з цифрами від 3 до 8 у
-- будь-якій позиції. Створіть запит, який отримає рядки таблиці з урахуванням присутності у
-- вказаній колонці будь-якої цифри від 3 до 8.

SELECT id,
       name,
       price
FROM furniture
WHERE regexp_like(name, '[3-8]');

-- +--+----------+--------+
-- |ID|NAME      |PRICE   |
-- +--+----------+--------+
-- |2 |Table N33 |5500.00 |
-- |4 |Bed N3    |9500.00 |
-- |6 |Shelf N453|3000.00 |
-- |5 |Bed N4    |11300.00|
-- +--+----------+--------+

-- 4. Створіть запит, який отримає рядки таблиці з урахуванням відсутності в зазначеній
-- колонці будь-якої цифри від 3 до 8.

SELECT id,
       name,
       price
FROM furniture
WHERE regexp_like(name, '^[^3-8]*$');

-- +--+--------+--------+
-- |ID|NAME    |PRICE   |
-- +--+--------+--------+
-- |1 |Bed NNN1|7000.00 |
-- |3 |Table N2|13000.00|
-- +--+--------+--------+

-- 5. Створіть запит, який отримає рядки таблиці з урахуванням присутності в раніше вказаній
-- колонці поєднання будь-яких трьох цифр розміщених підряд від 3 до 8.


SELECT id,
       name,
       price
FROM furniture
WHERE regexp_like(name, '[3-8]{3}');

-- +--+----------+-------+
-- |ID|NAME      |PRICE  |
-- +--+----------+-------+
-- |6 |Shelf N453|3000.00|
-- +--+----------+-------+