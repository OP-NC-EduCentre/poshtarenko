-- Помилки :
-- L016	1 / 82	
-- Line is too long.
-- L036	3 / 1	
-- Select targets should be on a new line unless there is only one select target.
-- L016	21 / 87	
-- Line is too long.
-- L034	23 / 1	
-- Select wildcards then simple targets before calculations and aggregates.
-- L036	23 / 1	
-- Select targets should be on a new line unless there is only one select target.
-- L016	37 / 83	
-- Line is too long.
-- L016	48 / 93	
-- Line is too long.
-- L016	49 / 88	
-- Line is too long.
-- L016	50 / 89	
-- Line is too long.
-- L016	60 / 82	
-- Line is too long.
-- L034	63 / 1	
-- Select wildcards then simple targets before calculations and aggregates.
-- L036	63 / 1	
-- Select targets should be on a new line unless there is only one select target.
-- L016	78 / 87	
-- Line is too long.
-- L016	79 / 92	
-- Line is too long.
-- L036	82 / 1	
-- Select targets should be on a new line unless there is only one select target.


-- 2.1 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
-- перерахувати) у всіх рядках.
SELECT id,
       name,
       type_code,
       producer,
       amount,
       production_time,
       price,
       last_supply_date
FROM furniture;

-- Result :
-- ID|NAME|TYPE_CODE|PRODUCER|AMOUNT|PRODUCTION_TIME|PRICE|LAST_SUPPLY_DATE
-- 1|Bed N1|1|Lviv factory|10|30|7000.00|<null>
-- 2|Table N1|2|Kyiv furniture|35|15|2500.00|<null>
-- 3|Bed N2|1|RRR Company|30|45|13000.00|<null>
-- 4|Bed N3|1|Based Corporation|30|60|9000.00|2022-01-30

-- 2.2 Для однієї з таблиць створити команду отримання цілого числа колонки з
-- використанням будь-якої арифметичної операції. При виведенні на екран визначити для
-- зазначеної колонки нову назву псевдоніма.
SELECT id,
       name,
       type_code,
       amount / 100 AS amount_in_hudreds,
       price
FROM furniture;

-- Result :
-- ID|NAME|TYPE_CODE|AMOUNT_IN_HUDREDS|PRICE
-- 1|Bed N1|1|0.1|7000.00
-- 2|Table N1|2|0.35|2500.00
-- 3|Bed N2|1|0.3|13000.00
-- 4|Bed N3|1|0.3|9000.00

-- 2.3 Для однієї з таблиць, що містить колонку зовнішнього ключа створити команду
-- отримання значення колонки без дублювання значень.

SELECT DISTINCT type_code
FROM furniture;

-- Result :
-- TYPE_CODE
-- 1
-- 2

-- 2.4 Для однієї з таблиць створити команду отримання результату конкатенації значень будь-
-- яких двох колонок. При виведенні на початок рядка виведення додати літерал «UNION=».
SELECT 'UNION = ' || 'Amount of ' || name || ' on our storages is ' || amount AS message
FROM furniture;

-- Result :
-- MESSAGE
-- UNION = Amount of Bed N1 on our storages is 10
-- UNION = Amount of Table N1 on our storages is 35
-- UNION = Amount of Bed N2 on our storages is 30
-- UNION = Amount of Bed N3 on our storages is 30

-- 2.5 Модернізувати рішення завдання 2.2, отримавши в порядку зростання значення
-- псевдоніму.

SELECT id,
       name,
       type_code,
       amount / 100 AS amount_in_hudreds,
       price
FROM furniture
ORDER BY amount_in_hudreds ASC;

-- Result :
-- ID|NAME|TYPE_CODE|AMOUNT_IN_HUDREDS|PRICE
-- 1|Bed N1|1|0.1|7000.00
-- 4|Bed N3|1|0.3|9000.00
-- 3|Bed N2|1|0.3|13000.00
-- 2|Table N1|2|0.35|2500.00

-- 2.6 Для однієї з таблиць створити команду отримання значення двох колонок, значення
-- яких відсортовані в порядку зростання (для першої колонки) та в порядку зменшення (друга
-- колонка).

SELECT id,
       name,
       type_code,
       producer,
       amount,
       production_time,
       price,
       last_supply_date
FROM furniture
ORDER BY amount ASC,
         production_time DESC;

-- Result :
-- ID|NAME|TYPE_CODE|PRODUCER|AMOUNT|PRODUCTION_TIME|PRICE|LAST_SUPPLY_DATE
-- 1|Bed N1|1|Lviv factory|10|30|7000.00|<null>
-- 3|Bed N2|1|RRR Company|30|45|13000.00|<null>
-- 4|Bed N3|1|Based Corporation|30|60|9000.00|2022-01-30
-- 2|Table N1|2|Kyiv furniture|35|15|2500.00|<null>
