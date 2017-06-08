CREATE OR REPLACE FUNCTION unit_tests.create_unique_name_test()
    RETURNS test_result AS $$
DECLARE message test_result;
    DECLARE result TEXT;
    DECLARE table_name TEXT = 'unit_tests.temp_create_unique_name';
    DECLARE col_name TEXT = 'name';
    DECLARE col_unique_name TEXT = 'unique_name';
BEGIN
    EXECUTE format('DROP TABLE IF EXISTS %s', table_name);
    EXECUTE format('CREATE TABLE IF NOT EXISTS %s (%s TEXT, %s TEXT)', table_name, col_name, col_unique_name);

    SELECT create_unique_name INTO result FROM framework.create_unique_name('test', table_name, col_name, col_unique_name);
    IF result <> 'test' THEN
        SELECT assert.fail('Expected "test" value is "' || result || '"') INTO message;
        EXECUTE format('DROP TABLE IF EXISTS %s', table_name);
        RETURN message;
    END IF;

    EXECUTE format('INSERT INTO %s (%s, %s) VALUES ($1, $2);', table_name, col_name, col_unique_name)
    USING 'test', 'test';
    SELECT create_unique_name INTO result FROM framework.create_unique_name('test', table_name, col_name, col_unique_name);
    IF result <> 'test-2' THEN
        SELECT assert.fail('Expected "test-2" value is "' || result || '"') INTO message;
        EXECUTE format('DROP TABLE IF EXISTS %s', table_name);
        RETURN message;
    END IF;

    EXECUTE format('INSERT INTO %s (%s, %s) VALUES ($1, $2);', table_name, col_name, col_unique_name)
    USING 'test', 'test-2';
    SELECT create_unique_name INTO result FROM framework.create_unique_name('test', table_name, col_name, col_unique_name);
    IF result <> 'test-3' THEN
        SELECT assert.fail('Expected "test-3" value is "' || result || '"') INTO message;
        EXECUTE format('DROP TABLE IF EXISTS %s', table_name);
        RETURN message;
    END IF;

    EXECUTE format('INSERT INTO %s (%s, %s) VALUES ($1, $2);', table_name, col_name, col_unique_name)
    USING 'test', 'test-3';
    SELECT create_unique_name INTO result FROM framework.create_unique_name('test', table_name, col_name, col_unique_name);
    IF result <> 'test-4' THEN
        SELECT assert.fail('Expected "test-4" value is "' || result || '"') INTO message;
        EXECUTE format('DROP TABLE IF EXISTS %s', table_name);
        RETURN message;
    END IF;

    EXECUTE format('INSERT INTO %s (%s, %s) VALUES ($1, $2);', table_name, col_name, col_unique_name)
    USING 'test-2', 'test-2';
    SELECT create_unique_name INTO result FROM framework.create_unique_name('test-2', table_name, col_name, col_unique_name);
    IF result <> 'test-2-3' THEN
        SELECT assert.fail('Expected "test-2-3" value is "' || result || '"') INTO message;
        EXECUTE format('DROP TABLE IF EXISTS %s', table_name);
        RETURN message;
    END IF;

    EXECUTE format('DROP TABLE IF EXISTS %s', table_name);
    SELECT assert.ok('framework.create_unique_name is OK') INTO message;
    RETURN message;
END;
$$ LANGUAGE plpgsql;
