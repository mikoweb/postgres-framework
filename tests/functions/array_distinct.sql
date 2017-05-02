CREATE OR REPLACE FUNCTION unit_tests.array_distinct_test()
RETURNS test_result AS $$
    DECLARE arr text[];
    DECLARE message test_result;
BEGIN
    SELECT framework.array_distinct(ARRAY['foo', NULL, 'bar', 'foo', 'ok', 'bar'], TRUE) INTO arr;

    IF arr <> ARRAY['bar', 'foo', 'ok'] THEN
        SELECT assert.fail('Unexpected array value') INTO message;
        RETURN message;
    END IF;

    SELECT assert.ok('framework.array_distinct is OK') INTO message;
    RETURN message;
END;
$$ LANGUAGE plpgsql;
