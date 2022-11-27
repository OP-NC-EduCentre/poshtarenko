SELECT
    id,
    name,
    type_code,
    producer,
    amount,
    production_time,
    price,
    last_supply_date
FROM furniture;

SELECT
    id,
    name,
    type_code,
    price,
    amount / 100 AS amount_in_hudreds
FROM furniture;

SELECT DISTINCT type_code
FROM furniture;

SELECT 'UNION = ' || 'Amount of ' || name || ' on our storages is ' || amount
    AS message
FROM furniture;

SELECT
    id,
    name,
    type_code,
    price,
    amount / 100 AS amount_in_hudreds
FROM furniture
ORDER BY amount_in_hudreds ASC;

SELECT
    id,
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
