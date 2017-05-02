-- Convert json array to TEXT[]
CREATE OR REPLACE FUNCTION
    framework.array_from_json(in json_arr json)
RETURNS text[] AS $$
    DECLARE arr text[];
    DECLARE item json;
    DECLARE item_value text;
BEGIN
    arr := ARRAY[]::TEXT[];
    FOR item IN SELECT * FROM json_array_elements(json_arr)
    LOOP
        item_value := item::text;
        IF substring(item_value, 1, 1) <> '"' THEN
            RAISE EXCEPTION 'Element is not string'
            USING HINT = 'Acceptable only array of string. Found element value: ' || item_value;
        END IF;

        arr := array_append(arr, substring(item_value, 2, char_length(item_value) - 2));
    END LOOP;

    RETURN arr;
END
$$ LANGUAGE plpgsql;
