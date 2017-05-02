CREATE OR REPLACE FUNCTION unit_tests.array_from_json_test()
RETURNS test_result AS $$
    DECLARE arr text[];
    DECLARE message test_result;
BEGIN
    SELECT framework.array_from_json('["foo", "bar"]') INTO arr;

    IF arr <> ARRAY['foo', 'bar'] THEN
        SELECT assert.fail('Unexpected array value') INTO message;
        RETURN message;
    END IF;

    SELECT assert.ok('framework.array_distinct is OK') INTO message;
    RETURN message;
END;
$$ LANGUAGE plpgsql;
