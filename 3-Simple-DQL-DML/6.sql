-- 6.1 Для однієї з таблиць створити команду отримання кількості рядків таблиці.

SELECT COUNT(id) AS "Count of furniture items"
FROM furniture;

-- Result :
-- 4

-- 6.2 Для однієї з таблиць створити команду отримання суми значень однієї з цілих
-- колонок.

SELECT SUM(price * amount) AS "Total price of  all furniture"
FROM furniture;

-- Result :
-- 922500

-- 6.3 Для однієї з таблиць створити команду отримання статистики появи значень однієї з
-- колонок у таблиці, наприклад:
-- - значення 1, кількість появи значення 1
-- - значення 2, кількість появи значення 2

SELECT
    type_code,
    COUNT(type_code) AS items_count
FROM furniture
GROUP BY type_code;

-- Result :
-- TYPE_CODE|ITEMS_COUNT
-- 1|3
-- 2|1

-- 6.4 Модифікувати рішення попереднього завдання так, щоб у відповіді були
-- відфільтровані рядки з урахуванням заданої умови, що включає використану функцію агрегації.

SELECT
    type_code,
    COUNT(type_code) AS items_count
FROM furniture
GROUP BY type_code
HAVING COUNT(type_code) > 1;

-- Result :
-- TYPE_CODE|ITEMS_COUNT
-- 1|3
