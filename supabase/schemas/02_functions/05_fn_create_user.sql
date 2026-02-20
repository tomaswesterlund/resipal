CREATE OR REPLACE FUNCTION fn_create_user(p_name text, p_email text, p_phone_number text)
RETURNS void
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO users (name, email, phone_number)
    VALUES (p_name, p_email, p_phone_number);
END;
$$;