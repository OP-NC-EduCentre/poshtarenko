-- Помилки :
-- L016	1 / 88	
-- Line is too long.
-- L016	2 / 95	
-- Line is too long.
-- L016	3 / 87	
-- Line is too long.
-- L016	4 / 92	
-- Line is too long.
-- L003	8 / 13	
-- Expected 0 indentations, found 3 [compared to line 07]
-- L036	17 / 1	
-- Select targets should be on a new line unless there is only one select target.
-- L036	28 / 1	
-- Select targets should be on a new line unless there is only one select target.
-- L036	44 / 1	
-- Select targets should be on a new line unless there is only one select target.
-- L003	55 / 13	
-- Expected 0 indentations, found 3 [compared to line 54]
-- L036	58 / 1	
-- Select targets should be on a new line unless there is only one select target.
-- L011	60 / 11	
-- Implicit/explicit aliasing of table.
-- L031	60 / 11	
-- Avoid aliases in from clauses and join conditions.
-- L003	61 / 10	
-- Expected 0 indentations, found more than 2 [compared to line 60]
-- L011	61 / 31	
-- Implicit/explicit aliasing of table.
-- L031	61 / 31	
-- Avoid aliases in from clauses and join conditions.
-- L036	63 / 1	
-- Select targets should be on a new line unless there is only one select target.
-- L016	77 / 89	
-- Line is too long.
-- L016	83 / 109	
-- Line is too long.

-- 1.1 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
-- 4.2 з лабораторної роботи No3: для однієї з таблиць створити команду отримання значень усіх
-- колонок (явно перерахувати) за окремими рядками з урахуванням умови, в якій рядкове
-- значення однієї з колонок має співпадати з якимось константним значенням. Отримати вміст
-- таблиці.

CREATE OR REPLACE VIEW furniture_lviv_factory_list
            (furniture_id,
             name,
             type_code,
             producer,
             amount,
             production_time,
             price,
             las_supply_date)
AS
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

SELECT furniture_id,
       name,
       type_code,
       producer,
       amount,
       production_time,
       price,
       las_supply_date
FROM furniture_lviv_factory_list;

-- +------------+--------+---------+------------+------+---------------+--------+---------------+
-- |FURNITURE_ID|NAME    |TYPE_CODE|PRODUCER    |AMOUNT|PRODUCTION_TIME|PRICE   |LAS_SUPPLY_DATE|
-- +------------+--------+---------+------------+------+---------------+--------+---------------+
-- |1           |Bed N1  |1        |Lviv factory|10    |30             |7000.00 |null           |
-- |6           |Shelf N1|5        |Lviv factory|100   |50             |10000.00|null           |
-- |5           |Bed N4  |1        |Lviv factory|100   |50             |10000.00|null           |
-- +------------+--------+---------+------------+------+---------------+--------+---------------+

-- 1.2 Виконати команду зміни значення колонки створеної віртуальної таблиці на
-- значення, яка входить в умову вибірки рядків із рішення попереднього завдання, при цьому нове
-- значення має відрізнятись від поточного.

UPDATE furniture_lviv_factory_list
SET amount = amount - 1
WHERE name = 'Bed N1';

SELECT furniture_id,
       name,
       type_code,
       producer,
       amount,
       production_time,
       price,
       las_supply_date
FROM furniture_lviv_factory_list;

-- +------------+--------+---------+------------+------+---------------+--------+---------------+
-- |FURNITURE_ID|NAME    |TYPE_CODE|PRODUCER    |AMOUNT|PRODUCTION_TIME|PRICE   |LAS_SUPPLY_DATE|
-- +------------+--------+---------+------------+------+---------------+--------+---------------+
-- |1           |Bed N1  |1        |Lviv factory|9     |30             |7000.00 |null           |
-- |6           |Shelf N1|5        |Lviv factory|100   |50             |10000.00|null           |
-- |5           |Bed N4  |1        |Lviv factory|100   |50             |10000.00|null           |
-- +------------+--------+---------+------------+------+---------------+--------+---------------+

-- 1.3 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
-- 3.2 з лабораторної роботи No4: для двох таблиць, пов'язаних через PK-колонку та FK-колонку,
-- створити команду отримання двох колонок першої та другої таблиць з використанням екві-
-- сполучення таблиць. Отримати вміст таблиці.

CREATE OR REPLACE VIEW furniture_type
            (furniture_name,
             type_name)
AS
SELECT f.name,
       t.name
FROM type t
         INNER JOIN furniture f ON t.code = f.type_code;

SELECT furniture_name, type_name
FROM furniture_type;

-- +--------------+---------+
-- |FURNITURE_NAME|TYPE_NAME|
-- +--------------+---------+
-- |Bed N1        |Bed      |
-- |Table N1      |Table    |
-- |Bed N2        |Bed      |
-- |Bed N3        |Bed      |
-- |Shelf N1      |chair    |
-- |Bed N4        |Bed      |
-- +--------------+---------+

-- 1.4 Виконати команду додавання нового рядка до однієї з таблиць, що входить до запиту
-- з попереднього завдання.
INSERT
INTO furniture_type (furniture_type.furniture_name, furniture_type.type_name)
VALUES ('Bed x1', 'Bed')

-- [2022-10-27 18:53:36] [42000][1776] ORA-01776: cannot modify more than one base table through a join view
