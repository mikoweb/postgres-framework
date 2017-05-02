-- Eliminate duplicate array values
CREATE FUNCTION framework.array_distinct(
    anyarray, -- input array
    boolean DEFAULT false -- flag to ignore nulls
) RETURNS anyarray AS $f$
    SELECT array_agg(DISTINCT x)
    FROM unnest($1) t(x)
    WHERE CASE WHEN $2 THEN x IS NOT NULL ELSE true END;
$f$ LANGUAGE SQL IMMUTABLE;
