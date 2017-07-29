-- http://stackoverflow.com/questions/2568842/jquery-url-validator
-- http://blog.mattheworiordan.com/post/13174566389/url-regular-expression-for-links-with-or-without
CREATE OR REPLACE FUNCTION
    framework.check_http_url(url text)
    RETURNS bool AS $$
BEGIN
    RETURN url ~* '((((http|https)+:(?:\/\/)+)(?:[\-;:&=\+\$,\w]+@)?)(.)+)';
END
$$ LANGUAGE plpgsql;
