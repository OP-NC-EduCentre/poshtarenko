-- 4.1. Виконайте введення 5 рядків у таблицю бази даних із динамічною генерацією
-- команди. Значення первинного ключа генеруються автоматично, решта даних дублюється

DECLARE
    v_id           client.id%TYPE;
    v_name         client.name%TYPE;
    v_address      client.address%TYPE;
    v_phone_number client.phone_number%TYPE;
    v_birthday     client.birthday%TYPE;
    v_email        client.email%TYPE;
    insert_sql     VARCHAR2(500);
BEGIN
    insert_sql := 'INSERT INTO client (id, name, address, phone_number, birthday, email)'
        || ' VALUES(:1,:2,:3,:4,:5,:6)';
    FOR i IN 1..5
        LOOP
            v_id := client_id_seq.nextval;
            v_name := 'Max Stebelsky';
            v_address := 'Kyiv, Zalyznychna str. 15';
            v_phone_number := '+56(401)590-01-22';
            v_birthday := TO_DATE('03/02/1985', 'DD/MM/YYYY');
            v_email := 'stebelsky@ukr.com.ua';
            EXECUTE IMMEDIATE insert_sql
                USING v_id, v_name, v_address,
                v_phone_number, v_birthday, v_email;
        END LOOP;
END;
/

-- OK

-- 4.2. Скласти динамічний запит створення таблиці, іменами колонок якої будуть значення
-- будь-якої символьної колонки. Попередньо виконати перевірку існування таблиці з її
-- видаленням.

DROP TABLE producers;

DECLARE
    create_sql VARCHAR2(500);
BEGIN
    -- ініціалізація рядка з командою створення таблиці
    create_sql := 'CREATE TABLE producers (';
    FOR f_producer IN (SELECT DISTINCT producer FROM furniture)
        LOOP
        -- включення до рядка нового імені колонки
        -- як назви підрозділу та типом VARCHAR2(10)
            create_sql := create_sql || f_producer.producer
                || ' VARCHAR2(10),';
        END LOOP;
    create_sql := RTRIM(create_sql, ',') || ')';
    dbms_output.put_line(create_sql);
    EXECUTE IMMEDIATE create_sql;
END;
/

-- OK
-- CREATE TABLE producers (Lviv_factory VARCHAR2(10),Kyiv_furniture VARCHAR2(10),Based_Corporation VARCHAR2(10))

-- 4.3. Команда ALTER SEQUENCE може змінювати початкове значення генератора
-- починаючи з СУБД версії 12. Для ранніх версій доводиться виконувати дві команди: видалення
-- генератора та створення генератора з новим початковим значенням.
-- З урахуванням вашої предметної області створити анонімний PL/SQL-блок, який
-- викликатиме один із варіантів SQL-запитів зміни початкового значення генератора залежно від
-- значення версії СУБД.

DECLARE
    new_start_value    NUMBER(4) := 5;
    alter_sequence_sql VARCHAR2(500);
BEGIN
    dbms_output.put_line('Oracle version = ' || dbms_db_version.version);

    IF dbms_db_version.version >= 12 THEN
        alter_sequence_sql := 'ALTER SEQUENCE client_id_seq RESTART START WITH ' || new_start_value;
        EXECUTE IMMEDIATE alter_sequence_sql;
    ELSE
        alter_sequence_sql := 'DROP SEQUENCE client_id_seq';
        EXECUTE IMMEDIATE alter_sequence_sql;
        alter_sequence_sql := 'CREATE SEQUENCE client_id_seq START WITH ' || new_start_value;
        EXECUTE IMMEDIATE alter_sequence_sql;
    END IF;
    
    dbms_output.put_line(alter_sequence_sql);
END;
/

-- Oracle version = 18
-- ALTER SEQUENCE client_id_seq RESTART START WITH 5
