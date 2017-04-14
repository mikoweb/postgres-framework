CREATE OR REPLACE FUNCTION unit_tests.check_http_url_test()
RETURNS test_result AS $$
DECLARE message test_result;
DECLARE result boolean;
BEGIN
    SELECT check_http_url INTO result FROM framework.check_http_url('localhost');
    IF result = TRUE THEN
        SELECT assert.fail('Value "localhost" is invalid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_http_url INTO result FROM framework.check_http_url('http://');
    IF result = TRUE THEN
        SELECT assert.fail('Value "http://" is invalid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_http_url INTO result FROM framework.check_http_url('google.pl');
    IF result = TRUE THEN
        SELECT assert.fail('Value "google.pl" is invalid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_http_url INTO result FROM framework.check_http_url('www.google.pl');
    IF result = TRUE THEN
        SELECT assert.fail('Value "www.google.pl" is invalid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_http_url INTO result FROM framework.check_http_url('//google.pl');
    IF result = TRUE THEN
        SELECT assert.fail('Value "//google.pl" is invalid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_http_url INTO result FROM framework.check_http_url('http//google.pl');
    IF result = TRUE THEN
        SELECT assert.fail('Value "http//google.pl" is invalid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_http_url INTO result FROM framework.check_http_url('https://google.pl');
    IF result = FALSE THEN
        SELECT assert.fail('Value "https://google.pl" is valid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_http_url INTO result FROM framework.check_http_url('http://www.google.pl');
    IF result = FALSE THEN
        SELECT assert.fail('Value "http://www.google.pl" is valid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_http_url INTO result FROM framework.check_http_url('abcdefg://www.google.pl');
    IF result = TRUE THEN
        SELECT assert.fail('Value "abcdefg://www.google.pl" is invalid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_http_url INTO result FROM framework.check_http_url('abcdefg://google.pl');
    IF result = TRUE THEN
        SELECT assert.fail('Value "abcdefg://google.pl" is invalid url.') INTO message;
        RETURN message;
    END IF;

    SELECT check_http_url INTO result FROM framework.check_http_url('http://localhost/test/test?gfdgfdg#ok');
    IF result = FALSE THEN
        SELECT assert.fail('Value "http://localhost/test/test?gfdgfdg#ok" is valid url.') INTO message;
        RETURN message;
    END IF;

    SELECT assert.ok('framework.check_http_url is OK') INTO message;
    RETURN message;
END;
$$ LANGUAGE plpgsql;
