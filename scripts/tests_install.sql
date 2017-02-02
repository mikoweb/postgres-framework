CREATE OR REPLACE FUNCTION unit_tests.check_url_test()
RETURNS test_result AS $$
DECLARE message test_result;
DECLARE result boolean;
BEGIN
    SELECT check_url INTO result FROM framework.check_url('localhost');
    IF result = TRUE THEN
        SELECT assert.fail('Value "localhost" is invalid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_url INTO result FROM framework.check_url('http://');
    IF result = TRUE THEN
        SELECT assert.fail('Value "http://" is invalid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_url INTO result FROM framework.check_url('google.pl');
    IF result = TRUE THEN
        SELECT assert.fail('Value "google.pl" is invalid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_url INTO result FROM framework.check_url('www.google.pl');
    IF result = TRUE THEN
        SELECT assert.fail('Value "www.google.pl" is invalid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_url INTO result FROM framework.check_url('//google.pl');
    IF result = TRUE THEN
        SELECT assert.fail('Value "//google.pl" is invalid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_url INTO result FROM framework.check_url('http//google.pl');
    IF result = TRUE THEN
        SELECT assert.fail('Value "http//google.pl" is invalid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_url INTO result FROM framework.check_url('https://google.pl');
    IF result = FALSE THEN
        SELECT assert.fail('Value "https://google.pl" is valid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_url INTO result FROM framework.check_url('http://www.google.pl');
    IF result = FALSE THEN
        SELECT assert.fail('Value "http://www.google.pl" is valid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_url INTO result FROM framework.check_url('abcdefg://www.google.pl');
    IF result = FALSE THEN
        SELECT assert.fail('Value "abcdefg://www.google.pl" is valid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_url INTO result FROM framework.check_url('abcdefg://google.pl');
    IF result = FALSE THEN
        SELECT assert.fail('Value "abcdefg://google.pl" is valid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_url INTO result FROM framework.check_url('aąbcćdeęfg://aaałśóŋŋŋ.ąę');
    IF result = FALSE THEN
        SELECT assert.fail('Value "aąbcćdeęfg://aaałśóŋŋŋ.ąę" is valid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_url INTO result FROM framework.check_url('http://localhost/test/test?gfdgfdg#ok');
    IF result = FALSE THEN
        SELECT assert.fail('Value "http://localhost/test/test?gfdgfdg#ok" is valid url.') INTO message;
        RETURN message;
    END IF;

    SELECT assert.ok('framework.check_url is OK') INTO message;
    RETURN message;
END;
$$ LANGUAGE plpgsql;

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
