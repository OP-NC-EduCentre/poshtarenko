-- 1. Виберіть таблицю вашої БД, до якої потрібно додати нову колонку, яка стане FK-
-- колонкою для PK-колонки цієї таблиці та буде використана для зберігання ієрархії.
-- Використовується команда ALTER TABLE таблиця ADD колонка тип_даних. Заповніть дані
-- для створеної колонки, виконавши серію команд UPDATE.

-- Створимо у таблиці "client" колонку "inviter" з FK на PK цієї ж таблиці (тут це колонка id).
-- Можна уявити, ніби у нас з'явилася якась реферальна система : клієнти можуть запрошувати
-- інших і, наприклад, отримувати за це знижки. Колонка "inviter" буде посилатися на іншого
-- клієнта, який запросив цього клієнта.

ALTER TABLE client
    ADD inviter NUMBER(9);

ALTER TABLE client
    ADD CONSTRAINT client_inviter_fk
        FOREIGN KEY (inviter) REFERENCES client (id);

UPDATE client
SET inviter = 1
WHERE id = 2;

UPDATE client
SET inviter = 2
WHERE id = 4
   OR id = 23;

SELECT *
FROM client;

-- В результаті маємо :
-- +-------------------+---------------------+------------+----------+-------+
-- |NAME               |ADDRESS              |PHONE_NUMBER|BIRTHDAY  |INVITER|
-- +-------------------+---------------------+------------+----------+-------+
-- |Serhii Lyakhovetsky|Lutsk, Some str. 5   |380656259428|1999-12-27|null   |
-- |Danylo Kucherenko  |Kharkiv, Some str. 13|38065688311 |1984-03-19|1      |
-- |Vasyl Vyshyvaniy   |Lemberg, some str. 1 |380494354654|1999-03-01|2      |
-- |Valeriy Hromov     |Odesa, Some str. 1   |+38584984849|2001-04-11|2      |
-- +-------------------+---------------------+------------+----------+-------+

-- 2. Використовуючи створену колонку, отримайте дані з таблиці через ієрархічний зв'язок
-- типу «зверху-вниз».

SELECT id, name, inviter, level
FROM client
START WITH inviter IS NULL
CONNECT BY PRIOR id = inviter
ORDER BY level;

-- +--+-------------------+-------+-----+
-- |ID|NAME               |INVITER|LEVEL|
-- +--+-------------------+-------+-----+
-- |1 |Serhii Lyakhovetsky|null   |1    |
-- |2 |Danylo Kucherenko  |1      |2    |
-- |4 |Vasyl Vyshyvaniy   |2      |3    |
-- |23|Valeriy Hromov     |2      |3    |
-- +--+-------------------+-------+-----+

-- 3. Згенеруйте унікальну послідовність чисел, використовуючи рекурсивний запит, в
-- діапазоні від 1 до 100. На основі отриманого результату створіть запит, що виводить на екран
-- список ще не внесених значень однієї з PK-колонок однієї з таблиць БД.

-- Створимо послідовність чисел від 1 до 100. За допомогою цієї послідовності перевіримо
-- які значення PK ще не внесені для таблиці "furniture".

SELECT n
FROM (WITH numbers(n) AS
               (SELECT 1 AS n
                FROM dual
                UNION ALL
                SELECT n + 1
                FROM numbers
                WHERE n < 100)
      SELECT n
      FROM numbers)
WHERE NOT EXISTS(SELECT id
                 FROM furniture
                 WHERE id = n);

-- +---+
-- |N  |
-- +---+
-- |7  |
-- |8  |
-- |9  |
-- |10 |
-- |11 |
-- |12 |
-- |13 |
-- |14 |
-- |15 |
-- |16 |
-- |17 |
-- |18 |
-- |19 |
-- |20 |
-- |21 |
-- |22 |
-- |23 |
-- |24 |
-- |25 |
-- |26 |
-- |27 |
-- |28 |
-- |29 |
-- |30 |
-- |31 |
-- |32 |
-- |33 |
-- |34 |
-- |35 |
-- |36 |
-- |37 |
-- |38 |
-- |39 |
-- |40 |
-- |41 |
-- |42 |
-- |43 |
-- |44 |
-- |45 |
-- |46 |
-- |47 |
-- |48 |
-- |49 |
-- |50 |
-- |51 |
-- |52 |
-- |53 |
-- |54 |
-- |55 |
-- |56 |
-- |57 |
-- |58 |
-- |59 |
-- |60 |
-- |61 |
-- |62 |
-- |63 |
-- |64 |
-- |65 |
-- |66 |
-- |67 |
-- |68 |
-- |69 |
-- |70 |
-- |71 |
-- |72 |
-- |73 |
-- |74 |
-- |75 |
-- |76 |
-- |77 |
-- |78 |
-- |79 |
-- |80 |
-- |81 |
-- |82 |
-- |83 |
-- |84 |
-- |85 |
-- |86 |
-- |87 |
-- |88 |
-- |89 |
-- |90 |
-- |91 |
-- |92 |
-- |93 |
-- |94 |
-- |95 |
-- |96 |
-- |97 |
-- |98 |
-- |99 |
-- |100|
-- +---+