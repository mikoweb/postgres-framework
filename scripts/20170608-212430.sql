-- Create unique string based first argument.
CREATE OR REPLACE FUNCTION
    framework.create_unique_name(
        value text, -- slug value
        table_name text, -- name of table
        col_name text, -- name of column with name
        col_unique_name text -- name of column with unique name
    )
    RETURNS text AS $$
DECLARE
    occurs int;
    new_value text;
BEGIN
    EXECUTE format('SELECT COUNT(*) FROM %s WHERE %s=$1 OR %s=$1', table_name, col_name, col_unique_name)
    INTO occurs
    USING value;

    IF occurs = 0
    THEN
        new_value = value;
    ELSE
        new_value = value;
        WHILE occurs > 0 LOOP
            new_value = new_value || '-' || cast((occurs + 1) as character varying);

            EXECUTE format('SELECT COUNT(*) FROM %s WHERE %s=$1 OR %s=$1', table_name, col_name, col_unique_name)
            INTO occurs
            USING new_value;
        END LOOP;
    END IF;

    RETURN new_value;
END;
$$ LANGUAGE plpgsql;
