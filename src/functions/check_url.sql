-- RFC 3987
-- http://stackoverflow.com/questions/2568842/jquery-url-validator
-- http://blog.mattheworiordan.com/post/13174566389/url-regular-expression-for-links-with-or-without
CREATE OR REPLACE FUNCTION framework.check_url(email text) RETURNS bool AS $$
    return /((([A-Za-z]{3,9}:(?:\/\/)?)(?:[\-;:&=\+\$,\w]+@)?[A-Za-z0-9\.\-]+|(:www\.|[\-;:&=\+\$,\w]+@)[A-Za-z0-9\.\-]+)((?:\/[\+~%\/\.\w\-_]*)?\??(?:[\-\+=&;%@\.\w_]*)#?(?:[\.\!\/\\\w]*))?)/i.test(email);
$$ LANGUAGE plv8 IMMUTABLE STRICT;
