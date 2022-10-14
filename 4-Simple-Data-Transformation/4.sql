-- 4.1 Повторити рішення завдання 3.1

SELECT f.name,
       t.name
FROM furniture f,
     type t;

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

-- 4.2 Повторити рішення завдання 3.2

SELECT f.name AS "Furniture name",
       t.name AS "Type name"
FROM type t,
     furniture f
WHERE t.code = f.type_code;

-- Furniture name|Type name
-- Bed N1|Bed
-- Table N1|Table
-- Bed N2|Bed
-- Bed N3|Bed
-- Shelf N1|chair
-- Bed N4|Bed

-- 4.3 Повторити рішення завдання 3.4

SELECT t.name AS "Type name",
       f.name AS "Furniture name"
FROM type t,
     furniture f
WHERE t.code = f.type_code (+);

-- Type name|Furniture name
-- Bed|Bed N1
-- Table|Table N1
-- Bed|Bed N2
-- Bed|Bed N3
-- chair|Shelf N1
-- Bed|Bed N4
-- Shelf|<null>
-- Sofa|<null>
