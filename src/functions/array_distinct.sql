-- Eliminate duplicate array values
CREATE OR REPLACE FUNCTION framework.array_distinct(
    in arr anyarray, -- input array
    in ignore_nulls boolean DEFAULT false, -- flag to ignore nulls
    in default_value anyarray DEFAULT ARRAY[]::TEXT[] -- default value if empty
) RETURNS anyarray AS $f$
    SELECT COALESCE((SELECT array_agg(DISTINCT x)
        FROM unnest(arr) t(x)
        WHERE CASE WHEN ignore_nulls THEN x IS NOT NULL ELSE true END), default_value);
$f$ LANGUAGE SQL IMMUTABLE;
