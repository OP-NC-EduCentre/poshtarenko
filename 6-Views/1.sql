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