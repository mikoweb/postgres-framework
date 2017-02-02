CREATE OR REPLACE FUNCTION unit_tests.create_unique_name_test()
    RETURNS test_result AS $$
DECLARE message test_result;
    DECLARE result TEXT;
    DECLARE table_name TEXT = 'unit_tests.temp_create_unique_name';
    DECLARE col_name TEXT = 'name';
BEGIN
    EXECUTE format('DROP TABLE IF EXISTS %s', table_name);
    EXECUTE format('CREATE TABLE IF NOT EXISTS %s (%s TEXT)', table_name, col_name);

    SELECT create_unique_name INTO result FROM framework.create_unique_name('test', table_name, col_name);
    IF result <> 'test' THEN
        SELECT assert.fail('Expected "test" value.') INTO message;
        EXECUTE format('DROP TABLE IF EXISTS %s', table_name);
        RETURN message;
    END IF;

    EXECUTE format('INSERT INTO %s (%s) VALUES ($1);', table_name, col_name)
    USING 'test';
    SELECT create_unique_name INTO result FROM framework.create_unique_name('test', table_name, col_name);
    IF result <> 'test-1' THEN
        SELECT assert.fail('Expected "test-1" value.') INTO message;
        EXECUTE format('DROP TABLE IF EXISTS %s', table_name);
        RETURN message;
    END IF;

    EXECUTE format('INSERT INTO %s (%s) VALUES ($1);', table_name, col_name)
    USING 'test';
    SELECT create_unique_name INTO result FROM framework.create_unique_name('test', table_name, col_name);
    IF result <> 'test-2' THEN
        SELECT assert.fail('Expected "test-2" value.') INTO message;
        EXECUTE format('DROP TABLE IF EXISTS %s', table_name);
        RETURN message;
    END IF;

    EXECUTE format('INSERT INTO %s (%s) VALUES ($1);', table_name, col_name)
    USING 'test';
    SELECT create_unique_name INTO result FROM framework.create_unique_name('test', table_name, col_name);
    IF result <> 'test-3' THEN
        SELECT assert.fail('Expected "test-3" value.') INTO message;
        EXECUTE format('DROP TABLE IF EXISTS %s', table_name);
        RETURN message;
    END IF;

    EXECUTE format('DROP TABLE IF EXISTS %s', table_name);
    SELECT assert.ok('framework.create_unique_name is OK') INTO message;
    RETURN message;
END;
$$ LANGUAGE plpgsql;
