-- Помилки :
-- L016	1 / 82	
-- Line is too long.
-- L036	3 / 1	
-- Select targets should be on a new line unless there is only one select target.
-- L011	5 / 11	
-- Implicit/explicit aliasing of table.
-- L031	5 / 11	
-- Avoid aliases in from clauses and join conditions.
-- L003	6 / 10	
-- Expected 0 indentations, found more than 2 [compared to line 05]
-- L011	6 / 31	
-- Implicit/explicit aliasing of table.
-- L031	6 / 31	
-- Avoid aliases in from clauses and join conditions.
-- L016	40 / 85	
-- Line is too long.
-- L016	41 / 91	
-- Line is too long.
-- L036	45 / 1	
-- Select targets should be on a new line unless there is only one select target.
-- L057	45 / 18	
-- Do not use special characters in identifiers.
-- L057	46 / 18	
-- Do not use special characters in identifiers.
-- L011	47 / 11	
-- Implicit/explicit aliasing of table.
-- L031	47 / 11	
-- Avoid aliases in from clauses and join conditions.
-- L003	48 / 10	
-- Expected 0 indentations, found more than 2 [compared to line 47]
-- L011	48 / 31	
-- Implicit/explicit aliasing of table.
-- L031	48 / 31	
-- Avoid aliases in from clauses and join conditions.
-- L016	58 / 89	
-- Line is too long.
-- L016	60 / 99	
-- Line is too long.
-- L016	61 / 108	
-- Line is too long.
-- L016	62 / 114	
-- Line is too long.
-- L044	64 / 1	
-- Query produces an unknown number of result columns.
-- L027	64 / 8	
-- Unqualified reference '*' found in select with more than one referenced table/view.
-- L016	68 / 109	
-- Line is too long.
-- L016	69 / 105	
-- Line is too long.
-- L016	70 / 105	
-- Line is too long.
-- L016	71 / 102	
-- Line is too long.
-- L016	72 / 103	
-- Line is too long.
-- L016	74 / 85	
-- Line is too long.
-- L016	75 / 102	
-- Line is too long.
-- L036	78 / 1	
-- Select targets should be on a new line unless there is only one select target.
-- L057	78 / 18	
-- Do not use special characters in identifiers.
-- L057	79 / 18	
-- Do not use special characters in identifiers.
-- L011	80 / 11	
-- Implicit/explicit aliasing of table.
-- L031	80 / 11	
-- Avoid aliases in from clauses and join conditions.
-- L003	81 / 10	
-- Expected 0 indentations, found more than 2 [compared to line 80]
-- L011	81 / 30	
-- Implicit/explicit aliasing of table.
-- L031	81 / 30	
-- Avoid aliases in from clauses and join conditions.

-- 3.1 Для будь-яких двох таблиць створити команду отримання декартового добутку.

SELECT f.name,
       t.name
FROM type t
         CROSS JOIN furniture f;

-- NAME|NAME
-- Bed N1|Bed
-- Bed N1|Shelf
-- Bed N1|Sofa
-- Bed N1|Table
-- Bed N1|chair
-- Table N1|Bed
-- Table N1|Shelf
-- Table N1|Sofa
-- Table N1|Table
-- Table N1|chair
-- Bed N2|Bed
-- Bed N2|Shelf
-- Bed N2|Sofa
-- Bed N2|Table
-- Bed N2|chair
-- Bed N3|Bed
-- Bed N3|Shelf
-- Bed N3|Sofa
-- Bed N3|Table
-- Bed N3|chair
-- Shelf N1|Bed
-- Shelf N1|Shelf
-- Shelf N1|Sofa
-- Shelf N1|Table
-- Shelf N1|chair
-- Bed N4|Bed
-- Bed N4|Shelf
-- Bed N4|Sofa
-- Bed N4|Table
-- Bed N4|chair

-- 3.2 Для двох таблиць, пов'язаних через PK-колонку та FK-колонку, створити команду
-- отримання двох колонок першої та другої таблиць з використанням екві-з’єднання таблиць.
-- Використовувати префікси.


SELECT f.name AS "Furniture name",
       t.name AS "Type name"
FROM type t
         INNER JOIN furniture f ON t.code = f.type_code;

-- Furniture name|Type name
-- Bed N1|Bed
-- Table N1|Table
-- Bed N2|Bed
-- Bed N3|Bed
-- Shelf N1|chair
-- Bed N4|Bed

-- 3.3 Повторити рішення попереднього завдання, застосувавши автоматичне визначення умов
-- екві-з’єднання.
-- Довелося використати інші таблиці, ніж в завданні 3.2, бо чомусь не виводились результати (лише
-- назви колонок), хоча відповідні primary key і foreign key були присутні. Можливо через назви цих колонок
-- PK (таблиці type) i FK (таблиці furniture) - назви були "code" і "type_code" відповідно, а не "id" як зазвичай

SELECT *
FROM "ORDER" NATURAL JOIN client;


-- ID|CLIENT_ID|CREATION_DATE|DEADLINE_DATE|SUMMARY_PRICE|IS_PAID|IS_DONE|NAME|ADDRESS|PHONE_NUMBER|BIRTHDAY
-- 1|1|2022-10-01|2022-11-01|35000.00|Y|N|SerHii LyakhovetSky|Lutsk, Some str. 5|380656259428|1999-12-27
-- 2|2|2022-09-15|2022-09-22|17500.00|Y|Y|Danylo Kucherenko|Kharkiv, Some str. 13|38065688311|1984-03-19
-- 3|1|2022-10-14|2022-11-01|3000.00|N|N|Andriy Melnyk|Kriviy Rih, some str. 1|38049846544|1991-11-11
-- 4|4|2022-10-14|2022-11-01|3000.00|N|N|Vasyl Vyshyvaniy|Lemberg, some str. 1|380494354654|1999-03-01

-- 3.4 Повторити рішення завдання 3.2, замінивши еквіз'єднання на зовнішнє з'єднання
-- (лівостороннє або правостороннє), яке дозволить побачити рядки таблиці з PK-колонкою, не пов'язані
-- з FK-колонкою.

SELECT t.name AS "Type name",
       f.name AS "Furniture name"
FROM type t
         LEFT JOIN furniture f ON t.code = f.type_code;

-- Type name|Furniture name
-- Bed|Bed N1
-- Table|Table N1
-- Bed|Bed N2
-- Bed|Bed N3
-- chair|Shelf N1
-- Bed|Bed N4
-- Shelf|<null>
-- Sofa|<null>
