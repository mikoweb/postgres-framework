-- Automatically update date columns
CREATE OR REPLACE FUNCTION framework.trf_created_at_and_updated_at() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        NEW.created_at = now();
    END IF;

    NEW.updated_at = now();

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
