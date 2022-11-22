-- 1. Створіть запит, який отримає рядки таблиці з урахуванням присутності в раніше
-- вказаній колонці поєднання будь-яких двох підряд розташованих цифр, або трьох підряд
-- розташованих букв.

SELECT id,
       name
FROM furniture
WHERE REGEXP_LIKE(name, '(([[:digit:]]){2})|(([[:alpha:]]){3})');

-- +--+----------+
-- |ID|NAME      |
-- +--+----------+
-- |1 |Bed NNN1  |
-- |2 |Table N33 |
-- |3 |Table N2  |
-- |4 |Bed N3    |
-- |5 |Bed N4    |
-- |6 |Shelf N453|
-- +--+----------+

-- 2. Одна з колонок таблиць повинна містити строкове значення з двома однаковими
-- буквами, що повторюються підряд. Створіть запит, який отримає рядки таблиці з таким значенням
-- колонки.
SELECT id,
       name
FROM client
WHERE REGEXP_LIKE(name, '([[:alpha:]])\1');

-- +--+-------------------+
-- |ID|NAME               |
-- +--+-------------------+
-- |1 |Serhii Lyakhovetsky|
-- |4 |Hanna Hanna        |
-- +--+-------------------+

-- 3. Одна з колонок таблиць повинна містити строкове значення з двома однаковими
-- словами, що повторюються підряд. Створіть запит, який отримає рядки таблиці з таким значенням
-- колонки.

SELECT id,
       name
FROM client
WHERE REGEXP_LIKE(name, '(([[:alpha:]])+) \1');

-- +--+-----------+
-- |ID|NAME       |
-- +--+-----------+
-- |4 |Hanna Hanna|
-- +--+-----------+

-- 4. Одна з колонок таблиць повинна містити строкове значення з номером мобільного
-- телефону у форматі +XX(XXX)XXX-XX-XX, де X – цифра. Створіть запит, який отримає рядки
-- таблиці з таким значенням колонки.

SELECT id,
       name,
       phone_number
FROM client
WHERE REGEXP_LIKE(phone_number, '\+\d{2}\(\d{3}\)\d{3}-\d{2}-\d{2}');

-- +--+-------------------+-----------------+
-- |ID|NAME               |PHONE_NUMBER     |
-- +--+-------------------+-----------------+
-- |1 |Serhii Lyakhovetsky|+58(401)590-01-22|
-- |2 |Danylo Kucherenko  |+12(313)231-13-43|
-- |4 |Hanna Hanna        |+36(365)137-91-85|
-- |23|Sofia Hromova      |+91(823)348-18-96|
-- |65|Tom White          |+15(823)324-18-12|
-- +--+-------------------+-----------------+


-- 5. Одна з колонок таблиць має містити строкове значення з електронною поштовою
-- адресою у форматі EEE@EEE.EEE.UA, де E – будь-яка латинська буква. Створіть запит, який
-- отримає рядки таблиці з таким значенням колонки.

SELECT id, name, email
FROM client
WHERE REGEXP_LIKE(email, '^([[:alpha:]]+\@[[:alpha:]]{3}\.[[:alpha:]]{3}\.ua)$');

-- +--+-------------------+------------------------+
-- |ID|NAME               |EMAIL                   |
-- +--+-------------------+------------------------+
-- |1 |Serhii Lyakhovetsky|serhiilutsk@ukr.com.ua  |
-- |2 |Danylo Kucherenko  |dankucherenko@ukr.com.ua|
-- |4 |Hanna Hanna        |hanna@ukr.com.ua        |
-- |23|Sofia Hromova      |shromova@ukr.com.ua     |
-- |65|Tom White          |tomwhite@ukr.com.ua     |
-- +--+-------------------+------------------------+