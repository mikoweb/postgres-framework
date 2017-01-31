DO $$
DECLARE plv8_exists integer;
BEGIN
    SELECT COUNT(name) INTO plv8_exists FROM pg_available_extensions() WHERE name = 'plv8';
    IF plv8_exists = 0 THEN
        RAISE EXCEPTION 'Extension plv8 is not installed. Please run: sudo apt-get install postgresql-{your-postgresql-version-here}-plv8';
    END IF;
END $$;

CREATE EXTENSION IF NOT EXISTS "plv8";
CREATE SCHEMA IF NOT EXISTS framework;
