-- 4.1 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
-- перерахувати) за окремими рядками з урахуванням умови: цілочисельне значення однієї з колонок
-- має бути більшим за якесь константне значення.

SELECT id,
       name,
       type_code,
       producer,
       amount,
       production_time,
       price,
       last_supply_date
FROM furniture
WHERE price >= 7000;

-- Result :
-- ID|NAME|TYPE_CODE|PRODUCER|AMOUNT|PRODUCTION_TIME|PRICE|LAST_SUPPLY_DATE
-- 1|Bed N1|1|Lviv factory|10|30|7000.00|<null>
-- 3|Bed N2|1|RRR Company|30|45|13000.00|<null>
-- 4|Bed N3|1|Based Corporation|30|60|9000.00|2022-01-30

-- 4.2 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
-- перерахувати) за окремими рядками з урахуванням умови: символьне значення однієї з колонок
-- має співпадати з якимось константним значенням.
SELECT id,
       name,
       type_code,
       producer,
       amount,
       production_time,
       price,
       last_supply_date
FROM furniture
WHERE producer = 'Lviv factory';

-- Result :
-- ID|NAME|TYPE_CODE|PRODUCER|AMOUNT|PRODUCTION_TIME|PRICE|LAST_SUPPLY_DATE
-- 1|Bed N1|1|Lviv factory|10|30|7000.00|<null>

-- 4.3 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
-- перерахувати) за окремими рядками з урахуванням умови: символьне значення однієї з колонок
-- повинно містити в першому та третьому знакомісті якісь надані вами символи.
SELECT id,
       name,
       address,
       phone_number,
       birthday
FROM client
WHERE name LIKE 'S_r%';

-- Result :
-- ID|NAME|ADDRESS|PHONE_NUMBER|BIRTHDAY
-- 1|Serhii Lyakhovetsky|Lutsk, Some str. 5|380656259428|1999-12-27

-- 4.4 У завданні 1.2 було додано колонку типу date. Створити команду отримання значень
-- всіх колонок (явно перерахувати) за окремими рядками з урахуванням умови: значення доданої
-- колонки містить невизначене значення.

SELECT id,
       name,
       type_code,
       producer,
       amount,
       production_time,
       price,
       last_supply_date
FROM furniture
WHERE last_supply_date IS NULL;

-- Result :
-- ID|NAME|TYPE_CODE|PRODUCER|AMOUNT|PRODUCTION_TIME|PRICE|LAST_SUPPLY_DATE
-- 1|Bed N1|1|Lviv factory|10|30|7000.00|<null>
-- 2|Table N1|2|Kyiv furniture|35|15|2500.00|<null>
-- 3|Bed N2|1|RRR Company|30|45|13000.00|<null>

-- 4.5 Створити команду отримання значень всіх колонок (явно перерахувати) за окремими
-- рядками з урахуванням умови, що поєднує умови з рішень завдань 4.1 та 4.2

SELECT id,
       name,
       type_code,
       producer,
       amount,
       production_time,
       price,
       last_supply_date
FROM furniture
WHERE price >= 7000
  AND producer = 'Lviv factory';

-- Result :
-- ID|NAME|TYPE_CODE|PRODUCER|AMOUNT|PRODUCTION_TIME|PRICE|LAST_SUPPLY_DATE
-- 1|Bed N1|1|Lviv factory|10|30|7000.00|<null>

-- 4.6 Створити команду отримання значень всіх колонок (явно перерахувати) за окремими
-- рядками з урахуванням умови, що інвертує результат рішення 4.5

SELECT id,
       name,
       type_code,
       producer,
       amount,
       production_time,
       price,
       last_supply_date
FROM furniture
WHERE NOT (price >= 7000
    AND producer = 'Lviv factory');

-- Result :
-- ID|NAME|TYPE_CODE|PRODUCER|AMOUNT|PRODUCTION_TIME|PRICE|LAST_SUPPLY_DATE
-- 2|Table N1|2|Kyiv furniture|35|15|2500.00|<null>
-- 3|Bed N2|1|RRR Company|30|45|13000.00|<null>
-- 4|Bed N3|1|Based Corporation|30|60|9000.00|2022-01-30