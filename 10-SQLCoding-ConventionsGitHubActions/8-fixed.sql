SELECT
    id,
    name,
    price
FROM furniture
WHERE name LIKE 'Tab%';

SELECT
    id,
    name,
    price
FROM furniture
WHERE regexp_like(name, '^Tab');

SELECT
    id,
    name,
    price
FROM furniture
WHERE regexp_like(name, '[3-8]');

SELECT
    id,
    name,
    price
FROM furniture
WHERE regexp_like(name, '^[^3-8]*$');


SELECT
    id,
    name,
    price
FROM furniture
WHERE regexp_like(name, '[3-8]{3}');
