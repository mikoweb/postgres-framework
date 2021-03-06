-- http://stackoverflow.com/questions/2568842/jquery-url-validator
-- http://blog.mattheworiordan.com/post/13174566389/url-regular-expression-for-links-with-or-without
CREATE OR REPLACE FUNCTION
    framework.check_url(email text)
    RETURNS bool AS $$
BEGIN
    RETURN email ~* '((([A-Za-z]+:(?:\/\/)+)(?:[\-;:&=\+\$,\w]+@)?)(.)+)';
END
$$ LANGUAGE plpgsql;
