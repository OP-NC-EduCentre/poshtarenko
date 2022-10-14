-- 2.1 Для однієї з таблиць створити команду отримання символьних значень колонки з
-- переведенням першого символу у верхній регістр, інших у нижній. При виведенні на екран визначити
-- для вказаної колонки нову назву псевдоніму.
SELECT id,
       INITCAP(name) AS "name",
       address,
       phone_number,
       birthday
FROM client;
-- ID|name|ADDRESS|PHONE_NUMBER|BIRTHDAY
-- 1|Serhii Lyakhovetsky|Lutsk, Some str. 5|380656259428|1999-12-27
-- 2|Danylo Kucherenko|Kharkiv, Some str. 13|38065688311|1984-03-19
-- 3|Andriy Melnyk|Kriviy Rih, some str. 1|38049846544|1991-11-11
-- 4|Vasyl Vyshyvaniy|Lemberg, some str. 1|380494354654|1999-03-01

-- 2.2. Модифікувати рішення попереднього завдання, створивши команду оновлення значення
-- вказаної колонки у таблиці.
UPDATE client SET name = INITCAP(name);

-- 2.3 Для однієї з символьних колонок однієї з таблиць створити команду отримання
-- мінімальної, середньої та максимальної довжин рядків.
SELECT
    MIN(LENGTH(name)) AS "Shortest name",
    AVG(LENGTH(name)) AS "Average name",
    MAX(LENGTH(name)) AS "Longest name"
FROM client;

-- Shortest name|Average name|Longest name
-- 12|15.4|19

-- 2.4 Для колонки типу date однієї з таблиць отримати кількість днів, тижнів та місяців, що
-- пройшли до сьогодні.

SELECT id,
       name,
       birthday,
       ROUND (SYSDATE - birthday) AS "Days from birthday",
       ROUND ((SYSDATE - birthday) / 7) AS "Weeks from birthday",
       ROUND (MONTHS_BETWEEN(SYSDATE, birthday)) AS "Months from birthday"
FROM client;

-- ID|NAME|BIRTHDAY|Days from birthday|Weeks from birthday|Months from birthday
-- 1|Serhii Lyakhovetsky|1999-12-27|8328|1190|274
-- 2|Danylo Kucherenko|1984-03-19|14089|2013|463
-- 5|Sheih Mansur|1979-02-23|15940|2277|524
-- 3|Andriy Melnyk|1991-11-11|11296|1614|371
-- 4|Vasyl Vyshyvaniy|1999-03-01|8629|1233|283

