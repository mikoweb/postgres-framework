-- Create unique string based first argument.
CREATE OR REPLACE FUNCTION
    framework.create_unique_name(
        value text, -- slug value
        table_name text, -- name of table
        col_name text -- name of column
    )
    RETURNS text AS $$
DECLARE
    occurs int;
BEGIN
    EXECUTE format('SELECT COUNT(*) FROM %s WHERE %s=$1', table_name, col_name)
    INTO occurs
    USING value;

    IF occurs = 0
    THEN
        RETURN value;
    ELSE
        RETURN value || '-' || cast(occurs as character varying);
    END IF;
END;
$$ LANGUAGE plpgsql;
