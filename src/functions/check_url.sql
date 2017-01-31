-- RFC 3987
-- http://stackoverflow.com/questions/2568842/jquery-url-validator
-- http://blog.mattheworiordan.com/post/13174566389/url-regular-expression-for-links-with-or-without
CREATE OR REPLACE FUNCTION framework.check_url(email text) RETURNS bool AS $$
    return /((([A-Za-z]+:(?:\/\/)?)(?:[\-;:&=\+\$,\w]+@)?)(.)+)/i.test(email);
$$ LANGUAGE plv8 IMMUTABLE STRICT;
