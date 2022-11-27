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
WHERE producer = 'Lviv factory';

SELECT
    furniture_id,
    name,
    type_code,
    producer,
    amount,
    production_time,
    price,
    las_supply_date
FROM furniture_lviv_factory_list;

UPDATE furniture_lviv_factory_list
SET amount = amount - 1
WHERE name = 'Bed N1';

SELECT
    furniture_id,
    name,
    type_code,
    producer,
    amount,
    production_time,
    price,
    las_supply_date
FROM furniture_lviv_factory_list;

CREATE OR REPLACE VIEW furniture_type
(furniture_name,
 type_name)
AS
SELECT
    furniture.name,
    type.name
FROM type
INNER JOIN furniture ON type.code = furniture.type_code;

SELECT
    furniture_name,
    type_name
FROM furniture_type;

INSERT
INTO furniture_type (furniture_type.furniture_name, furniture_type.type_name)
VALUES ('Bed x1', 'Bed')
