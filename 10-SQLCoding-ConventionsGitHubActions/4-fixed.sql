SELECT
    furniture.name,
    type.name
FROM type
CROSS JOIN furniture;


SELECT
    furniture.item_name AS furniture_name,
    type.type_name AS type_name
FROM type
INNER JOIN furniture ON type.code = furniture.type_code;


SELECT
    type.item_name AS type_name,
    furniture.type_name AS furniture_name
FROM type
LEFT JOIN furniture ON type.code = furniture.type_code;
